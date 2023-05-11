`include "risc_v.sv"

module risc_v_tb;

  // Parameters
  parameter int DATA_ADDRESS_WIDTH = 6;
  parameter int CPU_DATA_WIDTH = 32;
  parameter int REGISTER_FILE_ADDRESS_WIDTH = 5;

  // Clock and Reset
  logic clk;
  logic rst;

  // Instantiate RISC-V module
  risc_v #(
    .DATA_ADDRESS_WIDTH(DATA_ADDRESS_WIDTH),
    .CPU_DATA_WIDTH(CPU_DATA_WIDTH),
    .REGISTER_FILE_ADDRESS_WIDTH(REGISTER_FILE_ADDRESS_WIDTH)
  ) dut (
    .clk(clk),
    .rst(rst)
  );

  // Clock generator
  always #5 clk = ~clk;

  // Reset generator
  initial begin
    rst = 1;
    #10;
    rst = 0;
    #10;
  end

  // Test cases
  initial begin
    // Test case 1

  end

endmodule
