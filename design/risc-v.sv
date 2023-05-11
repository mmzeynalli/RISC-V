import common::*;

module risc_v #(
        int DATA_ADDRESS_WIDTH = 6,
        int CPU_DATA_WIDTH = 32,
        int REGISTER_FILE_ADDRESS_WIDTH = 5
) (
        input clk,
        input rst
);

logic [31:0] if_instruction, if_id_instruction;

instruction_fetch if_stage(
        .instruction(if_instruction)
);

if_id if_id_reg(
        .clk(clk),
        .rst(rst),
        .i_instruction(if_instruction),
        .o_instruction(if_id_instruction)
);



logic [OPERAND_WIDTH-1:0] id_rs1_data, id_rs2_data, id_ex_rs1_data, id_ex_rs2_data, id_imm, id_ex_imm;
logic [2:0] id_funct3, id_ex_funct3;
logic [6:0] id_funct7, id_ex_funct7;
logic [4:0] id_rd_sel, id_ex_rd_sel;


logic id_ctrl_mem_write, id_ctrl_mem_read, id_ctrl_mem_to_reg, id_ctrl_reg_wr_en, id_ctrl_alu_src;
logic id_ex_ctrl_mem_write, id_ex_ctrl_mem_read, id_ex_ctrl_mem_to_reg, id_ex_ctrl_reg_wr_en, id_ex_ctrl_alu_src;

instruction_decode id_stage(
        // Input
        .instruction(if_id_instruction)

        // Output

);



id_ex id_ex_reg(
        .clk(clk),
        .rst(rst),

        // IN SIGNALS
        .i_rs_data1(id_rs1_data),
        .i_rs_data2(id_rs2_data),
        .i_imm(id_imm),

        .i_funct3(id_funct3),
        .i_funct7(id_funct7),
        .i_rd_sel(id_rd_sel),

        //Controls
        .i_ctrl_mem_write(id_ctrl_mem_write),
        .i_ctrl_mem_read(id_ctrl_mem_read),
        .i_ctrl_mem_to_reg(id_ctrl_mem_to_reg),
        .i_ctrl_reg_wr_en(id_ctrl_reg_wr_en),
        .i_ctrl_alu_src(id_ctrl_alu_src),

        // OUT SIGNALS
        .o_rs_data1(id_ex_rs1_data),
        .o_rs_data2(id_ex_rs2_data),
        .o_imm(id_ex_imm),

        .o_funct3(id_ex_funct3),
        .o_funct7(id_ex_funct7),
        .o_rd_sel(id_ex_rd_sel),

        //Controls
        .o_ctrl_mem_write(id_ex_ctrl_mem_write),
        .o_ctrl_mem_read(id_ex_ctrl_mem_read),
        .o_ctrl_mem_to_reg(id_ex_ctrl_mem_to_reg),
        .o_ctrl_reg_wr_en(id_ex_ctrl_reg_wr_en),
        .o_ctrl_alu_src(id_ex_ctrl_alu_src),
);


// EX-MEM
logic [OPERAND_WIDTH-1:0] ex_alu_result, ex_mem_alu_result;
logic ex_mem_rs_data2, ex_mem_rd_sel, ex_mem_ctrl_mem_write, ex_mem_ctrl_mem_read, ex_mem_ctrl_mem_to_reg, ex_mem_ctrl_reg_wr_en;


execute ex_stage(

        // Input
        .funct3(id_ex_funct3),
        .funct7(id_ex_funct7),
        .imm(id_ex_imm),
        .rs2_data(id_ex_rs2_data),

        // Controls
        .ctrl_alu_src(id_ex_ctrl_alu_src),

        .alu_result(ex_alu_result)
);

ex_mem ex_mem_reg(
        .clk(clk),
        .rst(rst),

        // Input
        .i_alu_result(ex_alu_result),
        .i_rs_data2(id_ex_rs2_data),
        .i_rd_sel(id_ex_rd_sel),

        // Control
        .i_ctrl_mem_write(id_ex_ctrl_mem_write),
        .i_ctrl_mem_read(id_ex_ctrl_mem_read),
        .i_ctrl_mem_to_reg(id_ex_ctrl_mem_to_reg),
        .i_ctrl_reg_wr_en(id_ex_ctrl_reg_wr_en),

        // Output
        .o_alu_result(ex_mem_alu_result),
        .o_rs_data2(ex_mem_rs_data2),
        .o_rd_sel(ex_mem_rd_sel),

        // Control
        .o_ctrl_mem_write(ex_mem_ctrl_mem_write),
        .o_ctrl_mem_read(ex_mem_ctrl_mem_read),
        .o_ctrl_mem_to_reg(ex_mem_ctrl_mem_to_reg),
        .o_ctrl_reg_wr_en(ex_mem_ctrl_reg_wr_en)
);


// MEM-WB
logic [31:0] mem_mem_data, mem_wb_mem_data, mem_wb_alu_result;
logic [4:0] mem_wb_rd_sel;
logic mem_wb_ctrl_mem_to_reg, mem_wb_ctrl_reg_wr_en;

memory mem_stage(
        // Input
        .rs2_data(ex_mem_rs_data2),
        .alu_result(ex_mem_alu_result),
        .mem_data_read(),

        // Control
        .ctrl_mem_read(ex_mem_ctrl_mem_read),
        .ctrl_mem_write(ex_mem_ctrl_mem_write),
        .ctrl_mem_to_reg(ex_mem_ctrl_mem_to_reg),

        // Output
        .o_mem_data(mem_mem_data)
);

mem_wb mem_wb_reg(
        .clk(clk),
        .rst(rst),

        // IN SIGNALS
        .i_alu_result(ex_mem_alu_result),
        .i_mem_data(mem_mem_data),
        .i_rd_sel(ex_mem_rd_sel),

        // Controls
        .i_ctrl_mem_to_reg(ex_mem_ctrl_mem_to_reg),
        .i_ctrl_reg_wr_en(ex_mem_ctrl_reg_wr_en),

        // OUT SIGNALS
        .o_alu_result(mem_wb_alu_result),
        .o_mem_data(mem_wb_mem_data),
        .o_rd_sel(mem_wb_rd_sel),

        // Controls
        .o_ctrl_mem_to_reg(mem_wb_ctrl_mem_to_reg),
        .o_ctrl_reg_wr_en(mem_wb_ctrl_reg_wr_en)
);

write_back wb_stage(
        .alu_result(mem_wb_alu_result),
        .rd_sel(mem_wb_rd_sel),
        .mem_data_i(mem_wb_mem_data),

        .ctrl_reg_write(mem_wb_ctrl_reg_wr_en),
        .ctrl_mem_reg(mem_wb_ctrl_mem_to_reg),

        .wb_data_o()
);

endmodule
