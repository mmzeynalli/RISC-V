import common::*;

module write_back (
    input  logic ctrl_reg_write,
    input  logic ctrl_mem_reg,
    input  logic [31:0] alu_result,
    input  logic [4:0] rd_sel,
    input  logic [31:0] mem_data_i,
    output logic [31:0] wb_data_o 
);

always @(*) begin

    if ((ctrl_reg_write == 1) && (ctrl_mem_reg == 1))
        wb_data_o = mem_data_i;
    else
        wb_data_o = alu_result;   
end

endmodule
