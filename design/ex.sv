import common::*;

module execute import common::*; (
        // input [OPERAND_WIDTH-1:0] from_ex,
        // input [OPERAND_WIDTH-1:0] from_wb,
        input [2:0] funct3,
        input [6:0] funct7,

        input [OPERAND_WIDTH-1:0] imm,
        input [DATA_WIDTH-1:0] rs2_data,

        // Controls
        input ctrl_alu_src,
        input ctrl_is_signed_imm,

        output [OPERAND_WIDTH-1:0] alu_result
);

logic [OPERAND_WIDTH-1:0] operand_A;
logic [OPERAND_WIDTH-1:0] operand_B;


always_comb begin : execution
        
end
        
endmodule
