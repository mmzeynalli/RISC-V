module riscv_assembler (
  input  logic [31:0] instruction,
  output logic [6:0]  opcode,
  output logic [4:0]  funct3,
  output logic [6:0]  rd,
  output logic [4:0]  rs1,
  output logic [4:0]  rs2,
  output logic [4:0]  funct7,
  output logic [11:0] immediate
);

  always_comb begin
    opcode    = instruction[6:0];
    rd        = instruction[11:7];
    funct3    = instruction[14:12];
    rs1       = instruction[19:15];
    rs2       = instruction[24:20];
    funct7    = instruction[31:25];

    case (opcode)
      // R-type instructions
      7'b0110011: begin
        immediate = 0;
      end

      // I-type instructions
      7'b0010011, 7'b0000011, 7'b1100111, 7'b0001111: begin
        immediate = {instruction[31], instruction[30:20]};
      end

      // SB-type instructions
      7'b1100011: begin
        immediate = {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
      end

      // UJ-type instructions
      7'b1101111: begin
        immediate = {instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
      end

      default: begin
        immediate = 0;
      end
    endcase
  end

endmodule
