import common::*;

module write_back (
    input [31:0] alu_result,
    input [31:0] i_mem_data,
    input ctrl_reg_write,
    input ctrl_mem_reg,

    output logic [31:0] o_wb_data
);

always_comb begin

    if ((ctrl_reg_write == 1) && (ctrl_mem_reg == 1))
        o_wb_data = i_mem_data;
    else
        o_wb_data = alu_result;   
end

endmodule
