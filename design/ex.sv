import common::*;

module execute import common::*; (
        input instruction_format_type opcode,
        input [2:0] funct3,
        input [6:0] funct7,

        input [IMM_WIDTH-1:0] imm,
        input [DATA_WIDTH-1:0] rs1_data,
        input [DATA_WIDTH-1:0] rs2_data,
        input [OPERAND_WIDTH-1:0] from_mem,
        input [OPERAND_WIDTH-1:0] from_wb,

        // Controls
        input ctrl_alu_src,
        input forwarding_type ctrl_forward_left_operand,
        input forwarding_type ctrl_forward_right_operand,

        output [OPERAND_WIDTH-1:0] alu_result
);

logic [OPERAND_WIDTH-1:0] operand_A;
logic [OPERAND_WIDTH-1:0] operand_B;

alu_operation_type alu_op;
logic is_zero;

alu_ctrl alu_ctrl(
        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode),
        .op(alu_op)
);

ALU alu(
        .A(operand_A),
        .B(operand_B),
        .operation(alu_op),
        .zero(is_zero),
        .result(alu_result)
);

always_comb begin : select_operands

        case (ctrl_forward_left_operand)
                NONE:
                        operand_A <= rs1_data;
                EX_MEM:
                        operand_A <= from_mem;
                MEM_WB:
                        operand_A <= from_wb;
                default: 
        endcase

        case (ctrl_forward_right_operand)
                NONE:
                        operand_B <= (ctrl_alu_src == 0) ? rs2_data : 32'(signed'(imm));
                EX_MEM:
                        operand_B <= from_mem;
                MEM_WB:
                        operand_B <= from_wb;
                default: 
        endcase
end
        
endmodule
