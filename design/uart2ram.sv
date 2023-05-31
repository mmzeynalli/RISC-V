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
logic [SHORT_INSTRUCTION_WIDTH-1:0] cmd, cmd_next;
logic [PROGRAM_ADDRESS_WIDTH-1:0] addr, addr_next;
logic [3:0] cnt, cnt_next;

always @(posedge clk) begin
        if (rst == RESET)
        begin
                cnt <= '0;
                cmd <= '0;
                addr <= '0;
        end
        else
        begin
                cnt <= cnt_next;
                cmd <= cmd_next;
                addr <= addr_next;
        end
end


always_comb begin : bytes_to_command

        cnt_next <= cnt;
        cmd_next <= cmd;
        addr_next <= addr;

        if (is_valid_byte)
        begin
                if (byte_data == 'h30)
                begin
                        cmd_next <= {1'b0, cmd[SHORT_INSTRUCTION_WIDTH-1:1]};
                        cnt_next <= cnt + 1;
                end
                else if (byte_data == 'h31)
                begin
                        cmd_next <= {1'b1, cmd[SHORT_INSTRUCTION_WIDTH-1:1]};
                        cnt_next <= cnt + 1;
                end
        end

        data <= cmd;
        write_address <= addr;
        is_valid_data <= 0;

        if (cnt == (SHORT_INSTRUCTION_WIDTH - 1))
        begin
                is_valid_data <= 1;
                addr_next <= addr + 1;
        end
end

uart uart(
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .data(byte_data),
        .is_data_rdy(is_valid_byte)
);

endmodule