import common::*;

module control_unit import common::*; (
        input instruction_format_type opcode,
        input instruction_op_type optype,
        input [2:0] funct3,
        input [31:0] rs1_data,
        input [31:0] rs2_data,

        output logic ctrl_mem_write,
        output logic ctrl_mem2reg,
        output logic ctrl_reg_write,

        output logic ctrl_alu_src,

        output logic ctrl_is_branch,
        output logic ctrl_branch_taken,
        output logic ctrl_AUIPC_taken,
        output logic [2:0] ctrl_word_size
);

logic ctrl_zero_flag, ctrl_lt_flag, ctrl_ltu_flag, ctrl_gte_flag, ctrl_gteu_flag;

always_comb begin : generate_signals
        ctrl_zero_flag = (rs1_data == rs2_data) ? 1 : 0;
        ctrl_lt_flag = (rs1_data < rs2_data) ? 1 : 0;
        ctrl_ltu_flag = (unsigned'(rs1_data) == unsigned'(rs2_data)) ? 1 : 0;
        ctrl_gte_flag = (rs1_data >= rs2_data) ? 1 : 0;
        ctrl_gteu_flag = (unsigned'(rs1_data) >= unsigned'(rs2_data)) ? 1 : 0;

        ctrl_mem_write = 0;
        ctrl_mem2reg = 0;
        ctrl_reg_write = 0;
        ctrl_is_branch = 0;
        ctrl_alu_src = 0;
        ctrl_branch_taken = 0;
        ctrl_AUIPC_taken = 0;
        ctrl_word_size = 3'b0;

        case (optype)
                R_TYPE:
                        ctrl_reg_write <= 1;
                I_TYPE:
                begin
                        ctrl_reg_write <= 1;
                        ctrl_alu_src <= 1;                               
                
                        if (opcode == LOAD || opcode == LOAD_FP) begin
                                ctrl_mem2reg <= 1;
                                ctrl_word_size = funct3;
                        end
                end
                S_TYPE:
                begin
                        ctrl_alu_src <= 1;
                        ctrl_mem_write <= 1;
                        ctrl_word_size = funct3;
                end
                B_TYPE:
                begin
                        ctrl_is_branch <= 1;

                        if ((funct3 == BEQ && ctrl_zero_flag) ||
                        (funct3 == BNE && ctrl_zero_flag != 1) ||
                        (funct3 == BLT && ctrl_lt_flag) ||
                        (funct3 == BGE && ctrl_gte_flag) ||
                        (funct3 == BLTU && ctrl_ltu_flag) ||
                        (funct3 == BGEU && ctrl_gteu_flag))
                                ctrl_branch_taken <= 1;
                end
                U_TYPE:
                        if (opcode == U_LUI) 
                        begin
                                ctrl_reg_write <= 1;
                                ctrl_alu_src <= 1;
                        end
                        else if(opcode == U_AUIPC)
                        begin
                                ctrl_AUIPC_taken <= 1;
                                ctrl_alu_src <= 1;
                                ctrl_reg_write <= 1;
                        end
                J_TYPE:
                begin
                        ctrl_branch_taken <= 1;
                end
        endcase
end

endmodule
