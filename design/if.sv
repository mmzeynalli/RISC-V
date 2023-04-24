import common::*;

module instruction_fetch
(
        input clk,
        input [PROGRAM_ADDRESS_WIDTH - 1:0] pc,
        output instruction_type instruction
);

always @(posedge clk) begin
        
end

endmodule
