import common::*;

module risc_v #(
        int DATA_ADDRESS_WIDTH = 6,
        int CPU_DATA_WIDTH = 32,
        int REGISTER_FILE_ADDRESS_WIDTH = 5
) (
        input clk,
        input rst
);

////////////////////////////////////////////////////////////
///////////////////////// IF STAGE /////////////////////////
////////////////////////////////////////////////////////////

logic [31:0] if_instruction;
logic [20:0] if_imm; // Defined later
logic if_ctrl_branch_taken, if_ctrl_jump_taken;  // Defined later

instruction_fetch if_stage(
        .clk(clk),
        .rst(rst),
        .is_compressed(1'b0),
        .stall(1'b0),
        .imm(if_imm),
        .ctrl_branch_taken(if_ctrl_branch_taken),
        .ctrl_jump_taken(if_ctrl_jump_taken),

        .instruction(if_instruction)
);

////////////////////////////////////////////////////////////
/////////////////////// END IF STAGE ///////////////////////
////////////////////////////////////////////////////////////

logic [31:0] if_id_instruction;

if_id if_id_reg(
        .clk(clk),
        .rst(rst),
        .i_instruction(if_instruction),
        .o_instruction(if_id_instruction)
);


////////////////////////////////////////////////////////////
///////////////////////// ID STAGE /////////////////////////
////////////////////////////////////////////////////////////

logic [6:0] id_opcode;
instruction_op_type id_optype;
logic [4:0] id_rs1, id_rs2, id_rd;
logic [2:0] id_funct3;
logic [6:0] id_funct7;
logic [IMM_WIDTH-1:0] id_imm;

instruction_decode id_stage(
        // Input
        .instruction(if_id_instruction),

        // Output
        .opcode(id_opcode),
        .optype(id_optype),
        .rd(id_rd),
        .rs1(id_rs1),
        .rs2(id_rs2),
        .funct3(id_funct3),
        .funct7(id_funct7),
        .imm(id_imm)
);

// Connection to IF stage
assign if_imm = id_imm;

logic id_register_file_wr_en;  // Defined later
logic [31:0] id_register_file_wr_data;  // Defined later
logic [OPERAND_WIDTH-1:0] id_rs1_data, id_rs2_data;
logic [4:0] id_register_file_wr_id; // defined later

register_file register_file(
        .clk(clk),
        .rst(rst),
        .write_en(id_register_file_wr_en),

        .read1_id(id_rs1),
        .read2_id(id_rs2),
        .write_id(id_register_file_wr_id),
        .write_data(id_register_file_wr_data),

        .read1_data(id_rs1_data),
        .read2_data(id_rs2_data)
);

logic id_ctrl_mem_write, id_ctrl_mem_read, id_ctrl_mem_to_reg, id_ctrl_reg_wr_en, id_ctrl_alu_src;
logic id_ctrl_branch_taken;


control_unit ctrl_unit(

        .opcode(id_opcode),
        .optype(id_optype),
        .funct3(id_funct3),
        .rs1_data(id_rs1_data),
        .rs2_data(id_rs2_data),

        .ctrl_mem_write(id_ctrl_mem_write),
        .ctrl_mem_read(id_ctrl_mem_read),
        .ctrl_mem_to_reg(id_ctrl_mem_to_reg),
        .ctrl_reg_wr_en(id_ctrl_reg_wr_en),

        .ctrl_alu_src(id_ctrl_alu_src),

        .ctrl_branch_taken(id_ctrl_branch_taken),

        .ctrl_is_branch(),
        .ctrl_is_jump()

);

// Connection to IF stage
assign if_ctrl_branch_taken = id_ctrl_branch_taken;

////////////////////////////////////////////////////////////
/////////////////////// END ID STAGE ///////////////////////
////////////////////////////////////////////////////////////

logic [OPERAND_WIDTH-1:0] id_ex_rs1_data, id_ex_rs2_data;
logic [IMM_WIDTH-1:0] id_ex_imm;

instruction_format_type id_ex_opcode;
logic [2:0] id_ex_funct3;
logic [6:0] id_ex_funct7;
logic [4:0] id_ex_rd_sel;

logic id_ex_ctrl_mem_write, id_ex_ctrl_mem_read, id_ex_ctrl_mem_to_reg, id_ex_ctrl_reg_wr_en, id_ex_ctrl_alu_src;

id_ex id_ex_reg(
        .clk(clk),
        .rst(rst),

        // IN SIGNALS
        .i_rs1_data(id_rs1_data),
        .i_rs2_data(id_rs2_data),
        .i_imm(id_imm),

        .i_opcode(id_ex_opcode),
        .i_funct3(id_funct3),
        .i_funct7(id_funct7),
        .i_rd_sel(id_rd),

        //Controls
        .i_ctrl_mem_write(id_ctrl_mem_write),
        .i_ctrl_mem_read(id_ctrl_mem_read),
        .i_ctrl_mem_to_reg(id_ctrl_mem_to_reg),
        .i_ctrl_reg_wr_en(id_ctrl_reg_wr_en),
        .i_ctrl_alu_src(id_ctrl_alu_src),

        // OUT SIGNALS
        .o_rs1_data(id_ex_rs1_data),
        .o_rs2_data(id_ex_rs2_data),
        .o_imm(id_ex_imm),

        .o_opcode(id_ex_opcode),
        .o_funct3(id_ex_funct3),
        .o_funct7(id_ex_funct7),
        .o_rd_sel(id_ex_rd_sel),

        //Controls
        .o_ctrl_mem_write(id_ex_ctrl_mem_write),
        .o_ctrl_mem_read(id_ex_ctrl_mem_read),
        .o_ctrl_mem_to_reg(id_ex_ctrl_mem_to_reg),
        .o_ctrl_reg_wr_en(id_ex_ctrl_reg_wr_en),
        .o_ctrl_alu_src(id_ex_ctrl_alu_src)
);

////////////////////////////////////////////////////////////
///////////////////////// EX STAGE /////////////////////////
////////////////////////////////////////////////////////////

logic [OPERAND_WIDTH-1:0] ex_alu_result;

execute ex_stage(

        // Input
        .opcode(id_ex_opcode),
        .funct3(id_ex_funct3),
        .funct7(id_ex_funct7),
        .imm(id_ex_imm),
        .rs1_data(id_ex_rs1_data),
        .rs2_data(id_ex_rs2_data),

        // Controls
        .ctrl_alu_src(id_ex_ctrl_alu_src),

        .alu_result(ex_alu_result)
);

////////////////////////////////////////////////////////////
/////////////////////// END EX STAGE ///////////////////////
////////////////////////////////////////////////////////////

logic [OPERAND_WIDTH-1:0] ex_mem_alu_result, ex_mem_rs2_data;
logic [4:0] ex_mem_rd_sel;
logic ex_mem_ctrl_mem_write, ex_mem_ctrl_mem_read, ex_mem_ctrl_mem_to_reg, ex_mem_ctrl_reg_wr_en;


ex_mem ex_mem_reg(
        .clk(clk),
        .rst(rst),

        // Input
        .i_alu_result(ex_alu_result),
        .i_rs2_data(id_ex_rs2_data),
        .i_rd_sel(id_ex_rd_sel),

        // Control
        .i_ctrl_mem_write(id_ex_ctrl_mem_write),
        .i_ctrl_mem_read(id_ex_ctrl_mem_read),
        .i_ctrl_mem_to_reg(id_ex_ctrl_mem_to_reg),
        .i_ctrl_reg_wr_en(id_ex_ctrl_reg_wr_en),

        // Output
        .o_alu_result(ex_mem_alu_result),
        .o_rs2_data(ex_mem_rs2_data),
        .o_rd_sel(ex_mem_rd_sel),

        // Control
        .o_ctrl_mem_write(ex_mem_ctrl_mem_write),
        .o_ctrl_mem_read(ex_mem_ctrl_mem_read),
        .o_ctrl_mem_to_reg(ex_mem_ctrl_mem_to_reg),
        .o_ctrl_reg_wr_en(ex_mem_ctrl_reg_wr_en)
);

////////////////////////////////////////////////////////////
//////////////////////// MEM STAGE /////////////////////////
////////////////////////////////////////////////////////////

// MEM-WB
logic [31:0] mem_mem_data;

memory mem_stage(
        // Input
        .clk(clk),
        .alu_result(ex_mem_alu_result),
        .rs2_data(ex_mem_rs2_data),

        // Control
        .ctrl_mem_read(ex_mem_ctrl_mem_read),
        .ctrl_mem_write(ex_mem_ctrl_mem_write),     // ? 
        // .ctrl_mem_to_reg(ex_mem_ctrl_mem_to_reg),  // ?


        // Output
        .mem_data(mem_mem_data)
);

////////////////////////////////////////////////////////////
////////////////////// END MEM STAGE ///////////////////////
////////////////////////////////////////////////////////////

logic [31:0] mem_wb_alu_result, mem_wb_mem_data;
logic [4:0] mem_wb_rd_sel;
logic mem_wb_ctrl_mem_to_reg, mem_wb_ctrl_reg_wr_en;

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

////////////////////////////////////////////////////////////
///////////////////////// WB STAGE /////////////////////////
////////////////////////////////////////////////////////////

write_back wb_stage(
        .alu_result(mem_wb_alu_result),
        .i_mem_data(mem_wb_mem_data),

        .ctrl_reg_write(mem_wb_ctrl_reg_wr_en),
        .ctrl_mem_reg(mem_wb_ctrl_mem_to_reg),

        .o_wb_data(id_register_file_wr_data)
);

assign id_register_file_wr_en = mem_wb_ctrl_reg_wr_en;
assign id_register_file_wr_id = mem_wb_rd_sel;
////////////////////////////////////////////////////////////
/////////////////////// END WB STAGE ///////////////////////
////////////////////////////////////////////////////////////

endmodule
