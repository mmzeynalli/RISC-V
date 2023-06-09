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
        .rx('0),
        .tx()
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
                dut.instruction_memory.ram[i][0] = data32[31];
                dut.instruction_memory.ram[i][1] = data32[30];
                dut.instruction_memory.ram[i][2] = data32[29];
                dut.instruction_memory.ram[i][3] = data32[28];
                dut.instruction_memory.ram[i][4] = data32[27];
                dut.instruction_memory.ram[i][5] = data32[26];
                dut.instruction_memory.ram[i][6] = data32[25];
                dut.instruction_memory.ram[i][7] = data32[24];
                dut.instruction_memory.ram[i][8] = data32[23];
                dut.instruction_memory.ram[i][9] = data32[22];
                dut.instruction_memory.ram[i][10] = data32[21];
                dut.instruction_memory.ram[i][11] = data32[20];
                dut.instruction_memory.ram[i][12] = data32[19];
                dut.instruction_memory.ram[i][13] = data32[18];
                dut.instruction_memory.ram[i][14] = data32[17];
                dut.instruction_memory.ram[i][15] = data32[16];
                i = i + 1;

                if (data32[31:30] == 2'b11)
                begin
                        dut.instruction_memory.ram[i][0] = data32[15];
                        dut.instruction_memory.ram[i][1] = data32[14];
                        dut.instruction_memory.ram[i][2] = data32[13];
                        dut.instruction_memory.ram[i][3] = data32[12];
                        dut.instruction_memory.ram[i][4] = data32[11];
                        dut.instruction_memory.ram[i][5] = data32[10];
                        dut.instruction_memory.ram[i][6] = data32[9];
                        dut.instruction_memory.ram[i][7] = data32[8];
                        dut.instruction_memory.ram[i][8] = data32[7];
                        dut.instruction_memory.ram[i][9] = data32[6];
                        dut.instruction_memory.ram[i][10] = data32[5];
                        dut.instruction_memory.ram[i][11] = data32[4];
                        dut.instruction_memory.ram[i][12] = data32[3];
                        dut.instruction_memory.ram[i][13] = data32[2];
                        dut.instruction_memory.ram[i][14] = data32[1];
                        dut.instruction_memory.ram[i][15] = data32[0];
                        i = i + 1;
                end
        end
end

logic [31:0] expected_register_file [31:0];
logic [31:0] expected_memory [63:0];

// Wait for simulation to finish
initial begin
        #10000;

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
