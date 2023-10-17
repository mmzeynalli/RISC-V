import common::*;

module ila_rm import common::*;
(
    input rst,
    input register_array register_file,
    output logic ok
);


///////////// TEST //////////////////////
/*
ADDI R1, R0, 20
ADDI R2, R9, 3
ADDI R0, R0, 0
REM R3,R1,R2
DIV R4,R1,R2
SW R1, 0x1000(R0)   // Store the value of R1 at memory address 0x1000
SW R2, 0x1004(R0)   // Store the value of R2 at memory address 0x1004
SW R3, 0x1008(R0)   // Store the value of R3 at memory address 0x1008
SW R4, 0x100C(R0)   // Store the value of R4 at memory address 0x100C
*/
//////////////////////////////////////////

register_array expected_values;


always_comb begin: rst_exp_regs
    if (rst == RESET)
    begin
        for (int i = 0; i < $size(expected_values); i++)
            expected_values[i] = '{default: '0};  // hard code here
        
        // ok = 0;
    end
end


// Store the expected register values after instruction execution
    initial begin
        // Initialize the expected_values array with 32-bit values for registers
        expected_values[0] = 32'h00000014;  // R1
        expected_values[1] = 32'h00000003;  // R2
        expected_values[3] = 32'h00000002;  // R3
        expected_values[4] = 32'h00000006;  // R4
    end


always_comb begin : check_regs
    ok = 1;
    
    for (int i = 0; i < $size(expected_values); i++)
    begin
        if (register_file[i] != expected_values[i])
        begin
            ok = 0;
            break;
        end
    end
end



endmodule



module ila_dm import common::*;
(
    input rst,
    input memory_array memory_file,
    output logic ok
);

memory_array expected_values;



always_comb begin : rst_exp_mem
    if (rst == RESET)
    begin
        for (int i = 0; i < $size(expected_values); i++)
            expected_values[i] = '{default: '0};  // hard code here
        
        // ok = 0;
    end
end

// Store the expected memory values after instruction execution
    initial begin
        // Initialize the expected_values array with 32-bit values for memory
        expected_values[0] = 32'h00000014;  // Memory value at address 0 (R1)
        expected_values[1] = 32'h00000003;  // Memory value at address 4 (R2)
        expected_values[2] = 32'h00000002;  // Memory value at address 8 (R3)
        expected_values[3] = 32'h00000006;  // Memory value at address 12 (R4)
    end


always_comb begin : check_mem
    ok = 1;
    
    for (int i = 0; i < $size(expected_values); i++)
        if (memory_file[i] != expected_values[i])
        begin
            ok = 0;
            break;
        end
end


endmodule