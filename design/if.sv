import common::*;

module instruction_fetch import common::*;
(
        input clk,
        input rst,

        input [INSTRUCTION_WIDTH-1:0] mem_instruction,
        input [IMM_WIDTH-1:0] imm,
        input [DATA_WIDTH-1:0] pc_JALR,

        input stall,
        input ctrl_prev_is_compressed,
        input ctrl_branch_taken,
        input ctrl_AUIPC_taken,
        input ctrl_jump_taken,

        output  logic [PROGRAM_ADDRESS_WIDTH-1:0] o_pc,
        output  logic [PROGRAM_ADDRESS_WIDTH-1:0] o_pc_next, 
        
        // output  logic [PROGRAM_ADDRESS_WIDTH-1:0] o_pc_4, 
        output  logic [INSTRUCTION_WIDTH-1:0] instruction
);

// Combinational logic to determine next PC
logic [PROGRAM_ADDRESS_WIDTH-1:0] pc_next, pc;
logic [INSTRUCTION_WIDTH-1:0] instr;

always @(posedge clk) begin
        if (rst == RESET)
                pc <= '0;
        else
                pc <= pc_next;
end

always_comb begin : next_pc_selection
        o_pc <= pc;
        pc_next = pc + 4;
        o_pc_next <= pc_next;
        instruction = mem_instruction;

        if (stall) // Stall condition
                pc_next = pc;
        else if (ctrl_branch_taken) // conditional branch/JAL
        begin
                pc_next = pc - ((ctrl_prev_is_compressed) ? 2 : 4) + 32'(signed'(imm));  // FIX THIS!!
                instruction = NOOP;
        end
        else if (ctrl_jump_taken) // JALR 
        begin
                pc_next = pc_JALR;
                instruction = NOOP;
        end
        
        else if (mem_instruction[1:0] != 2'b11) // is compressed (16-bit) instruction
                pc_next = pc + 2;  

end

endmodule
