import common::*;

module alu_ctrl (
        input [2:0]                 func3,
        input [6:0]                 func7,
        output alu_operation_type   op
);

always_comb begin : get_alu_op
    case ({func7, func3})
        10'b0000000_001: 
                op = SLL;
        10'b0000000_101:
                op = SRL;
        10'b0100000_101:
                op = SRA;
        10'b0000000_000:
                op = ADD;
        10'b0100000_000:
                op = SUB;
        10'b0100000_100:
                op = XOR;
        10'b0000000_110:
                op = OR;
        10'b0000000_111:
                op = AND;
        10'b0000000_010:
                op = SLT;
        10'b0000000_011:
                op = SLTU;
        default:
                $error("No such operation!");
    endcase
end

endmodule