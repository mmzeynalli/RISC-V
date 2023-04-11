import common::*;

module risc_v #(
        parameter PROGRAM_ADDRESS_WIDTH = 6;
        parameter DATA_ADDRESS_WIDTH = 6;
        parameter CPU_DATA_WIDTH: natural = 32;
        parameter REGISTER_FILE_ADDRESS_WIDTH = 5;
) (
        input clk;
        input rst;
        
        
        input [INSTRUCTION_WIDTH-1:0] program_data;
        output [PROGRAM_ADDRESS_WIDTH-1:0] pc;

        output [DATA_ADDRESS_WIDTH-1:0] data_address;
        input [CPU_DATA_WIDTH-1:0] data_read;
        output data_write_en;
        output [CPU_DATA_WIDTH-1:0] data_write;

);


typedef enum bit [1:0] { NONE, EX_MEM, MEM_WB } FORWARDING_TYPE;

typedef enum bit [6:0] { 
        R_FORMAT = 7'b0111011,  // ??????
        I_FORMAT = 7'b0010011,
        S_FORMAT = 7'b0100011,
        B_FORMAT = 7'b1100011,
        U_FORMAT = 7'b0110111,
        J_FORMAT = 7'b1101111
} instruction_format_type;

class instruction_type;
        bit [31:0] instruction;
        instruction_format_type optype;

        function new(bit [31:0] instruction, bit is16bit = 0);
                if is16bit == 1
                        instruction = this.convert16to32(instruction(15:0))
                
                this.instruction = instruction;
                this.optype = this.opcode()
        endfunction

        function convert16to32(bit [15:0] instruction);
                return 32'h0;
                
        endfunction

        function opcode();
                return this.instruction(6:0);
        endfunction

        function rd();
                assert(this.optype != S_FORMAT && this.optype != B_FORMAT);
                return this.instruction(11:7);
        endfunction

        function funct3();
                assert(this.optype != S_FORMAT && this.optype != B_FORMAT);
                return this.instruction(14:12);
        endfunction

        function rs1();
                assert(this.optype != S_FORMAT && this.optype != B_FORMAT);
                return this.instruction(19:15);
        endfunction

        function rs2();
                assert(this.optype != S_FORMAT && this.optype != B_FORMAT && this.optype != I_FORMAT);
                return this.instruction(24:20);
        endfunction

        function funct7();
                assert(this.optype == R_FORMAT);
                return this.instruction(31:25);
        endfunction

        function imm();
                assert(this.optype != R_FORMAT);
                
                case (this.optype)
                        I_FORMAT: return this.instruction(31:20);
                        S_FORMAT: return {this.instruction(31:25), this.instruction(11:7)};
                        B_FORMAT: return {this.instruction(31), this.instruction(7), this.instruction(30:25), this.instruction(11:8), 1'b0};
                        U_FORMAT: return this.instruction(31:12);
                        J_FORMAT: return {this.instruction(31), this.instruction(19:12), this.instruction(30:21), 1'b0};
                        default: 
                                $error("Unknown format!"); 
                endcase

        endfunction

endclass //instruction_type


        
endmodule
