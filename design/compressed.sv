import common::*;

module compressed (
    input [INSTRUCTION_WIDTH-1:0] mem_instruction,

    output compressed,
    output [INSTRUCTION_WIDTH-1:0] instruction


)

always_comb begin : compressed_check
        if (mem_instruction[1:0] == 'b11 )
            compressed = 1'b0;
        else 
            compressed = 1'b1;
end 

always_comb begin : compressed_expand
        case(compressed)
        1'b1:begin
              
                case(mem_instruction[1:0])
                2'b00:begin
                        if ( mem_instruction[15:13] == 'b010) //C.LW
                                instruction = instruction{5'b0, mem_instruction[5], mem_instruction[12:10], mem_instruction[6], 2'b0, 2'b0, mem_instruction[9:7], mem_instruction[15:13], 2'b0, mem_instruction[4:2], 7'b0000011};
                        else if ( mem_instruction[15:13] == 'b110) //C.SW
                                instruction = instruction{5'b0, mem_instruction[5], mem_instruction[12], 2'b0, mem_instruction[4:2], 2'b0, mem_instruction[9:7], mem_instruction[15:13], mem_instruction[11:10],mem_instruction[6], 2'b0, 7'b0100011};
                end
                2'b10:begin
                        if( mem_instruction [15:13] == 'b000)   //C.SLLI
                                instruction = instruction{7'b0, mem_instruction[12], mem_instruction[6:2], mem_instruction[11:7], 3'b001, mem_instruction[11:7], 7'b0010011;}
                        else if ( mem_instruction[15:13] == 'b100) //C.ADD
                                instruction = instruction{7'b0, mem_instruction[6:2], mem_instruction[11:7], 3'b000, mem_instruction[11:7], 7'b0110011};
                end
                2'b01:begin
                        if      ( mem_instruction[15:13] == 'b000)// C.ADDI
                                instruction = instruction{7'b0, mem_instruction[12],mem_instruction[6:2], mem_instruction[11:7], 3'b000, mem_instruction[11:7],7'b0010011};
                        else if ( mem_instruction[15:13] == 'b010) //C.LI
                                instruction = instruction{7'b0, mem_instruction[12],mem_instruction[6:2], mem_instruction[11:7], 8'b0, 7'b0010011};
                        else if ( mem_instruction[15:13] == 'b011) //C.LUI
                                instruction = instruction {14'b0, mem_instruction[12],mem_instruction[6:2], mem_instruction[11:7], 7'b0110111};
                        else if ( mem_instruction[15:13] == 'b100 ) begin

                                case(mem_instruction[11:10])
                                2'b00: //C.SRLI 
                                        instruction = instruction{7'b0, mem_instruction[12], mem_instruction[6:2], 2'b0, mem_instruction[9:7], 3'b101, 2'b0, mem_instruction[9:7], 7'b0010011};
                                2'b01: //C.SRAI
                                        instruction = instruction{7'b0100000, mem_instruction[12], mem_instruction[6:2], 2'b0, mem_instruction[9:7], 3'b101, 2'b0, mem_instruction[9:7], 7'b0010011};
                                2'b10: //C.ANDI
                                        instruction = instruction{7'b0, mem_instruction[12],mem_instruction[6:2], 2'b0, mem_instruction[9:7], 3'b111, 2'b0, mem_instruction[9:7],7'b0010011};      
                                2'b11:begin

                                        case(mem_instruction[6:5])
                                        2'b00: //C.SUB
                                                instruction = instruction{7'b0100000, mem_instruction[6:2], 2'b0, mem_instruction[9:7], 3'b000,2'b0, mem_instruction[9:7], 7'b0110011};
                                        2'b01: //C.XOR
                                                instruction = instruction{7'b0, 2'b0, mem_instruction[4:2], 2'b0, mem_instruction[9:7], 3'b111,2'b0, mem_instruction[9:7], 7'b0110011};
                                        2'b10: //C.OR
                                                instruction = instruction{7'b0, 2'b0, mem_instruction[4:2], 2'b0, mem_instruction[9:7], 3'b110, 2'b0, mem_instruction[9:7], 7'b0110011};
                                        2'b11: //C>AND
                                                instruction = instruction{7'b0, 2'b0, mem_instruction[4:2], 2'b0, mem_instruction[9:7], 3'b111, 2'b0, mem_instruction[9:7], 7'b0110011}; 
                                        default:
                                                $error("Unknown Instruction");
                                        endcase
                                end
                                default:
                                        $error("unknown instruction");
                                endcase

                        end
                end
                default: 
                        $error("unknown instruction");
                endcase
        end
        1'b0:    
                   instruction = mem_instruction;
        default: 
                   $error("unknown instruction");
        endcase                  
end
            
                    
endmodule