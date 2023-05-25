import common::*;

module compressed (
    input [INSTRUCTION_WIDTH-1:0] mem_instruction,

    output logic is_compressed,
    output logic [INSTRUCTION_WIDTH-1:0] instruction
);

always_comb begin : compressed_expand

        is_compressed <= '1;
        instruction <= mem_instruction;
        
        case(mem_instruction[1:0])
        2'b11:
        begin        
                is_compressed <= '0;
        end
        2'b00:
        begin
                if (mem_instruction[15:13] == 'b010) //C.LW
                        instruction <= {5'b0, mem_instruction[5], mem_instruction[12:10], mem_instruction[6], 2'b0, 2'b0, mem_instruction[9:7], mem_instruction[15:13], 2'b0, mem_instruction[4:2], 7'b0000011};
                else if (mem_instruction[15:13] == 'b110) //C.SW
                        instruction <= {5'b0, mem_instruction[5], mem_instruction[12], 2'b0, mem_instruction[4:2], 2'b0, mem_instruction[9:7], mem_instruction[15:13], mem_instruction[11:10],mem_instruction[6], 2'b0, 7'b0100011};
        end
        2'b10:
        begin
                if(mem_instruction [15:13] == 'b000)   //C.SLLI
                        instruction <= {7'b0, mem_instruction[12], mem_instruction[6:2], mem_instruction[11:7], 3'b001, mem_instruction[11:7], 7'b0010011};
                else if (mem_instruction[15:13] == 'b100) //C.ADD
                        instruction <= {7'b0, mem_instruction[6:2], mem_instruction[11:7], 3'b000, mem_instruction[11:7], 7'b0110011};
        end
        2'b01:
        begin
                if      (mem_instruction[15:13] == 'b000)// C.ADDI
                        instruction <= {7'b0, mem_instruction[12],mem_instruction[6:2], mem_instruction[11:7], 3'b000, mem_instruction[11:7],7'b0010011};
                else if (mem_instruction[15:13] == 'b010) //C.LI
                        instruction <= {7'b0, mem_instruction[12],mem_instruction[6:2], mem_instruction[11:7], 8'b0, 7'b0010011};
                else if (mem_instruction[15:13] == 'b011) //C.LUI
                        instruction <= {14'b0, mem_instruction[12],mem_instruction[6:2], mem_instruction[11:7], 7'b0110111};
                else if (mem_instruction[15:13] == 'b100) 
                begin

                        case(mem_instruction[11:10])
                        2'b00: //C.SRLI 
                                instruction <= {7'b0, mem_instruction[12], mem_instruction[6:2], 2'b0, mem_instruction[9:7], 3'b101, 2'b0, mem_instruction[9:7], 7'b0010011};
                        2'b01: //C.SRAI
                                instruction <= {7'b0100000, mem_instruction[12], mem_instruction[6:2], 2'b0, mem_instruction[9:7], 3'b101, 2'b0, mem_instruction[9:7], 7'b0010011};
                        2'b10: //C.ANDI
                                instruction <= {7'b0, mem_instruction[12],mem_instruction[6:2], 2'b0, mem_instruction[9:7], 3'b111, 2'b0, mem_instruction[9:7],7'b0010011};      
                        2'b11:
                        begin
                                case(mem_instruction[6:5])
                                2'b00: //C.SUB
                                        instruction <= {7'b0100000, mem_instruction[6:2], 2'b0, mem_instruction[9:7], 3'b000,2'b0, mem_instruction[9:7], 7'b0110011};
                                2'b01: //C.XOR
                                        instruction <= {7'b0, 2'b0, mem_instruction[4:2], 2'b0, mem_instruction[9:7], 3'b111,2'b0, mem_instruction[9:7], 7'b0110011};
                                2'b10: //C.OR
                                        instruction <= {7'b0, 2'b0, mem_instruction[4:2], 2'b0, mem_instruction[9:7], 3'b110, 2'b0, mem_instruction[9:7], 7'b0110011};
                                2'b11: //C.AND
                                        instruction <= {7'b0, 2'b0, mem_instruction[4:2], 2'b0, mem_instruction[9:7], 3'b111, 2'b0, mem_instruction[9:7], 7'b0110011}; 
                                endcase
                        end
                        endcase
                end
        end
        endcase
end
            
                    
endmodule