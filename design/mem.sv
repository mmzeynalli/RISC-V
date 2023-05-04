import common::*;

module memory (
        input  logic clk,
        input logic rst,
        input logic control_mem_read,
        input logic control_mem_write,
        input logic control_reg_write,
        input logic control_mem_reg,
        input  reg [31:0] register_file_data2,
        input  reg [31:0] alu_result,
        input  reg [4:0] register_file_rd,
        input  reg [INSTRUCTION_WIDTH-1 : 0] data_read;
        output logic data_write_en,
        output reg [PROGRAM_ADDRESS_WIDTH-1:0] data_address,
        output reg [INSTRUCTION_WIDTH-1 : 0] data_write,
        output reg [31:0] alu_result_out,
        output reg [4:0] register_file_rd_out

);


reg [PROGRAM_ADDRESS_WIDTH-1:0] address_reg;
reg [INSTRUCTION_WIDTH-1 : 0] write_reg;
reg [PROGRAM_ADDRESS_WIDTH-1:0] alu_out_reg;
reg [4:0] rd_out_reg;
logic enable;


always @(*) begin
        if (rst) begin
                address_reg = 32'd0;
                write_reg   = 32'd0;
                alu_out_reg = 32'd0;
                rd_out_reg  = 32'd0; // reset
        end
        else if ((control_mem_read) && (control_reg_write) && (control_mem_to_reg)) begin // LOAD operation
                enable = 1'b0;
                rd_out_reg  = register_file_rd;
        end
        else if ((control_write)) begin // STORE operation
                address_reg = alu_result;
                write_reg = register_file_data2;
                enable = 1'b1;
                rd_out_reg  = register_file_rd;
        end
        else begin // all other operations
               alu_out_reg = alu_result;
               rd_out_reg  = register_file_rd; 
        end
end

//OUTPUTS to the module 

assign data_write_en = enable;
assign data_address = address_reg;
assign data_write = write_reg;
assign alu_result_out = alu_out_reg;
assign register_file_rd_out = rd_out_reg;
endmodule
