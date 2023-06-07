import common::*;

module alu_ctrl import common::*; (
        input [2:0]                     funct3,
        input [6:0]                     funct7,
        input instruction_format_type   opcode,
        output alu_operation_type       op
);

const logic [6:0] M_TYPE = 7'b0000001;

always_comb begin : get_alu_op

        op <= ADD;

        if (opcode == OP || opcode == OP_IMM)
                case (funct3)
                        3'b001:
                                op <= SLL;
                        3'b101: 
                        begin
                                op <= SRA;
                                
                                if (funct7 == 7'b010_0000)
                                        op <= SRL;
                                else if (funct7 == M_TYPE)
                                        op <= DIVU;
                        end
                        3'b000:
                        begin
                                op <= ADD;

                                if (funct7 == 7'b010_0000)
                                        op <= SUB;
                        end
                        3'b100:
                        begin
                                op <= XOR;
                                
                                if (funct7 == M_TYPE)
                                        op <= DIV;
                        end
                        3'b110:
                        begin
                                op <= OR;

                                if (funct7 == M_TYPE)
                                        op <= REM;
                        end
                        3'b111:
                        begin
                                op <= AND;

                                if (funct7 == M_TYPE)
                                        op <= REMU;
                        end
                        3'b010:
                                op <= SLT;
                        3'b011:
                                op <= SLTU;
                        default: 
                                $error("No such operation!");
                endcase

        else if(opcode == U_LUI)
                op <= LUI;
        else if(opcode == U_AUIPC)
                op <= AUIPC;  // Can be ADD, but this is more explicit
end

endmodule
