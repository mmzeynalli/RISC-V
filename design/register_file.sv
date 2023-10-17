import common::*;

module register_file import common::*;
(
        input clk,
        input rst,
        input write_en,

        input [REGISTER_ADDRESS_WIDTH-1:0] read1_id,
        input [REGISTER_ADDRESS_WIDTH-1:0] read2_id,
        input [REGISTER_ADDRESS_WIDTH-1:0] write_id,
        input [DATA_WIDTH-1:0] write_data,
        
        output logic [DATA_WIDTH-1:0] read1_data,
        output logic [DATA_WIDTH-1:0] read2_data,

        output logic check_ok
);

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


ila_rm ila_rm (
        .rst(rst),
        .register_file(registers),
        .ok(check_ok)
);

// ila_mem ila_reg (
//     .clk(clk),
//     .probe0(registers[0]),
//     .probe1(registers[1]),
//     .probe2(registers[2]),
//     .probe3(registers[3]),
//     .probe4(registers[4]),
//     .probe5(registers[5]),
//     .probe6(registers[6]),
//     .probe7(registers[7]),
//     .probe8(registers[8]),
//     .probe9(registers[9]),
//     .probe10(registers[10]),
//     .probe11(registers[11]),
//     .probe12(registers[12]),
//     .probe13(registers[13]),
//     .probe14(registers[14]),
//     .probe15(registers[15]),
//     .probe16(write_en)
// );

        
endmodule
