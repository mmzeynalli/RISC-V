import common::*;

module register_file #(
        int ADDRESS_WIDTH = 5,
        int DATA_WIDTH = 32
) (
        input clk,
        input rst_n,
        input write_en,

        input [ADDRESS_WIDTH-1:0] read1_id,
        input [ADDRESS_WIDTH-1:0] read2_id,
        input [ADDRESS_WIDTH-1:0] write_id,
        
        input [DATA_WIDTH-1:0] write_data,
        output logic [DATA_WIDTH-1:0] read1_data,
        output logic [DATA_WIDTH-1:0] read2_data
);

localparam int REGISTER_FILE_SIZE = 1 << ADDRESS_WIDTH;

typedef logic [REGISTER_FILE_SIZE-1:0] register_array [DATA_WIDTH-1:0];
register_array registers;

        always @(posedge clk) begin
                if (rst_n == RESET)
                        for (int i = 0; i < $size(registers); i++)
                                registers[i] = '{default:'0};
                else
                        if (write_en == 1)
                                registers[write_id] = write_data;
        end
        
        always_comb begin : data_read
                read1_data = registers[read1_id];
                read2_data = registers[read2_id];
        end
        
endmodule
