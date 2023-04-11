import common::*;

module moduleName #(
        int DATA_WIDTH = 32;
) (
        input [3:0]             operation;
        input [DATA_WIDTH-1:0]  left_operand;
        input [DATA_WIDTH-1:0]  right_operand;

        output                  zero;
        output [DATA_WIDTH-1:0] result;
);


wire [DATA_WIDTH-1:0] alu_result;

always_comb begin : ALU

        case (operation)
                AND: alu_result = left_operand & right_operand;
                OR: alu_result = left_operand | right_operand;
                default: 
                        $error("No such operation!!, %d\n", operation)
        endcase
end


result = alu_result;
zero = signed(alu_result) == 0 ? 'b1  : 'b0;

endmodule
