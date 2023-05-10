import common::*;

module execute import common::*; (
        input [OPERAND_WIDTH-1:0] from_ex,
        input [OPERAND_WIDTH-1:0] from_wb,
        input [OPERAND_WIDTH-1:0] imm,
        input alu_operation_type alu_op,
        
        // Inputs just for next stage
        input [DATA_WIDTH-1:0] i_rf_data2,
        input [4:0] i_rd,

        output [OPERAND_WIDTH-1:0] alu_result,
        output [DATA_WIDTH-1:0] o_rf_data2,
        output [4:0] o_rd
);

wire [OPERAND_WIDTH-1:0] operand_A;
wire [OPERAND_WIDTH-1:0] operand_B;


always_comb begin : execution
        
end
        
endmodule
