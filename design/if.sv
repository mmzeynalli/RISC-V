import common::*;

module instruction_fetch
(
        input clk,
        input [PROGRAM_ADDRESS_WIDTH - 1:0] pc,
        output [31:0] instruction
);

always @(posedge clk) begin
        
end

endmodule
