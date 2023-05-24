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
logic if_ctrl_branch_taken;  // Defined later

instruction_fetch if_stage(
        // Input
        .clk(clk),
        .rst(rst),
        .is_compressed('0),
        .stall('0),
        .imm(if_imm),
        .ctrl_branch_taken(if_ctrl_branch_taken),

        // Output
        .instruction(if_instruction)
);

////////////////////////////////////////////////////////////
/////////////////////// END IF STAGE ///////////////////////
////////////////////////////////////////////////////////////

logic [INSTRUCTION_WIDTH-1:0] if_id_instruction;

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
        .mem_instruction(if_id_instruction),

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

logic id_ctrl_mem_write, id_ctrl_mem2reg, id_ctrl_reg_write, id_ctrl_alu_src;
logic id_ctrl_branch_taken;


control_unit ctrl_unit(

        .opcode(id_opcode),
        .optype(id_optype),
        .funct3(id_funct3),
        .rs1_data(id_rs1_data),
        .rs2_data(id_rs2_data),

        .ctrl_mem_write(id_ctrl_mem_write),
        .ctrl_mem2reg(id_ctrl_mem2reg),
        .ctrl_reg_write(id_ctrl_reg_write),

        .ctrl_alu_src(id_ctrl_alu_src),

        .ctrl_branch_taken(id_ctrl_branch_taken),

        .ctrl_is_branch()
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
logic [4:0] id_ex_rs1, id_ex_rs2, id_ex_rd_sel;

logic id_ex_ctrl_mem_write, id_ex_ctrl_mem2reg, id_ex_ctrl_reg_write, id_ex_ctrl_alu_src;

id_ex id_ex_reg(
        .clk(clk),
        .rst(rst),

        // IN SIGNALS
        .i_rs1(id_rs1),
        .i_rs1_data(id_rs1_data),
        .i_rs2(id_rs2),
        .i_rs2_data(id_rs2_data),
        .i_imm(id_imm),

        .i_opcode(instruction_format_type'(id_opcode)),
        .i_funct3(id_funct3),
        .i_funct7(id_funct7),
        .i_rd_sel(id_rd),

        //Controls
        .i_ctrl_mem_write(id_ctrl_mem_write),
        .i_ctrl_mem2reg(id_ctrl_mem2reg),
        .i_ctrl_reg_write(id_ctrl_reg_write),
        .i_ctrl_alu_src(id_ctrl_alu_src),

        // OUT SIGNALS
        .o_rs1(id_ex_rs1),
        .o_rs1_data(id_ex_rs1_data),
        .o_rs2(id_ex_rs2),
        .o_rs2_data(id_ex_rs2_data),
        .o_imm(id_ex_imm),

        .o_opcode(id_ex_opcode),
        .o_funct3(id_ex_funct3),
        .o_funct7(id_ex_funct7),
        .o_rd_sel(id_ex_rd_sel),

        //Controls
        .o_ctrl_mem_write(id_ex_ctrl_mem_write),
        .o_ctrl_mem2reg(id_ex_ctrl_mem2reg),
        .o_ctrl_reg_write(id_ex_ctrl_reg_write),
        .o_ctrl_alu_src(id_ex_ctrl_alu_src)
);

////////////////////////////////////////////////////////////
///////////////////////// EX STAGE /////////////////////////
////////////////////////////////////////////////////////////

logic [OPERAND_WIDTH-1:0] ex_alu_result;
logic [OPERAND_WIDTH-1:0] ex_from_mem, ex_from_wb;  // defined later
logic [OPERAND_WIDTH-1:0] ex_write_data;
forwarding_type ex_ctrl_forward_left_operand = NONE, ex_ctrl_forward_right_operand = NONE; // defined later

execute ex_stage(

        // Input
        .opcode(id_ex_opcode),
        .funct3(id_ex_funct3),
        .funct7(id_ex_funct7),
        .imm(id_ex_imm),

        .rs1_data(id_ex_rs1_data),
        .rs2_data(id_ex_rs2_data),
        .from_mem(ex_from_mem),
        .from_wb(ex_from_wb),

        // Controls
        .ctrl_alu_src(id_ex_ctrl_alu_src),
        .ctrl_forward_left_operand(ex_ctrl_forward_left_operand),
        .ctrl_forward_right_operand(ex_ctrl_forward_right_operand),

        .alu_result(ex_alu_result),
        .write_data(ex_write_data)
);

////////////////////////////////////////////////////////////
/////////////////////// END EX STAGE ///////////////////////
////////////////////////////////////////////////////////////

logic [OPERAND_WIDTH-1:0] ex_mem_alu_result, ex_mem_write_data;
logic [4:0] ex_mem_rd_sel;
logic ex_mem_ctrl_mem_write, ex_mem_ctrl_mem2reg, ex_mem_ctrl_reg_write;

ex_mem ex_mem_reg(
        .clk(clk),
        .rst(rst),

        // Input
        .i_alu_result(ex_alu_result),
        .i_write_data(ex_write_data),
        .i_rd_sel(id_ex_rd_sel),

        // Control
        .i_ctrl_mem_write(id_ex_ctrl_mem_write),
        .i_ctrl_mem2reg(id_ex_ctrl_mem2reg),
        .i_ctrl_reg_write(id_ex_ctrl_reg_write),

        // Output
        .o_alu_result(ex_mem_alu_result),
        .o_write_data(ex_mem_write_data),
        .o_rd_sel(ex_mem_rd_sel),

        // Control
        .o_ctrl_mem_write(ex_mem_ctrl_mem_write),
        .o_ctrl_mem2reg(ex_mem_ctrl_mem2reg),
        .o_ctrl_reg_write(ex_mem_ctrl_reg_write)
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
        .write_data(ex_mem_write_data),

        // Control
        .ctrl_mem_write(ex_mem_ctrl_mem_write),

        // Output
        .mem_data(mem_mem_data)
);

////////////////////////////////////////////////////////////
////////////////////// END MEM STAGE ///////////////////////
////////////////////////////////////////////////////////////

logic [31:0] mem_wb_alu_result, mem_wb_mem_data;
logic [4:0] mem_wb_rd_sel;
logic mem_wb_ctrl_mem2reg, mem_wb_ctrl_reg_write;

mem_wb mem_wb_reg(
        .clk(clk),
        .rst(rst),

        // IN SIGNALS
        .i_alu_result(ex_mem_alu_result),
        .i_mem_data(mem_mem_data),
        .i_rd_sel(ex_mem_rd_sel),

        // Controls
        .i_ctrl_mem2reg(ex_mem_ctrl_mem2reg),
        .i_ctrl_reg_write(ex_mem_ctrl_reg_write),

        // OUT SIGNALS
        .o_alu_result(mem_wb_alu_result),
        .o_mem_data(mem_wb_mem_data),
        .o_rd_sel(mem_wb_rd_sel),

        // Controls
        .o_ctrl_mem2reg(mem_wb_ctrl_mem2reg),
        .o_ctrl_reg_write(mem_wb_ctrl_reg_write)
);

////////////////////////////////////////////////////////////
///////////////////////// WB STAGE /////////////////////////
////////////////////////////////////////////////////////////

write_back wb_stage(
        .alu_result(mem_wb_alu_result),
        .i_mem_data(mem_wb_mem_data),

        .ctrl_reg_write(mem_wb_ctrl_reg_write),
        .ctrl_mem2reg(mem_wb_ctrl_mem2reg),

        .o_wb_data(id_register_file_wr_data)
);

assign id_register_file_wr_en = mem_wb_ctrl_reg_write;
assign id_register_file_wr_id = mem_wb_rd_sel;

always_comb begin : forwarding

        ex_ctrl_forward_left_operand = NONE;
        ex_ctrl_forward_right_operand = NONE;

        // Forwarding from MEM
        if (ex_mem_ctrl_reg_write)
        begin
                if (ex_mem_rd_sel == id_ex_rs1)
                        ex_ctrl_forward_left_operand = EX_MEM;
                
                if (ex_mem_rd_sel == id_ex_rs2)
                        ex_ctrl_forward_right_operand = EX_MEM;
        end

        ex_from_mem = (ex_mem_ctrl_mem2reg) ? mem_mem_data : ex_mem_alu_result;

        // Forwarding from WB
        if (mem_wb_ctrl_reg_write)
        begin
                if (mem_wb_rd_sel == id_ex_rs1)
                        ex_ctrl_forward_left_operand = MEM_WB;
                
                if (mem_wb_rd_sel == id_ex_rs2)
                        ex_ctrl_forward_right_operand = MEM_WB;
        end

        ex_from_wb = id_register_file_wr_data;
end

////////////////////////////////////////////////////////////
/////////////////////// END WB STAGE ///////////////////////
////////////////////////////////////////////////////////////

endmodule
