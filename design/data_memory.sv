import common::*;


module data_memory #(
        int ADDRESS_WIDTH = 6;
        int DATA_WIDTH = 32;
) (
        input clk;
        input write_en;
        input [DATA_WIDTH-1:0] write_data;
        input [ADDRESS_WIDTH-1:0] address;
        output [DATA_WIDTH-1:0] read_data;
);

const int MEMORY_DEPTH = 1 << ADDRESS_WIDTH;
typedef logic [MEMORY_DEPTH-1:0] ram_type [DATA_WIDTH-1:0];

ram_type ram = '{default:'0};

        // TODO: Fix address?
        always @(posedge clk) begin
                if (write_en == 1)
                        ram(address) = write_data;           
        end

        always_comb begin : ram_read
            read_data = ram(address);
        end
        
endmodule
