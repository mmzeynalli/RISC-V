import common::*;

module control_unit import common::*; (
        input [6:0] opcode,
        input instruction_op_type optype,
        input [2:0] funct3,
        input [31:0] rs1_data,
        input [31:0] rs2_data,

        output logic ctrl_mem_write,
        output logic ctrl_mem2reg,
        output logic ctrl_reg_write,

        output logic ctrl_alu_src,

        output logic ctrl_is_branch,
        output logic ctrl_is_jump,
        output logic ctrl_branch_taken
);

logic ctrl_zero_flag, ctrl_lt_flag, ctrl_ltu_flag, ctrl_gte_flag, ctrl_gteu_flag;

always_comb begin : generate_signals
        ctrl_zero_flag = (rs1_data == rs2_data) ? 1 : 0;
        ctrl_lt_flag = (rs1_data < rs2_data) ? 1 : 0;
        ctrl_ltu_flag = (unsigned'(rs1_data) == unsigned'(rs2_data)) ? 1 : 0;
        ctrl_gte_flag = (rs1_data >= rs2_data) ? 1 : 0;
        ctrl_gteu_flag = (unsigned'(rs1_data) >= unsigned'(rs2_data)) ? 1 : 0;

        ctrl_mem_write <= '0;
        ctrl_mem2reg <= '0;
        ctrl_reg_write <= '0;
        ctrl_is_branch <= '0;
        ctrl_alu_src <= '0;
        ctrl_is_jump <= '0;
        ctrl_branch_taken <= '0;

        case (optype)
                R_TYPE:
                        ctrl_reg_write <= 1;
                I_TYPE:
                begin
                        ctrl_reg_write <= 1;
                        ctrl_alu_src <= 1;

                        if (opcode == LOAD || opcode == LOAD_FP) begin
                                ctrl_mem2reg <= 1;
                        end
                end
                S_TYPE:
                begin
                        ctrl_alu_src <= 1;
                        ctrl_mem_write <= 1;
                end
                B_TYPE:
                begin
                        ctrl_is_branch <= 1;

                        if ((funct3 == BEQ && ctrl_zero_flag == 1) ||
                        (funct3 == BNE && ctrl_zero_flag != 1) ||
                        (funct3 == BLT && ctrl_lt_flag == 1) ||
                        (funct3 == BGE && ctrl_gte_flag == 1) ||
                        (funct3 == BLTU && ctrl_ltu_flag == 1) ||
                        (funct3 == BGEU && ctrl_gteu_flag == 1))
                                ctrl_branch_taken <= 1;
                end
                U_TYPE:
                        if (opcode == U_LUI) begin
                                ctrl_mem2reg <= 1;
                        end
                J_TYPE:
                begin
                        ctrl_branch_taken <= 1;
                end
                default:
                        $error("Unknown optype!");
        endcase
end

endmodule
