import common::*;

module memory (
        input clk,
        input [OPERAND_WIDTH-1:0] alu_result,  // write/read address
        input [OPERAND_WIDTH-1:0] write_data,  // rs2, mem or wb forward data

        // Controls
        input ctrl_mem_write,

        output logic [31:0] mem_data
);

data_memory data_memory(
        .clk(clk),
        .write_en(ctrl_mem_write),
        .write_data(write_data),
        .address(alu_result[7:0]),
        .read_data(mem_data)
);

endmodule
