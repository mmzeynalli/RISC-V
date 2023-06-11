import common::*;

module memory (
        input clk,
        input rst,
        input [OPERAND_WIDTH-1:0] alu_result,  // write/read address
        input logic [OPERAND_WIDTH-1:0] write_data,  // rs2, mem or wb forward data

        // Controls
        input ctrl_mem_write,
        input [2:0] ctrl_word_size,

        output logic [31:0] mem_data
);

logic [OPERAND_WIDTH-1:0] rdata, wdata;

logic [4:0] from_address;
logic [7:0] byte_data;

always_comb begin : calculate_bit_address
        from_address = (alu_result[1:0] << 3);
end

// all the LOAD operations
always_comb begin: load

        mem_data = rdata;
       
        if (~ctrl_mem_write)
        begin
                case (ctrl_word_size)
                        3'b000: mem_data = 32'(signed'(rdata[from_address+:8]));
                        3'b001: mem_data = 32'(signed'(rdata[15:0]));
                        3'b100: mem_data = {24'b0, rdata[from_address+:8]};
                        3'b101: mem_data = {16'b0, rdata[15:0]};
                endcase
        end
end

//all the STORE instructions
always_comb begin: store

        wdata = write_data;
       
        if (ctrl_mem_write)
        begin
                case (ctrl_word_size)
                        3'b000: wdata = write_data << (alu_result[1:0]);
                        3'b001: wdata = {16'b0, write_data[15:0]};
                endcase
        end
end

data_memory data_memory(
        .clk(clk),
        .write_en(ctrl_mem_write),
        .write_data(wdata),
        .address(alu_result[7:0]),
        .read_data(rdata)
);

endmodule
