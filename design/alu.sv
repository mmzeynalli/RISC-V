import common::*;

module ALU import common::*;
(
        input clk,
        input rst,
        input [OPERAND_WIDTH-1:0]  A,
        input [OPERAND_WIDTH-1:0]  B,
        input alu_operation_type operation,

        output logic zero,
        output logic [OPERAND_WIDTH-1:0] result,
        output logic stall
);


logic [OPERAND_WIDTH-1:0] alu_result;

// DIV and REM
logic div_begin, div_done, div_busy, div_valid, div_dbz, div_is_signed;
logic [OPERAND_WIDTH-1:0] div_result, rem_result;


always_comb begin : calculate

        div_begin = 0;
        stall = 0;
        
        case (operation)
                SLL  :  alu_result = A << B;
                SRL  :  alu_result = A >> B;
                ADD  :  alu_result = A + B;
                SUB  :  alu_result = A - B;
                MUL  :  alu_result = A * B;
                MULH :  alu_result = (A * B) >> 32;
                LUI  :  alu_result = {B[19:0], 12'h0};
                AUIPC:  alu_result = A + {B[19:0], 12'h0};
                XOR  :  alu_result = A ^ B;
                OR   :  alu_result = A | B;
                AND  :  alu_result = A & B;
                SLT  :  alu_result = (A < B) ? 32'h1 : 32'h0;
                SLTU :  alu_result = (unsigned'(A) < unsigned'(B)) ? 32'h1 : 32'h0;
                SRA  :  alu_result = A >>> B;
                DIV:
                begin
                        // First clk cycle
                        if (~div_busy && ~div_done)
                                div_begin <= 1;
                        
                        stall = 1;
                        div_is_signed = 1;

                        if (div_done && div_valid)
                        begin
                                alu_result = div_result;
                                stall = 0;
                        end
                end
                DIVU:
                begin
                        if (~div_busy && ~div_done)
                                div_begin <= 1;
                        
                        stall = 1;
                        div_is_signed = 0;

                        if (div_done && div_valid)
                        begin
                                alu_result = div_result;
                                stall = 0;
                        end
                end
                REM:
                begin
                        if (~div_busy && ~div_done)
                                div_begin <= 1;
                        
                        stall = 1;
                        div_is_signed = 1;

                        if (div_done && div_valid)
                        begin
                                alu_result = rem_result;
                                stall = 0;
                        end
                end
                REMU:
                begin
                        if (~div_busy && ~div_done)
                                div_begin <= 1;
                        
                        stall = 1;
                        div_is_signed = 0;

                        if (div_done && div_valid)
                        begin
                                alu_result = rem_result;
                                stall = 0;
                        end
                end
                default: 
                        alu_result = 0;
        endcase
end

always_comb begin : _output  
        result = alu_result;
        zero = signed'(alu_result) == 0 ? 'b1  : 'b0;
end

div_int divisor(
        .clk(clk),
        .rst(rst),
        .start(div_begin),

        .busy(div_busy),
        .done(div_done),
        .valid(div_valid),
        .dbz(div_dbz),

        .a(A),
        .b(B),
        .is_signed(div_is_signed),

        .res(div_result),
        .rem(rem_result)
);

endmodule
