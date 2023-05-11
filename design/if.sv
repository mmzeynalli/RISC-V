import common::*;

module instruction_fetch import common::*;
(
        input   logic clk,
        input   logic rst,
        input   logic stall,
        input   logic [20:0] imm,
        input   logic ctrl_branch_taken,
        input   logic ctrl_jump_taken,
        input   logic [DATA_WIDTH-1:0] read_data,
        input   logic [PROGRAM_ADDRESS_WIDTH - 1:0] pc_in,
        output  logic [PROGRAM_ADDRESS_WIDTH - 1:0] pc_out,
        output  logic [31:0] instruction
);

// Sign-extend immediate value to 32 bits.
logic [31:0] sign_extended_imm;
assign sign_extended_imm = {{11{imm[20]}}, imm};


// Combinational logic to determine next PC
logic [PROGRAM_ADDRESS_WIDTH-1:0] pc_next; 

always @(*) begin
        if (rst) begin
                pc_next = 32'd0; // reset
        end
        else if (ctrl_branch_taken) begin // conditional branch
                pc_next = pc_in + sign_extended_imm; 
        end
        else if (ctrl_jump_taken) begin // unconditional jump
                pc_next = sign_extended_imm;
        end
        else if (stall) begin // Stall condition
                pc_next = pc_in; 
        end
        else begin // all other instructions
                pc_next = pc_in + 4;
        end
end

// Registers to store PC and instruction values
logic [PROGRAM_ADDRESS_WIDTH-1:0] pc;
logic [31:0] inst_reg;

always @(posedge clk) begin
        if(rst == RESET) begin
                pc <= 32'd0;
                inst_reg <= 32'd0;
        end
        else begin
                pc <= pc_next;
                inst_reg <= read_data; // no changes in the instruction
        end
end

// Output PC and instructions 
assign instruction = inst_reg;
assign pc_out = pc;

endmodule
