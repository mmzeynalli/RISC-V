import common::*;

module memory (

        input  logic control_mem_read,
        input  logic control_mem_write,
        input  logic control_reg_write,
        input  logic control_mem_to_reg,
        input  logic [31:0] register_file_data2,
        input  logic [31:0] alu_result,
        input  logic [4:0] register_file_rd,
        input  logic [INSTRUCTION_WIDTH-1:0] mem_data_read,
        output logic mem_data_write_en,
        output logic [PROGRAM_ADDRESS_WIDTH-1:0] mem_data_address,
        output logic [INSTRUCTION_WIDTH-1:0] mem_data_write,
        output logic [31:0] o_alu_result,
        output logic [31:0] o_mem_data,
        output logic [4:0] o_register_file_rd,
        output logic o_control_reg_write,
        output logic o_control_mem_to_reg
        
);



always @(*) begin
         if ((control_mem_read == 1)) begin // LOAD operation
                mem_data_write_en = 1'b0;
                o_alu_result = alu_result;
                o_mem_data = mem_data_read;
                mem_data_address = alu_result;
                o_register_file_rd = register_file_rd;
                o_control_reg_write = control_reg_write;
                o_control_mem_to_reg = control_mem_to_reg;


        end
        else if ((control_mem_write == 1)) begin // STORE operation
                mem_data_write_en = 1'b1;
                o_alu_result = alu_result;
                o_mem_data = mem_data_read;
                mem_data_address = alu_result;
                o_register_file_rd= register_file_rd;
                o_control_reg_write = control_reg_write;
                o_control_mem_to_reg = control_mem_to_reg;
        end
        else begin // all other operations
               o_alu_result = alu_result;
               o_mem_data = mem_data_read;
               o_register_file_rd = register_file_rd;
               o_control_reg_write = control_reg_write;
               o_control_mem_to_reg = control_mem_to_reg;
        end
end



endmodule
