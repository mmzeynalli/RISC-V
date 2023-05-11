import common::*;

module execute import common::*; (
        // input [OPERAND_WIDTH-1:0] from_ex,
        // input [OPERAND_WIDTH-1:0] from_wb,
        input instruction_op_type optype,
        input [2:0] funct3,
        input [6:0] funct7,

        input [OPERAND_WIDTH-1:0] imm,
        input [DATA_WIDTH-1:0] rs1_data,
        input [DATA_WIDTH-1:0] rs2_data,

        // Controls
        input ctrl_alu_src,

        output [OPERAND_WIDTH-1:0] alu_result
);

logic [OPERAND_WIDTH-1:0] operand_A;
logic [OPERAND_WIDTH-1:0] operand_B;

alu_operation_type alu_op;
logic is_zero;

alu_ctrl alu_ctrl(
        .funct3(funct3),
        .funct7(funct7),
        .optype(optype),
        .op(alu_op)
);

ALU alu(
        .A(operand_A),
        .B(operand_B),
        .operation(alu_op),
        .zero(is_zero),
        .result(alu_result)
)

always_comb begin : select_operands
        operand_A <= rs1_data;  // Later from_mem and from_wb
        operand_B <= (ctrl_alu_src == 0) ? rs2_data : imm;
end
        
endmodule
