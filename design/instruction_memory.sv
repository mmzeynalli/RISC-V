import common::*;


module program_memory #(
        int ADDRESS_WIDTH = 6,
        int DATA_WIDTH = 32
) (
        input clk,
        input write_en,
        input [DATA_WIDTH-1:0] write_data,
        input [ADDRESS_WIDTH-1:0] address,
        output logic [DATA_WIDTH-1:0] read_data
);

localparam int MEMORY_DEPTH = 1 << ADDRESS_WIDTH;
typedef logic [MEMORY_DEPTH-1:0] ram_type [DATA_WIDTH-1:0];  // Try to make unpacked
ram_type ram;


        initial begin
                ram = readmemb("instruction_mem.mem");
        end
        
        // TODO: Fix address?
        always @(posedge clk) begin
                if (write_en == 1)
                        ram[address] = write_data;           
        end

        always_comb begin : ram_read
            read_data = ram[address];
        end

endmodule
