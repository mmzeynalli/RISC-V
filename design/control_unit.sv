import common::*;

module control_unit import common::*; (
        input [6:0] opcode,
        input instruction_op_type optype,
        input [2:0] funct3,
        input [31:0] rf1,
        input [31:0] rf2,

        output logic control_mem_write,
        output logic control_mem_read,
        output logic control_mem_to_reg,
        output logic control_reg_wr_en,

        output logic control_zero_flag,
        output logic control_lt_flag,
        output logic control_ltu_flag,
        output logic control_gte_flag,
        output logic control_gteu_flag,

        output logic control_alu_src,
        output logic control_is_branch,
        output logic control_is_jump,
        output logic control_is_return,
        output logic control_branch_taken,
        output logic control_jump_taken,

        output logic control_is_signed_imm
);

initial begin
        control_mem_write = 1'b0;
        control_mem_read = 1'b0;
        control_mem_to_reg = 1'b0;
        control_reg_wr_en = 1'b0;
        control_is_branch = 1'b0;
        control_alu_src = 1'b0;
        control_is_jump = 1'b0;
        control_is_return = 1'b0;
        control_branch_taken = 1'b0;
        control_jump_taken = 1'b0;
        control_is_signed_imm = 1'b0;
end

always @(*) begin : generate_signals
        control_zero_flag = (rf1 == rf2) ? 'b1 : 'b0;
        control_lt_flag = (rf1 < rf2) ? 'b1 : 'b0;
        control_ltu_flag = (unsigned'(rf1) == unsigned'(rf2)) ? 'b1 : 'b0;
        control_gte_flag = (rf1 >= rf2) ? 'b1 : 'b0;
        control_gteu_flag = (unsigned'(rf1) >= unsigned'(rf2)) ? 'b1 : 'b0;

        case (optype)
                R_TYPE:
                        control_reg_wr_en = 1'b1;
                I_TYPE:
                begin
                        control_reg_wr_en = 1'b1;
                        control_alu_src = 1'b1;

                        if (opcode == LOAD || opcode == LOAD_FP) begin
                                control_mem_read = 1'b1;
                                control_mem_to_reg = 1'b1;
                        end
                end
                S_TYPE:
                begin
                        control_alu_src = 1'b1;
                        control_mem_write = 1'b1;
                end
                B_TYPE:
                begin
                        control_is_branch = 1'b1;

                        if ((funct3 == BEQ && control_zero_flag == 1'b1) ||
                        (funct3 == BNE && control_zero_flag != 1'b1) ||
                        (funct3 == BLT && control_lt_flag == 1'b1) ||
                        (funct3 == BGE && control_gte_flag == 1'b1) ||
                        (funct3 == BLTU && control_ltu_flag == 1'b1) ||
                        (funct3 == BGEU && control_gteu_flag == 1'b1))
                                control_branch_taken = 1'b1;
                end
                U_TYPE:
                        if (opcode == U_LUI) begin
                                control_mem_read = 1'b1;
                                control_mem_to_reg = 1'b1;
                        end
                J_TYPE:
                begin
                        control_is_jump = 1'b1;
                        control_jump_taken = 1'b1;
                end
                default:
                        $error("Unknown optype!");
        endcase
end

endmodule
