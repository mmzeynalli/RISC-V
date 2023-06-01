import common::*;

module uart2ram(
        input clk,
        input rst,
        input rx,
        output logic [SHORT_INSTRUCTION_WIDTH-1:0] data,
        output logic is_valid_data,
        output logic [PROGRAM_ADDRESS_WIDTH-1:0] write_address
);

logic is_valid_byte;
logic [7:0] byte_data;
logic [SHORT_INSTRUCTION_WIDTH-1:0] data_next;
logic [PROGRAM_ADDRESS_WIDTH-1:0] write_address_next;
logic [3:0] cnt, cnt_next;

always @(posedge clk) begin
        if (rst == RESET)
        begin
                cnt <= '0;
                data <= '0;
                write_address <= '0;
        end
        else
        begin
                cnt <= cnt_next;
                data <= data_next;
                write_address <= write_address_next;
        end
end


always_comb begin : bytes_to_command

        cnt_next <= cnt;
        data_next <= data;
        write_address_next <= write_address;
        is_valid_data <= 0;

        if (is_valid_byte)
        begin
                if (byte_data == 'h30)
                begin
                        data_next <= {1'b0, data[SHORT_INSTRUCTION_WIDTH-1:1]};
                        cnt_next <= cnt + 1;
                end
                else if (byte_data == 'h31)
                begin
                        data_next <= {1'b1, data[SHORT_INSTRUCTION_WIDTH-1:1]};
                        cnt_next <= cnt + 1;
                end
        end

        if (cnt == (SHORT_INSTRUCTION_WIDTH - 1))
        begin
                is_valid_data <= 1;
                write_address_next <= write_address + 1;
        end
end

uart_rx uart_rx(
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .data(byte_data),
        .is_data_rdy(is_valid_byte)
);

endmodule