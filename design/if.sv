import common::*;

module instruction_fetch
(
        input clk,
        input rst,
        input stall,
        input [11:0] SB_type,
        input [11:0] UJ_type,
        
        input [PROGRAM_ADDRESS_WIDTH - 1:0] pc_in,
        input [PROGRAM_ADDRESS_WIDTH - 1:0] pc_out,
        output [31:0] instruction
);

reg [PROGRAM_ADDRESS_WIDTH-1:0] pc;
reg [PROGRAM_ADDRESS_WIDTH-1:0] pc_next;
reg [31:0] inst_reg;

always @(posedge clk) begin
        if(!rst) begin
                pc <= 0;
                inst_reg <= 0;
        end
        else begin
                if(stall) begin
                        pc <= pc; // Stalling at the same pc
                end
                else begin
                        pc <= pc_next;
                end
                inst_reg <= inst_reg;// no changes in the instruction 
        end
end
        
always @(*) begin
        pc_next = pc + 4;
end

// fetch instruction from memory based on PC value 
assign instruction = inst_reg;

// Handling different type of instructions like SB, UJ JALR types 
always @(*) begin
        case(inst_reg[6:0])
        7'h63: begin // SB-type (branch)
                pc_next = (pc_reg + {{pc_reg[31], instr_reg[7], instr_reg[30:25], instr_reg[11:8], 2'b0}}) - 4;
            end
        7'h6F: begin // UJ-type (unconditional jump)
                pc_next = (pc_reg + {{pc_reg[31], instr_reg[20], instr_reg[10:1], instr_reg[11], 1'b0}}) - 4;
            end
        7'h67: begin // JALR-type (jump and link register)
                pc_next = pc_reg + instr_reg[19:15];
            end
            default: begin // all other instructions
                pc_next = pc_reg + 4;


endmodule
