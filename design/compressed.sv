import common::*;

module compressed ()

always_comb begin : compressed_check
        if (instruction[1:0] == '11' )
            compressed = 1'b0;
        else 
            compressed = 1'b1;
end 

always_comb begin : compressed_expand
        if (compressed == 1'b1)
             if ( instruction[1:0] == 'b00) begin
                    if      ( instruction[15:13] == 'b010) //C.LW
                            o_instruction = 5'b0, instruction[5], instruction[12:10], instruction[6], 2'b0, 2'b0, instruction[9:7], instruction[15:13], 2'b0, instruction[4:2], 7'b0000011;
                    else if ( instruction[15:13] == 'b110) //C.SW
                            o_instruction = 5'b0, instruction[5], instruction[12], 2'b0, instruction[4:2], 2'b0, instruction[9:7], instruction[15:13], instruction[11:10],instruction[6], 2'b0, 7'b0100011;
             end

             else if ( instruction[1:0] == 'b10) begin
                    if( instruction [15:13] == 'b000)   //C.SLLI
                            o_instruction = 7'b0, instruction[12], instruction[6:2], instruction[11:7], 3'b001, instruction[11:7], 7'b0010011;
                    else if ( instruction[15:13] == 'b100) //C.ADD
                            o_instruction = 7'b0, instruction[6:2], instruction[11:7], 3'b000, instruction[11:7], 7'b0110011;
             end
            
             else if  ( instruction[1:0] == 'b01) begin
                       if ( instruction[15:13] == 'b000)// C.ADDI
                                    o_instruction = 7'b0, instruction[12],instruction[6:2], instruction[11:7], 3'b000, instruction[11:7],7'b0010011;
                       else if ( instruction[15:13] == 'b010) //C.LI
                                    o_instruction = 7'b0, instruction[12],instruction[6:2], instruction[11:7], 8'b0, 7'b0010011;
                       else if ( instruction[15:13] == 'b011) //C.LUI
                                    o_instruction = 14'b0, instruction[12],instruction[6:2], instruction[11:7], 7'b0110111;
                       else if ( instruction[15:13] == 'b100 ) begin
                                         if ( instruction[11:10] == 'b00 )// C.SRLI
                                                 o_instruction = 7'b0, instruction[12], instruction[6:2], 2'b0, instruction[9:7], 3'b101, 2'b0, instruction[9:7], 7'b0010011;
                                         else if ( instruction[11:10] == 'b00 )// C.SRAI
                                                 o_instruction = 7'b0100000, instruction[12], instruction[6:2], 2'b0, instruction[9:7], 3'b101, 2'b0, instruction[9:7], 7'b0010011;
                                         else if ( instruction[11:10] == 'b00 )// C.ANDI
                                                 o_instruction = 7'b0, instruction[12],instruction[6:2], 2'b0, instruction[9:7], 3'b111, 2'b0, instruction[9:7],7'b0010011;
                                         else begin 
                                                       if (instruction[6:5] == 'b00)// C.SUB
                                                                o_instruction = 7'b0100000, instruction[6:2], 2'b0, instruction[9:7], 3'b000,2'b0, instruction[9:7], 7'b0110011;
                                                       else if (instruction[6:5] == 'b01)//C.XOR
                                                                o_instruction = 7'b0, 2'b0, instruction[4:2], 2'b0, instruction[9:7], 3'b111,2'b0, instruction[9:7], 7'b0110011;
                                                       else if  (instruction[6:5] == 'b10)//C.OR
                                                                o_instruction = 7'b0, 2'b0, instruction[4:2], 2'b0, instruction[9:7], 3'b110, 2'b0, instruction[9:7], 7'b0110011;
                                                       else // C.AND
                                                                o_instruction = 7'b0, 2'b0, instruction[4:2], 2'b0, instruction[9:7], 3'b111, 2'b0, instruction[9:7], 7'b0110011;
                                         end

                        
                        end
            end
end
            
                    



















endmodule