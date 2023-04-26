import common::*;

module moduleName #(
        int DATA_WIDTH = 32
) (
        input [4:0] operation,
        input [DATA_WIDTH-1:0]  A,
        input [DATA_WIDTH-1:0]  B,

        output logic zero,
        output logic [DATA_WIDTH-1:0] result // ???
);


logic [DATA_WIDTH-1:0] alu_result;

always_comb begin : ALU

// shift amount for SLL, SLLI, SRL and SRLI defined by shamt
shamt = B[4:0];

        case (operation)
                SLL  :    alu_result = A << shamt;
                SLLI :    alu_result = A << shamt;
                SRL  :    alu_result = A >> shamt;
                SRLI :    alu_result = A >> shamt;
                ADD  :    alu_result = A + B;
                ADDI :    alu_result = A + B;
                SUB  :    alu_result = A - B;
                LUI  :    alu_result = {B, 12'h0};
                XOR  :    alu_result = A ^ B;
                XORI :    alu_result = A ^ {B[31:0], {20{1'b0}}};
                OR   :    alu_result = A | B;
                ORI  :    alu_result = A | {B[31:0], {20{1'b0}}};
                AND  :    alu_result = A & B;
                ANDI :    alu_result = A & {B[31:0], {20{1'b0}}};
                
                default: 
                        $error("No such operation!!, %d\n", operation);
        endcase
end

always_comb begin : _output  
        result = alu_result;
        zero = signed'(alu_result) == 0 ? 'b1  : 'b0;
end

endmodule
