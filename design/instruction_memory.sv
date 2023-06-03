import common::*;
// `define TESTING

module instruction_memory #(
        int ADDRESS_WIDTH = 6,
        int DATA_WIDTH = 32,
        int INSTR_MIN_WIDTH = 16
) (
        input clk,
        input write_en,
        input [SHORT_INSTRUCTION_WIDTH-1:0] write_data,
        input [PROGRAM_ADDRESS_WIDTH-1:0] address,
        output logic [DATA_WIDTH-1:0] read_data
);

localparam int MEMORY_DEPTH = 1 << ADDRESS_WIDTH;
typedef logic [INSTR_MIN_WIDTH-1:0] ram_type [MEMORY_DEPTH-1:0];
ram_type ram;

always @(posedge clk) begin
        if (write_en)
                ram[address >> 1] = write_data;           
end

always_comb begin : ram_read
        read_data = {ram[(address >> 1) + 1], ram[address >> 1]};
end

endmodule
