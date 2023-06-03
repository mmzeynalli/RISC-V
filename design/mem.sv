import common::*;

module memory (
        input clk,
        input [OPERAND_WIDTH-1:0] alu_result,  // write/read address
        input [OPERAND_WIDTH-1:0] write_data,  // rs2, mem or wb forward data

        // Controls
        input ctrl_mem_write,

        output logic [31:0] mem_data
);

// all the LOAD operations
// if(ctrl_LB_taken == 1 )
//         write_data = {24'b0,write_data[7:0]};
// else if(ctrl_LH_taken == 1 )
//         write_data = {16'b0,write_data[15:0]};
// else if(ctrl_LW_taken == 1 )
//         write_data = write_data;
// else if(ctrl_LBU_taken == 1 )
//         write_data = {write_data[7:0], 24'b0};
// else if(ctrl_LHU_taken == 1 )
//         write_data = {write_data[15:0], 16'b0};

data_memory data_memory(
        .clk(clk),
        .write_en(ctrl_mem_write),
        .write_data(write_data),
        .address(alu_result[7:0]),
        .read_data(mem_data)
);

//all the STORE instructions
// if(ctrl_SB_taken == 1 )
//         mem_data = {24'b0,mem_data[7:0]};
// else if(ctrl_SH_taken == 1 )
//         mem_data = {16'b0,mem_data[15:0]};
// else if(ctrl_SW_taken == 1 )
//         mem_data = mem_data;


endmodule
