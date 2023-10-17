import common::*;

module div_int (
        input clk,
        input rst,
        input start,

        input is_signed,             
        output logic busy,             // calculation in progress
        output logic done,             // calculation is complete (high for one tick)
        output logic valid,            // result is valid
        output logic dbz,              // divide by zero

        input [OPERAND_WIDTH-1:0] a,    // dividend (numerator)
        input [OPERAND_WIDTH-1:0] b,    // divisor (denominator)

        output logic [OPERAND_WIDTH-1:0] res,  // result value: quotient
        output logic [OPERAND_WIDTH-1:0] rem   // result: remainder
);

function [4:0] log2;
        input [31:0] value;

        begin
                for (int i = OPERAND_WIDTH - 1; i >= 0; i = i - 1)
                        if (value[i]) 
                                return i + 1;
        end
endfunction

logic [OPERAND_WIDTH-1:0] quo, quo_next;  // intermediate quotient
logic [OPERAND_WIDTH:0] acc, acc_next;    // accumulator (1 bit wider)
logic [4:0] i, max_iter;      // iteration counter

logic [OPERAND_WIDTH-1:0] dividend, divisor;
logic a_sign, b_sign;

// division algorithm iteration
always_comb begin
        if (acc >= {1'b0, divisor})
        begin
                acc_next = {acc - divisor, dividend[max_iter - i]};       
                quo_next = (quo + 1) << 1;
        end
        else
        begin
                acc_next = {acc, dividend[max_iter - i]};
                quo_next = quo << 1;
        end
end

always_ff @(posedge clk) begin
        if (rst == RESET) 
        begin
                busy <= 0;
                done <= 0;
                valid <= 0;
                dbz <= 0;
                res <= 0;
                rem <= 0;
                max_iter <= 0;
                
                quo <= 0;
                acc <= 0;
                divisor <= 0;
                dividend <= 0;
                i = 0;
        end
        else
        begin
                done = 0;

                if (start) 
                begin
                        valid = 0;
                        if (a == 0) // catch divide by zero 
                        begin  
                                busy <= 0;
                                done <= 1;
                                dbz <= 1;
                        end 
                        // else if (divisor > dividend)  // no need for multiple cycles
                        // begin
                        //         busy <= 0;
                        //         done <= 1;
                        //         res <= 0;
                        //         rem <= a;
                        //         valid <= 1;
                        // end
                        else
                        begin
                                busy <= 1;
                                dbz <= 0;
                                acc <= 0;
                                quo <= '0;
                                i = 0;

                                a_sign = 0;
                                b_sign = 0;
                                dividend = a;
                                divisor = b;

                                if (is_signed)
                                begin
                                        if (a[OPERAND_WIDTH-1])
                                        begin
                                                dividend = -a;
                                                a_sign = 1;
                                        end

                                        if (b[OPERAND_WIDTH-1])
                                        begin
                                                divisor = -b;
                                                b_sign = 1;
                                        end
                                end
                                
                                max_iter <= log2(dividend);
                        end
                end
                else if (busy)
                begin
                        if (i == max_iter + 1) // we're done, one extra cycle to set acc, quo
                        begin  
                                busy <= 0;
                                done <= 1;
                                valid <= 1;
                                res <= (a_sign ^ b_sign) ? -quo : quo;
                                rem <= (a_sign) ? -acc[OPERAND_WIDTH-1:0] : acc[OPERAND_WIDTH-1:0];                        end 
                        else 
                        begin  // next iteration
                                i <= i + 1;
                                acc <= acc_next;
                                quo <= quo_next;
                        end
                end
        end
end
endmodule