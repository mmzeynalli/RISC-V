import common::*;

module execute import common::*; (
        input instruction_format_type opcode,
        input  logic [PROGRAM_ADDRESS_WIDTH-1:0] i_pc,
        input [2:0] funct3,
        input [6:0] funct7,

        input [IMM_WIDTH-1:0] imm,
        input [DATA_WIDTH-1:0] rs1_data,
        input [DATA_WIDTH-1:0] rs2_data,
        input [OPERAND_WIDTH-1:0] from_mem,
        input [OPERAND_WIDTH-1:0] from_wb,

        input ctrl_AUIPC_taken,

        // Controls
        input ctrl_alu_src,
        input forwarding_type ctrl_forward_left_operand,
        input forwarding_type ctrl_forward_right_operand,

        output logic [OPERAND_WIDTH-1:0] alu_result,
        output logic [OPERAND_WIDTH-1:0] write_data
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

        operand_A = rs1_data;

        case (ctrl_forward_left_operand)
                EX_MEM:
                        operand_A = from_mem;
                MEM_WB:
                        operand_A = from_wb;
        endcase

        operand_B = rs2_data;
        
        // Intermediate value of operand_B, which is also write_data
        case (ctrl_forward_right_operand)
                EX_MEM:
                        operand_B = from_mem;
                MEM_WB:
                        operand_B = from_wb;
        endcase

        write_data = operand_B;

        // Final operand_B
        if (ctrl_alu_src == 1)
                operand_B = 32'(signed'(imm));
        if (ctrl_AUIPC_taken == 1)
                operand_A = i_pc;
end
        
endmodule
