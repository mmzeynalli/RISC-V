import common::*;

module memory (
        input clk,
        input rst,
        input [OPERAND_WIDTH-1:0] alu_result,  // write/read address
        input logic [OPERAND_WIDTH-1:0] write_data,  // rs2, mem or wb forward data

        // Controls
        input ctrl_mem_write,
        input [2:0] ctrl_word_size,

        output logic [31:0] mem_data
);

logic [OPERAND_WIDTH-1:0] data;
logic [31:0] mem;

// all the LOAD operations
always_comb begin: store

        data = write_data;

        if (ctrl_mem_write)
        begin
                if(ctrl_word_size == 3'b000)
                        data = {24'b0, write_data[7:0]};
                else if(ctrl_word_size == 3'b001)
                        data = {16'b0, write_data[15:0]};
                else if(ctrl_word_size == 3'b100 )
                        data = {write_data[7:0], 24'b0};
                else if(ctrl_word_size == 3'b101 )
                        data = {write_data[15:0], 16'b0};
        end
end

data_memory data_memory(
        .clk(clk),
        .write_en(ctrl_mem_write),
        .write_data(data),
        .address(alu_result[7:0]),
        .read_data(mem)
);

//all the STORE instructions
always_comb begin: load

        mem_data = mem;

        if (~ctrl_mem_write)
        begin
                if(ctrl_word_size == 3'b000)
                        mem_data = {24'b0, mem[7:0]};
                else if(ctrl_word_size == 3'b001)
                        mem_data = {16'b0, mem[15:0]};     
        end
end

endmodule
