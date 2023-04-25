package common;

const logic     RESET                   = 1'b0;
localparam int       INSTRUCTION_WIDTH       = 32;
localparam int       PROGRAM_ADDRESS_WIDTH   = 6;

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
        STORE_FP =      7'b0100111,
        // the rest
        BRANCH =        7'b1100011,
        LUI =           7'b0110111,
        JAL =           7'b1101111,
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


endpackage
