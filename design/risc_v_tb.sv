`timescale 1ns / 1ns
`include "risc_v.sv"

module risc_v_tb;

  // Parameters
  parameter int DATA_ADDRESS_WIDTH = 6;
  parameter int CPU_DATA_WIDTH = 32;
  parameter int REGISTER_FILE_ADDRESS_WIDTH = 5;

  // Inputs
  logic clk;
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
    rst = 1;
    #10 rst = 0;
  end

  // Load instruction memory file
  initial begin
    $readmemh("instruction_mem.mem", dut.if_stage.instruction.mem, 0, 1023);
  end

  // Wait for simulation to finish
  initial begin
    #10000;
    $finish;
  end

endmodule



