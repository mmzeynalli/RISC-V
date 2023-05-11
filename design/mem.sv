import common::*;

module memory (

        input logic [OPERAND_WIDTH-1:0] alu_result,
        input logic [OPERAND_WIDTH-1:0] rs2_data,
        input logic [31:0] mem_data_read,
        input logic [4:0] reg_rd,


        // Controls
        input ctrl_mem_read,
        input ctrl_mem_write,
        input ctrl_mem_to_reg,
        input ctrl_reg_write,
        output  o_ctrl_reg_write,
        output  o_ctrl_mem_to_reg,

        output logic mem_data_write_en,
        output logic [4:0] o_reg_rd,
        output logic [PROGRAM_ADDRESS_WIDTH-1:0] mem_data_address,
        output logic [INSTRUCTION_WIDTH-1:0] mem_data_write,
        output logic [31:0] o_mem_data,
        output logic [31:0] o_alu_result
);


always @(*) begin
         if ((ctrl_mem_read == 1)) begin // LOAD operation
                mem_data_write_en = 1'b0;
                o_alu_result = alu_result;
                o_mem_data = mem_data_read;
                mem_data_address = alu_result;
                o_reg_rd = reg_rd;
                o_ctrl_reg_write = ctrl_reg_write;
                o_ctrl_mem_to_reg = ctrl_mem_to_reg;


        end
        else if ((ctrl_mem_write == 1)) begin // STORE operation
                mem_data_write_en = 1'b1;
                o_alu_result = alu_result;
                o_mem_data = mem_data_read;
                mem_data_address = alu_result;
                o_reg_rd= reg_rd;
                o_ctrl_reg_write = ctrl_reg_write;
                o_ctrl_mem_to_reg = ctrl_mem_to_reg;
        end
        else begin // all other operations
               o_alu_result = alu_result;
               o_mem_data = mem_data_read;
               o_reg_rd = reg_rd;
               o_ctrl_reg_write = ctrl_reg_write;
               o_ctrl_mem_to_reg = ctrl_mem_to_reg;
        end
end



endmodule
