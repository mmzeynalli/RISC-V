import common::*;

module instruction_decode (
        input [6:0] opcode,
        input instruction_op_type optype,
        input [2:0] funct3, // ??

        // TODO: Any other way? Maybe as output from ALU
        input [31:0] rf1,
        input [31:0] rf2,

        output reg control_mem_write,
        output reg control_mem_read,
        output reg control_reg_wr_en,

        output reg control_zero_flag,
        output reg control_lt_flag,
        output reg control_ltu_flag,
        output reg control_gte_flag,
        output reg control_gteu_flag,

        output reg control_mem_to_reg,
        output reg control_is_branch,
        output reg control_is_jump,
        output reg control_is_return,
        output reg control_branch_taken,

        output reg control_is_signed_imm
);

always_comb begin : generate_signals
        control_mem_read = (opcode == LOAD || opcode == LOAD_FP || opcode == U_LUI) ? 'b1 : 'b0;
        control_mem_write = (optype == S_TYPE) ? 'b1 : 'b0;
        control_reg_wr_en = (optype == R_TYPE);

        control_zero_flag = (rf1 == rf2) ? 'b1 : 'b0;
        control_lt_flag = (rf1 < rf2) ? 'b1 : 'b0;
        control_ltu_flag = (unsigned'(rf1) == unsigned'(rf2)) ? 'b1 : 'b0;
        control_gte_flag = (rf1 >= rf2) ? 'b1 : 'b0;
        control_gteu_flag = (unsigned'(rf1) >= unsigned'(rf2)) ? 'b1 : 'b0;

        control_branch_taken = (optype == B_TYPE && (
                        (funct3 == BEQ && control_zero_flag == 'b1) ||
                        (funct3 == BNE && control_zero_flag != 'b1) ||
                        (funct3 == BLT && control_lt_flag == 'b1) ||
                        (funct3 == BGE && control_gte_flag == 'b1) ||
                        (funct3 == BLTU && control_ltu_flag == 'b1) ||
                        (funct3 == BGEU && control_gteu_flag == 'b1))
                        ) ? 'b1 : 'b0;
end

endmodule
