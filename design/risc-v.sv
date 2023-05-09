import common::*;

module risc_v #(
        int DATA_ADDRESS_WIDTH = 6,
        int CPU_DATA_WIDTH = 32,
        int REGISTER_FILE_ADDRESS_WIDTH = 5
) (
        input clk,
        input rst
);


logic [PROGRAM_ADDRESS_WIDTH - 1:0] pc, pc_next;
logic [31:0] instruction, instruction_next;

instruction_fetch if_stage(
        .clk(clk),
        .rst(rst),
        .pc_out(pc_next),
        .instruction(instruction)
);

instruction_decode id_stage(
        .instruction(instruction)

);

execute ex_stage(

);

memory mem_stage(
        
);

write_back wb_stage(

);

always @(posedge clk) begin
        if (rst == RESET)
        begin
                pc = 6'b0;
                instruction = 32'b0;
        end
        else
        begin
                pc = pc_next;
        end
end

        
endmodule
