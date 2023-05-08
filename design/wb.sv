import common::*;

module write_back (
    input  logic control_reg_write,
    input  logic control_mem_reg,
    input  logic [31:0] alu_result,
    input  logic [4:0] register_file_rd,
    input  logic [31:0] mem_data_i,
    output logic [31:0] wb_data_o
        
);

always @(*) begin

    if ((control_reg_write == 1) && (control_mem_reg == 1)) 
        wb_data_o = mem_data_i;
    else
        wb_data_o = alu_result;
             
    end
end

endmodule
