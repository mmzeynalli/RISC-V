import common::*;

module instruction_fetch import common::*;
(
        input clk,  
        input rst,  
        input stall,
        input [IMM_WIDTH-1:0] imm,
        input ctrl_branch_taken,
        input ctrl_jump_taken,
        input is_compressed,

        // output  logic [PROGRAM_ADDRESS_WIDTH-1:0] o_pc, 
        // output  logic [PROGRAM_ADDRESS_WIDTH-1:0] o_pc_4, 
        output  logic [INSTRUCTION_WIDTH-1:0] instruction
);

// Combinational logic to determine next PC
logic [PROGRAM_ADDRESS_WIDTH-1:0] pc_next, pc;
logic [INSTRUCTION_WIDTH-1:0] instr;

always @(posedge clk, posedge rst ) begin
        if (rst == RESET)
        begin
                pc <= '0;
                // o_pc <= '0;
        end
        else
        begin
                pc <= pc_next;
                // o_pc <= pc;
        end
end

always_comb begin : next_pc_selection
        pc_next = pc + 4;
        instruction <= instr;

        if (is_compressed) // is compressed (16-bit) instruction
                pc_next = pc + 2;
        
        if (ctrl_branch_taken) // conditional branch
        begin
                pc_next = pc - 4 + 32'(signed'(imm));
                instruction <= NOOP;
        end
        else if (ctrl_jump_taken) // unconditional jump
        begin
                pc_next = imm;
                instruction <= NOOP;
        end
        else if (stall) // Stall condition
                pc_next = pc;
                instruction <= NOOP;

end

instruction_memory instruction_memory(
        .clk(clk),
        .write_en(1'b0),
        .write_data(32'b0),
        .address(pc),
        .read_data(instr)
);




endmodule
