`timescale 1ns / 1ns
`define ASSERT

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
        .rst(rst),
        .rx('0)
);

// Generate clock
always #5 clk = ~clk;

// Reset
initial begin
        rst = RESET;
        #10 rst = ~RESET;
end

int fd;
string line;
int data32;
int i;
int tmp;

// Load instruction memory file
initial begin

        dut.instruction_memory.ram = '{default: '0};  // nop

        fd = $fopen("test_instructions.mem", "r");

        if (fd == 0) begin
                $display("Error opening instructions file.");
                $finish;
        end

        i = 0;
        while (!$feof(fd) && $fscanf(fd, "%32b", data32) == 1)
        begin
                dut.instruction_memory.ram[i] = data32[15:0];
                i = i + 1;

                if (data32[1:0] == 2'b11)
                begin
                        dut.instruction_memory.ram[i] = data32[31:16];
                        i = i + 1;
                end
        end

        // Loop
        for (i = i; i < 62; i = i + 2)
                dut.instruction_memory.ram[i] = 16'(NOOP);

        dut.instruction_memory.ram[63] = 16'b0;
        dut.instruction_memory.ram[62] = INF_LOOP;
end

logic [31:0] expected_register_file [31:0];
logic [31:0] expected_memory [63:0];

// Wait for simulation to finish
initial begin
        #2000;

        $readmemb("expected_register_file.txt", expected_register_file);

        for (int i = 0; i < 32; i++)
        begin
                `ifdef ASSERT
                assert (expected_register_file[i] == dut.register_file.registers[i])
                else
                        $display("Register %d: Expected %b, got %b", i, expected_register_file[i], dut.register_file.registers[i]);
                `endif
                $display("Register %d: %b", i, dut.register_file.registers[i]);
        
        end

        $readmemb("expected_memory.txt", expected_memory);
        $display("");

        for (int i = 0; i < 32; i++)
        begin
                `ifdef ASSERT
                assert (expected_memory[i] == dut.mem_stage.data_memory.ram[i])
                else
                        $display("Memory %d: Expected %b, got %b", i, expected_memory[i], dut.mem_stage.data_memory.ram[i]);
                `endif
                $display("Memory %d: %b", i, dut.mem_stage.data_memory.ram[i]);
        end

        $finish;
end

endmodule
