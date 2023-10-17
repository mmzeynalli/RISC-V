module RISC_V_ILA (
    input logic clk,                      // Clock signal
    input logic rst,                      // Reset signal
    input logic [31:0] riscv_registers [31:0],  // RISC-V register file
    input logic [63:0] riscv_memory [63:0],     // RISC-V memory
    input logic [31:0] expected_register_file [31:0],  // Expected register file data
    input logic [63:0] expected_memory [63:0],     // Expected memory file data
    output logic flag_registers_match,   // Flag indicating matching register files
    output logic flag_memory_match       // Flag indicating matching memory contents
);

logic flag_registers_match_internal;
logic flag_memory_match_internal;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        flag_registers_match_internal <= 1'b0;
        flag_memory_match_internal <= 1'b0;
    end else begin
        // Check for matching register files
        if (riscv_registers === expected_register_file) begin
            flag_registers_match_internal <= 1'b1;
        end else begin
            flag_registers_match_internal <= 1'b0;
        end

        // Check for matching memory contents
        if (riscv_memory === expected_memory) begin
            flag_memory_match_internal <= 1'b1;
        end else begin
            flag_memory_match_internal <= 1'b0;
        end
    end
end

assign flag_registers_match = flag_registers_match_internal;
assign flag_memory_match = flag_memory_match_internal;

endmodule
