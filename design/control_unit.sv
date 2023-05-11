import common::*;

module ctrl_unit import common::*; (
        input [6:0] opcode,
        input instruction_op_type optype,
        input [2:0] funct3,
        input [31:0] rs1_data,
        input [31:0] rs2_data,

        output logic ctrl_mem_write,
        output logic ctrl_mem_read,
        output logic ctrl_mem_to_reg,
        output logic ctrl_reg_wr_en,

        output logic ctrl_zero_flag,
        output logic ctrl_lt_flag,
        output logic ctrl_ltu_flag,
        output logic ctrl_gte_flag,
        output logic ctrl_gteu_flag,

        output logic ctrl_alu_src,
        output logic ctrl_is_signed_imm,

        output logic ctrl_is_branch,
        output logic ctrl_is_jump,
        output logic ctrl_is_return,
        output logic ctrl_branch_taken,
        output logic ctrl_jump_taken
);

initial begin
        ctrl_mem_write <= '0;
        ctrl_mem_read <= '0;
        ctrl_mem_to_reg <= '0;
        ctrl_reg_wr_en <= '0;
        ctrl_is_branch <= '0;
        ctrl_alu_src <= '0;
        ctrl_is_jump <= '0;
        ctrl_is_return <= '0;
        ctrl_branch_taken <= '0;
        ctrl_jump_taken <= '0;
        ctrl_is_signed_imm <= '0;
end

always @(*) begin : generate_signals
        ctrl_zero_flag = (rs1_data == rs2_data) ? 'b1 : 'b0;
        ctrl_lt_flag = (rs1_data < rs2_data) ? 'b1 : 'b0;
        ctrl_ltu_flag = (unsigned'(rs1_data) == unsigned'(rs2_data)) ? 'b1 : 'b0;
        ctrl_gte_flag = (rs1_data >= rs2_data) ? 'b1 : 'b0;
        ctrl_gteu_flag = (unsigned'(rs1_data) >= unsigned'(rs2_data)) ? 'b1 : 'b0;

        case (optype)
                R_TYPE:
                        ctrl_reg_wr_en = 1'b1;
                I_TYPE:
                begin
                        ctrl_reg_wr_en = 1'b1;
                        ctrl_alu_src = 1'b1;

                        if (opcode == LOAD || opcode == LOAD_FP) begin
                                ctrl_mem_read = 1'b1;
                                ctrl_mem_to_reg = 1'b1;
                        end
                end
                S_TYPE:
                begin
                        ctrl_alu_src = 1'b1;
                        ctrl_mem_write = 1'b1;
                end
                B_TYPE:
                begin
                        ctrl_is_branch = 1'b1;

                        if ((funct3 == BEQ && ctrl_zero_flag == 1'b1) ||
                        (funct3 == BNE && ctrl_zero_flag != 1'b1) ||
                        (funct3 == BLT && ctrl_lt_flag == 1'b1) ||
                        (funct3 == BGE && ctrl_gte_flag == 1'b1) ||
                        (funct3 == BLTU && ctrl_ltu_flag == 1'b1) ||
                        (funct3 == BGEU && ctrl_gteu_flag == 1'b1))
                                ctrl_branch_taken = 1'b1;
                end
                U_TYPE:
                        if (opcode == U_LUI) begin
                                ctrl_mem_read = 1'b1;
                                ctrl_mem_to_reg = 1'b1;
                        end
                J_TYPE:
                begin
                        ctrl_is_jump = 1'b1;
                        ctrl_jump_taken = 1'b1;
                end
                default:
                        $error("Unknown optype!");
        endcase
end

endmodule
