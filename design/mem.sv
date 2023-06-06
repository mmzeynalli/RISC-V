import common::*;

module memory (
        input clk,
        input [OPERAND_WIDTH-1:0] alu_result,  // write/read address
        input [OPERAND_WIDTH-1:0] write_data,  // rs2, mem or wb forward data

        // Controls
        input ctrl_mem_write,
        input [2:0] ctrl_load_size,
        input [2:0] ctrl_store_size,

        output logic [31:0] mem_data
);

// all the LOAD operations
 if(ctrl_load_size == 'b000 )
        write_data = {24'b0,write_data[7:0]};
else if(ctrl_load_size == 'b001)
        write_data = {16'b0,write_data[15:0]};
else if(ctrl_load_size == 'b010 )
        write_data = write_data;
 else if(ctrl_load_size == 'b100 )
        write_data = {write_data[7:0], 24'b0};
else if(ctrl_load_size == 'b101 )
        write_data = {write_data[15:0], 16'b0};

data_memory data_memory(
        .clk(clk),
        .write_en(ctrl_mem_write),
        .write_data(write_data),
        .address(alu_result[7:0]),
        .read_data(mem_data)
);

//all the STORE instructions
if(ctrl_load_size == 'b000 )
        mem_data = {24'b0,mem_data[7:0]};
else if(ctrl_load_size == 'b001 )
        mem_data = {16'b0,mem_data[15:0]};
else if(ctrl_load_size == 'b010 )
        mem_data = mem_data;


endmodule
