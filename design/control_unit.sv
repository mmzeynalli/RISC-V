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
        output reg control_mem_to_reg,
        output reg control_reg_wr_en,

        output reg control_zero_flag,
        output reg control_lt_flag,
        output reg control_ltu_flag,
        output reg control_gte_flag,
        output reg control_gteu_flag,

        output reg control_alu_src,
        output reg control_is_branch,
        output reg control_is_jump,
        output reg control_is_return,
        output reg control_branch_taken,

        output reg control_is_signed_imm
);

initial begin
        control_mem_write = 1'b0;
        control_mem_read = 1'b0;
        control_mem_to_reg = 1'b0;
        control_reg_wr_en = 1'b0;
        control_zero_flag = 1'b0;
        control_is_branch = 1'b0;
        control_alu_src = 1'b0;
        control_is_jump = 1'b0;
        control_is_return = 1'b0;
        control_branch_taken = 1'b0;
        control_is_signed_imm = 1'b0;
end

always_comb begin : generate_signals

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
                        control_is_branch = 1'b1;

                        if ((funct3 == BEQ && control_zero_flag == 1'b1) ||
                        (funct3 == BNE && control_zero_flag != 1'b1) ||
                        (funct3 == BLT && control_lt_flag == 1'b1) ||
                        (funct3 == BGE && control_gte_flag == 1'b1) ||
                        (funct3 == BLTU && control_ltu_flag == 1'b1) ||
                        (funct3 == BGEU && control_gteu_flag == 1'b1))
                                control_branch_taken = 1'b1;

                U_TYPE:
                        if (opcode == U_LUI) begin
                                control_mem_read = 1'b1;
                                control_mem_to_reg = 1'b1;
                        end
                J_TYPE:
                        control_is_jump = 1'b1;
                default: 
        endcase

        control_mem_read = (opcode == LOAD || opcode == LOAD_FP || opcode == U_LUI) ? 'b1 : 'b0;
        control_mem_write = (optype == S_TYPE) ? 'b1 : 'b0;
        control_mem_to_reg = (op == LOAD) ? 'b1 : 'b0;
        control_reg_wr_en = (optype == R_TYPE) ? 'b1 : 'b0;

        

        control_branch_taken = (optype == B_TYPE && (
                        
                        ) ? 'b1 : 'b0;
end

endmodule
