import common::*;

module ALU #(
        int DATA_WIDTH = 32
) (
        input [4:0] operation,
        input [DATA_WIDTH-1:0]  A,
        input [DATA_WIDTH-1:0]  B,

        output logic zero,
        output logic [DATA_WIDTH-1:0] result // ???
);


logic [DATA_WIDTH-1:0] alu_result;
wire        sltResult;
wire        sltuResult;
wire        sraResult;

always_comb begin : ALU



        case (operation)
                SLL  :    alu_result = A << B;
                SLLI :    alu_result = A << B;
                SRL  :    alu_result = A >> B;
                SRLI :    alu_result = A >> B;
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
                SLT  :  begin
                        if (A < B)
                                sltResult = 1;
                        else
                                sltResult = 0;
                        alu_result = { {32{sltResult}}, 1'b0 };
                        end
                SLTU :  begin
                        if (unsigned(A) < unsigned(B))
                                sltuResult = 1;
                        else
                                sltuResult = 0;
                        alu_result = { {32{sltuResult}}, 1'b0 };
                        end
                SRA :   begin
                        if (B[4:0] > 31)
                                sraResult = { {32{A[31]}}, A[31:1] };
                        else
                                sraResult = { {B[4:0], A[31]} , A[31:B[4:0]+1] };
                        alu_result = sraResult;
                        end
                default: 
                        $error("No such operation!!, %d\n", operation);
        endcase
end

always_comb begin : _output  
        result = alu_result;
        zero = signed'(alu_result) == 0 ? 'b1  : 'b0;
end

endmodule
