import common::*;

module risc_v #(
        int DATA_ADDRESS_WIDTH = 6;
        int CPU_DATA_WIDTH: natural = 32;
        int REGISTER_FILE_ADDRESS_WIDTH = 5;
) (
        input clk;
        input rst;
        
        
        input [INSTRUCTION_WIDTH-1:0] program_data;
        output [PROGRAM_ADDRESS_WIDTH-1:0] pc;

        output [DATA_ADDRESS_WIDTH-1:0] data_address;
        input [CPU_DATA_WIDTH-1:0] data_read;
        output data_write_en;
        output [CPU_DATA_WIDTH-1:0] data_write;

);





        
endmodule
