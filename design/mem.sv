import common::*;

module memory (
        input [OPERAND_WIDTH-1:0] alu_result,  // write/read address
        input [OPERAND_WIDTH-1:0] rs2_data,     // write data

        // Controls
        input ctrl_mem_read,
        input ctrl_mem_write,

        output logic [31:0] mem_data
);


data_memory data_memory(
        .clk(clk),
        .write_en(ctrl_mem_write),
        .write_data(rs2_data),
        .address(alu_result),
        .read_data(mem_data)
);

endmodule
