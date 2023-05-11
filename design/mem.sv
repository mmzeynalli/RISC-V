import common::*;

module memory (
        input [OPERAND_WIDTH-1:0] alu_result,
        input [OPERAND_WIDTH-1:0] rs2_data,
        input [31:0] mem_data_read,

        // Controls
        input ctrl_mem_read,
        input ctrl_mem_write,
        input ctrl_mem_to_reg,

        output logic mem_data_write_en,
        output logic [PROGRAM_ADDRESS_WIDTH-1:0] mem_data_address,
        output logic [INSTRUCTION_WIDTH-1:0] mem_data_write,
        output logic [31:0] o_mem_data
);



always @(*) begin
         if (ctrl_mem_read == 1) begin // LOAD operation
                mem_data_write_en = 1'b0;
                o_mem_data = mem_data_read;
                mem_data_address = alu_result;
        end
        else if (ctrl_mem_write == 1) begin // STORE operation
                mem_data_write_en = 1'b1;
                o_mem_data = mem_data_read;
                mem_data_address = alu_result;
        end
        else begin // all other operations
               o_mem_data = mem_data_read;
        end
end



endmodule
