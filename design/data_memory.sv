import common::*;

module data_memory import common::*;
(
        input clk,
        input rst,
        input write_en,
        input [DATA_WIDTH-1:0] write_data,
        input [MEMORY_ADDRESS_WIDTH+1:0] address,
        output logic [DATA_WIDTH-1:0] read_data,
        output logic memory_ok
);

memory_array ram;
logic [MEMORY_ADDRESS_WIDTH-1:0] wr_addr;

always @(posedge clk) begin
        if (rst == RESET)
        begin
                for (int i = 0; i < MEMORY_FILE_SIZE; i++)
                        ram[i] = '{default: '0};
        end
        else if (write_en)
        begin
                wr_addr = address >> 2;
                ram[wr_addr] = write_data;
        end
end

always_comb begin : ram_read
        read_data = ram[address >> 2];
end


ila_dm ila_dm (
        .rst(rst),
        .memory_file(ram),
        .ok(memory_ok)
);

// ila_mem ila_mem (
//     .clk(clk),
//     .probe0(ram[0]),
//     .probe1(ram[1]),
//     .probe2(ram[2]),
//     .probe3(ram[3]),
//     .probe4(ram[4]),
//     .probe5(ram[5]),
//     .probe6(ram[6]),
//     .probe7(ram[7]),
//     .probe8(ram[8]),
//     .probe9(ram[9]),
//     .probe10(ram[10]),
//     .probe11(ram[11]),
//     .probe12(ram[12]),
//     .probe13(ram[13]),
//     .probe14(ram[14]),
//     .probe15(ram[15]),
//     .probe16(write_en)
// );
    
endmodule
