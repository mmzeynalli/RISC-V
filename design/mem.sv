import common::*;

module memory (

        input logic [OPERAND_WIDTH-1:0] alu_result,
        input logic [OPERAND_WIDTH-1:0] rs2_data,
        input logic [31:0] mem_data_read,
        input logic [4:0] reg_rd,


        // Controls
        input ctrl_mem_read,
        input ctrl_mem_write,

        output logic mem_data_write_en,
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



        end
        else if ((ctrl_mem_write == 1)) begin // STORE operation
                mem_data_write_en = 1'b1;
                o_alu_result = alu_result;
                o_mem_data = mem_data_read;
                mem_data_address = alu_result;
        end
        else begin // all other operations
               o_alu_result = alu_result;
               o_mem_data = mem_data_read;

        end
end



endmodule
