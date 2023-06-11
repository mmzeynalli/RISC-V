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

ram_type ram;

logic [ADDRESS_WIDTH-1:0] wr_addr;

initial begin
        for (int i = 0; i < MEMORY_DEPTH; i++)
                ram[i] = 0;
end

always @(posedge clk) begin
        if (write_en)
        begin
                wr_addr = address >> 2;
                ram[wr_addr] = write_data;
        end
end

always_comb begin : ram_read
        read_data = ram[address >> 2];
end

ila_mem ila_mem (
    .clk(clk),
    .probe0(ram[0]),
    .probe1(ram[1]),
    .probe2(ram[2]),
    .probe3(ram[3]),
    .probe4(ram[4]),
    .probe5(ram[5]),
    .probe6(ram[6]),
    .probe7(ram[7]),
    .probe8(ram[8]),
    .probe9(ram[9]),
    .probe10(ram[10]),
    .probe11(ram[11]),
    .probe12(ram[12]),
    .probe13(ram[13]),
    .probe14(ram[14]),
    .probe15(ram[15]),
    .probe16(write_en)
);

        
endmodule
