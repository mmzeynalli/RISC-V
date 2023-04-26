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
typedef logic [MEMORY_DEPTH-1:0][DATA_WIDTH-1:0] ram_type;  // Try to make unpacked
ram_type ram;


function init_RAM(string filename);
        static int fd = $fopen(filename, "r");
        static ram_type _ram;

        for (int i = 0; i < $size(_ram) && !$feof(fd); i++)
                $fscanf(fd, "%b", _ram[i]);

        return _ram;
endfunction

        initial begin
                ram = init_RAM("instruction_mem.mem");        
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
