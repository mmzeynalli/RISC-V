import common::*;

module if_id (
    input clk,
    input rst,

    input [INSTRUCTION_WIDTH-1:0] i_instruction,
    output logic [INSTRUCTION_WIDTH-1:0] o_instruction
);

always_ff @(posedge clk) begin
    if (rst == RESET)
    begin
        o_instruction <= '0;
    end
    else
    begin
        o_instruction <= i_instruction;
    end
end
    
endmodule

module id_ex (
    input clk,
    input rst,

    // IN SIGNALS
    input [OPERAND_WIDTH-1:0] i_rs1_data,
    input [OPERAND_WIDTH-1:0] i_rs2_data,
    input [IMM_WIDTH-1:0] i_imm,

    input instruction_format_type i_opcode,
    input [2:0] i_funct3,
    input [6:0] i_funct7,

    input [4:0] i_rs1,
    input [4:0] i_rs2,
    input [4:0] i_rd_sel,

    // Controls
    input i_ctrl_mem_write,
    input i_ctrl_mem2reg,
    input i_ctrl_reg_write,
    input i_ctrl_alu_src,

    // OUT SIGNALS
    output logic [OPERAND_WIDTH-1:0] o_rs1_data,
    output logic [OPERAND_WIDTH-1:0] o_rs2_data,
    output logic [IMM_WIDTH-1:0] o_imm,

    output instruction_format_type o_opcode,
    output logic [2:0] o_funct3,
    output logic [6:0] o_funct7,

    output logic [4:0] o_rs1,
    output logic [4:0] o_rs2,
    output logic [4:0] o_rd_sel,

    //Controls
    output logic o_ctrl_mem_write,
    output logic o_ctrl_mem2reg,
    output logic o_ctrl_reg_write,
    output logic o_ctrl_alu_src
);

always_ff @(posedge clk) begin
    if (rst == RESET)
    begin
        o_rs1_data <= '0;
        o_rs1 <= '0;
        o_rs2_data <= '0;
        o_rs2 <= '0;
        o_imm <= '0;

        o_opcode <= OP;
        o_funct3 <= '0;
        o_funct7 <= '0;
        
        o_rd_sel <= '0;

        // Controls
        o_ctrl_mem_write <= '0;
        o_ctrl_mem2reg <= '0;
        o_ctrl_reg_write <= '0;
        o_ctrl_alu_src <= '0;
    end
    else
    begin
        o_rs1_data <= i_rs1_data;
        o_rs1 <= i_rs1;
        o_rs2_data <= i_rs2_data;
        o_rs2 <= i_rs2;
        o_imm <= i_imm;

        o_opcode <= i_opcode;
        o_funct3 <= i_funct3;
        o_funct7 <= i_funct7;
        
        o_rd_sel <= i_rd_sel;

        // Controls
        o_ctrl_mem_write <= i_ctrl_mem_write;
        o_ctrl_mem2reg <= i_ctrl_mem2reg;
        o_ctrl_reg_write <= i_ctrl_reg_write;
        o_ctrl_alu_src <= i_ctrl_alu_src;
    end
end
    
endmodule

module ex_mem (
    input clk,
    input rst,

    // IN SIGNALS
    input [OPERAND_WIDTH-1:0] i_alu_result,
    input [OPERAND_WIDTH-1:0] i_write_data,
    input [4:0] i_rd_sel,

    //Controls
    input i_ctrl_mem_write,
    input i_ctrl_mem2reg,
    input i_ctrl_reg_write,

    // OUT SIGNALS
    output logic [OPERAND_WIDTH-1:0] o_alu_result,
    output logic [OPERAND_WIDTH-1:0] o_write_data,
    output logic [4:0] o_rd_sel,

    // Controls
    output logic o_ctrl_mem_write,
    output logic o_ctrl_mem2reg,
    output logic o_ctrl_reg_write
);

always_ff @(posedge clk) begin
    if (rst == RESET)
    begin
        o_alu_result <= '0;
        o_write_data <= '0;       
        o_rd_sel <= '0;

        // Controls
        o_ctrl_mem_write <= '0;
        o_ctrl_mem2reg <= '0;
        o_ctrl_reg_write <= '0;
    end
    else
    begin
        o_alu_result <= i_alu_result;
        o_write_data <= i_write_data;       
        o_rd_sel <= i_rd_sel;

        // Controls
        o_ctrl_mem_write <= i_ctrl_mem_write;
        o_ctrl_mem2reg <= i_ctrl_mem2reg;
        o_ctrl_reg_write <= i_ctrl_reg_write;
    end
end
    
endmodule

module mem_wb (
    input clk,
    input rst,

    // IN SIGNALS
    input [OPERAND_WIDTH-1:0] i_alu_result,
    input [OPERAND_WIDTH-1:0] i_mem_data,
    input [4:0] i_rd_sel,

    // Controls
    input i_ctrl_mem2reg,
    input i_ctrl_reg_write,

    // OUT SIGNALS
    output logic [OPERAND_WIDTH-1:0] o_alu_result,
    output logic [OPERAND_WIDTH-1:0] o_mem_data,
    output logic [4:0] o_rd_sel,

    // Controls
    output logic o_ctrl_mem2reg,
    output logic o_ctrl_reg_write
);

always_ff @(posedge clk) begin
    if (rst == RESET)
    begin
        o_alu_result <= '0;
        o_mem_data <= '0;
        o_rd_sel <= '0;

        // Controls
        o_ctrl_mem2reg <= '0;
        o_ctrl_reg_write <= '0;
    end
    else
    begin
        o_alu_result <= i_alu_result;
        o_mem_data <= i_mem_data;
        o_rd_sel <= i_rd_sel;

        // Controls
        o_ctrl_mem2reg <= i_ctrl_mem2reg;
        o_ctrl_reg_write <= i_ctrl_reg_write;
    end
end
    
endmodule
