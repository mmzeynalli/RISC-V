`timescale 1ns / 1ns
import common::*;

module risc_v_tb;

// Parameters
localparam int DATA_ADDRESS_WIDTH = 6;
localparam int CPU_DATA_WIDTH = 32;
localparam int REGISTER_FILE_ADDRESS_WIDTH = 5;

// Inputs
logic clk = 0;
logic rst;

// Instantiate DUT
risc_v #(
        .DATA_ADDRESS_WIDTH(DATA_ADDRESS_WIDTH),
        .CPU_DATA_WIDTH(CPU_DATA_WIDTH),
        .REGISTER_FILE_ADDRESS_WIDTH(REGISTER_FILE_ADDRESS_WIDTH)
) dut (
        .clk(clk),
        .rst(rst)
);

// Generate clock
always #5 clk = ~clk;

// Reset
initial begin
        rst = RESET;
        #10 rst = ~RESET;
end

// Load instruction memory file
initial begin
        dut.if_stage.instruction_memory.ram = '{default: 'h13};  // nop
        $readmemb("test_instructions.mem", dut.if_stage.instruction_memory.ram);
end

logic [31:0] expected_register_file [31:0];

// Wait for simulation to finish
initial begin
        #1000;

        $readmemb("expected_register_file.txt", expected_register_file);

        for (int i = 0; i < 32; i++)
        begin
                assert (expected_register_file[i] == dut.register_file.registers[i])
                else
                        $display("%d: %b == %b", i, expected_register_file[i], dut.register_file.registers[i]);
        end

        $finish;
end

endmodule



