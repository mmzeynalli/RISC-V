import common::*;

module alu_ctrl import common::*; (
        input [2:0]                     funct3,
        input [6:0]                     funct7,
        input instruction_format_type   opcode,
        output alu_operation_type       op
);

always_comb begin : get_alu_op

        op <= ADD;

        if (opcode == OP || opcode == OP_IMM)
                case (funct3)
                        3'b001:
                                op <= SLL;
                        3'b101: 
                        begin
                                if (funct7 == 7'b010_0000)
                                        op <= SRL;
                                else if (funct7 == 7'b0000000)
                                        op <= SRA;
                        end
                        3'b000:
                        begin
                                op <= ADD;

                                if (funct7 == 7'b010_0000)
                                        op <= SUB;
                        end
                        3'b100:
                                op <= XOR;
                        3'b110:
                                op <= OR;
                        3'b111:
                                op <= AND;
                        3'b010:
                                op <= SLT;
                        3'b011:
                                op <= SLTU;
                        default: 
                                $error("No such operation!");

                endcase
end

endmodule
