import common::*;

module memory (

        input  logic control_mem_read,
        input  logic control_mem_write,
        input  logic control_reg_write,
        input  logic control_mem_to_reg,
        input  logic [31:0] register_file_data2,
        input  logic [31:0] alu_result,
        input  logic [4:0] register_file_rd,
        input  logic [INSTRUCTION_WIDTH-1 : 0] mem_data_read;
        output logic mem_data_write_en,
        output logic [PROGRAM_ADDRESS_WIDTH-1:0] mem_data_address,
        output logic [INSTRUCTION_WIDTH-1 : 0] mem_data_write,
        output logic [31:0] alu_result_o,
        output logic [31:0] mem_data_o,
        output logic [4:0] register_file_rd_o,
        output logic control_reg_write_o,
        output logic control_mem_to_reg_o
        
);



always @(*) begin
         if ((control_mem_read == 1)) begin // LOAD operation
                mem_data_write_en = 1b'0;
                alu_result_o = alu_result;
                mem_data_o = mem_data_read;
                mem_data_address = alu_result;
                register_file_rd_o = register_file_rd;
                control_reg_write_o = control_reg_write;
                control_mem_to_reg_o = control_mem_to_reg;


        end
        else if ((control_write == 1)) begin // STORE operation
                mem_data_write_en = 1b'1;
                alu_result_o = alu_result;
                mem_data_o = mem_data_read;
                mem_data_address = alu_result;
                register_file_rd_o= register_file_rd;
                control_reg_write_o = control_reg_write;
                control_mem_to_reg_o = control_mem_to_reg;
        end
        else begin // all other operations
               alu_result_o = alu_result;
               mem_data_o = mem_data_read;
               register_file_rd_o = register_file_rd;
               control_reg_write_o = control_reg_write;
               control_mem_to_reg_o = control_mem_to_reg;
        end
end



endmodule
