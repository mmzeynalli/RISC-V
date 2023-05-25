import common::*;

module ALU import common::*; #(
        int DATA_WIDTH = 32
) (
        input [DATA_WIDTH-1:0]  A,
        input [DATA_WIDTH-1:0]  B,
        input alu_operation_type operation,

        output logic zero,
        output logic [DATA_WIDTH-1:0] result
);


logic [DATA_WIDTH-1:0] alu_result;
logic        sltResult;
logic        sltuResult;
logic        sraResult;

always_comb begin : calculate

        case (operation)
                SLL :  alu_result = A << B;
                SRL :  alu_result = A >> B;
                ADD :  alu_result = A + B;
                SUB :  alu_result = A - B;
                LUI :  alu_result = {B, 12'h0};
                XOR :  alu_result = A ^ B;
                OR  :  alu_result = A | B;
                AND :  alu_result = A & B;
                SLT :  alu_result = (A < B) ? 32'h1 : 32'h0;
                SLTU:  alu_result = (unsigned'(A) < unsigned'(B)) ? 32'h1 : 32'h0;
                SRA :  alu_result = A >>> B;
                default: 
                        alu_result = 0;
        endcase
end

always_comb begin : _output  
        result = alu_result;
        zero = signed'(alu_result) == 0 ? 'b1  : 'b0;
end

endmodule
