import common::*;


module data_memory #(
        int ADDRESS_WIDTH = 6,
        int DATA_WIDTH = 32
) (
        input clk,
        input write_en,
        input [DATA_WIDTH-1:0] write_data,
        input [ADDRESS_WIDTH+1:0] address,
        output logic [DATA_WIDTH-1:0] read_data
);

localparam int MEMORY_DEPTH = 1 << ADDRESS_WIDTH;
typedef logic [DATA_WIDTH-1:0] ram_type [MEMORY_DEPTH-1:0];

ram_type ram = '{default: '0};

always @(posedge clk) begin
        if (write_en)
                ram[address >> 2] = write_data;
end

always_comb begin : ram_read
        read_data = ram[address >> 2];
end
        
endmodule
