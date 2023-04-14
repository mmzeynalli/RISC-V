package common;

const logic     RESET                   = 1'b0;
const int       INSTRUCTION_WIDTH       = 32;
const int       PROGRAM_ADDRESS_WIDTH   = 6;

enum bit[3:0] { AND, OR, SADD, SSUB, UADD, USUB, SHIFT, MUL, DIV, REM } alu_operation_type;


typedef enum bit [1:0] { NONE, EX_MEM, MEM_WB } FORWARDING_TYPE;

typedef enum bit [6:0] { 
        // R-type
        OP =            7'b0110011,
        OP_FP =         7'b1010011,
        MADD =          7'b1000011,
        MSUB =          7'b1000111,
        NMSUB =         7'b1001011,
        NMADD =         7'b1001111,
        // I-type
        OP_IMM =        7'b0010011,
        JALR =          7'b1100111,
        LOAD =          7'b0000011,
        LOAD_FP =       7'b0000111, 
        // S-type
        STORE =         7'b0100011,
        STORE_FP =      7'b0100111
        // the rest
        BRANCH =        7'b1100011,
        LUI =           7'b0110111,
        JAL =           7'b1101111
        SYSTEM =        7'b1110011
} instruction_format_type;


typedef enum bit[2:0] { 
        R_TYPE,
        I_TYPE,
        S_TYPE,
        B_TYPE,
        U_TYPE,
        J_TYPE,
        SYS_TYPE
} instruction_op_type;


class instruction_type;
        bit [31:0] instruction;
        instruction_op_type optype;

        function new(bit [31:0] instruction);
                if (instruction[0] == 1)
                        instruction = this.convert16to32(instruction(15:0))

                this.instruction = instruction;
                this.optype = this.get_optype()
        endfunction

        function get_optype();
                case (this.opcode())
                        OP, OP_FP, MADD, MSUB, NMSUB, NMADD:
                                return R_TYPE;
                        OP_IMM, JALR, LOAD, LOAD_FP:
                                return I_TYPE;
                        STORE, STORE_FP:
                                return S_TYPE;
                        BRANCH:
                                return B_TYPE;
                        LUI:
                                return U_TYPE;
                        JAL:
                                return J_TYPE;
                        SYSTEM:
                                return SYS_TYPE;
                        default: 
                endcase
                
        endfunction

        function convert16to32(bit [15:0] instruction);
                return 32'h0;
                
        endfunction

        function opcode();
                return this.instruction(6:0);
        endfunction

        function rd();
                assert(this.optype != S_TYPE && this.optype != B_TYPE);
                return this.instruction(11:7);
        endfunction

        function funct3();
                assert(this.optype != S_TYPE && this.optype != B_TYPE);
                return this.instruction(14:12);
        endfunction

        function rs1();
                assert(this.optype != S_TYPE && this.optype != B_TYPE);
                return this.instruction(19:15);
        endfunction

        function rs2();
                assert(this.optype != S_TYPE && this.optype != B_TYPE && this.optype != I_TYPE);
                return this.instruction(24:20);
        endfunction

        function funct7();
                assert(this.optype == R_TYPE);
                return this.instruction(31:25);
        endfunction

        function imm();
                assert(this.optype != R_TYPE);
                
                case (this.optype)
                        I_TYPE: return this.instruction(31:20);
                        S_TYPE: return {this.instruction(31:25), this.instruction(11:7)};
                        B_TYPE: return {this.instruction(31), this.instruction(7), this.instruction(30:25), this.instruction(11:8), 1'b0};
                        U_TYPE: return this.instruction(31:12);
                        J_TYPE: return {this.instruction(31), this.instruction(19:12), this.instruction(30:21), 1'b0};
                        default: 
                                $error("Unknown format!"); 
                endcase

        endfunction

endclass //instruction_type

endpackage
