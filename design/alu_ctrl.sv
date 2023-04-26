import common::*;

module alu_ctrl (
        input [2:0]                     func3,
        input [6:0]                     func7,
        input instruction_op_type       optype,
        output logic [4:0]              op
);

always_comb begin : get_alu_op

        case (func3)
                3'b001:
                        op = SLL;
                3'b101: 
                begin
                        if (func7 == 7'b0100000)
                                op = SRL;
                        else if (func7 == 7'b0000000)
                                op = SRA;
                end
                3'b000:
                begin
                        op = ADD;

                        if (optype == R_TYPE && func7 == 7'b0100000)
                                op = SUB;
                end
                3'b100:
                        op = XOR;
                3'b110:
                        op = OR;
                3'b111:
                        op = AND;
                3'b010:
                        op = SLT;
                3'b011:
                        op = SLTU;
                default: 
                        $error("No such operation!");

        endcase
end

endmodule