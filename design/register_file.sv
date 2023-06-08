import common::*;

module register_file #(
        int ADDRESS_WIDTH = 5,
        int DATA_WIDTH = 32
) (
        input clk,
        input rst,
        input write_en,

        input [ADDRESS_WIDTH-1:0] read1_id,
        input [ADDRESS_WIDTH-1:0] read2_id,
        input [ADDRESS_WIDTH-1:0] write_id,
        input [DATA_WIDTH-1:0] write_data,
        
        output logic [DATA_WIDTH-1:0] read1_data,
        output logic [DATA_WIDTH-1:0] read2_data
);

localparam int REGISTER_FILE_SIZE = 1 << ADDRESS_WIDTH;

typedef logic [DATA_WIDTH-1:0] register_array [REGISTER_FILE_SIZE-1:0];
register_array registers;


always @(posedge clk) begin
        if (rst == RESET)
                for (int i = 0; i < $size(registers); i++)
                        registers[i] = '{default: '0};
        else
                if (write_en)
                        registers[write_id] = write_data;
end

always_comb begin : data_read

        read1_data = registers[read1_id];
        read2_data = registers[read2_id];

        if (write_en)
        begin
                if (write_id == read1_id)
                        read1_data = write_data;
                
                if (write_id == read2_id)
                        read2_data = write_data;
        end
end

ila_mem ila_reg (
    .clk(clk),
    .probe0(registers[0]),
    .probe1(registers[1]),
    .probe2(registers[2]),
    .probe3(registers[3]),
    .probe4(registers[4]),
    .probe5(registers[5]),
    .probe6(registers[6]),
    .probe7(registers[7]),
    .probe8(registers[8]),
    .probe9(registers[9]),
    .probe10(registers[10]),
    .probe11(registers[11]),
    .probe12(registers[12]),
    .probe13(registers[13]),
    .probe14(registers[14]),
    .probe15(registers[15])
);

        
endmodule
