package common;

const logic       RESET                   = 1'b0;
localparam int    INSTRUCTION_WIDTH       = 32;
localparam int    OPERAND_WIDTH           = 32;
localparam int    DATA_WIDTH              = 32;
localparam int    PROGRAM_ADDRESS_WIDTH   = 6;

typedef enum bit[3:0] 
{ SLL, SRL, SRA, ADD, SUB, LUI, XOR, OR, AND, SLT, SLTU, LW, SW} alu_operation_type;


typedef enum bit [1:0] { NONE, EX_MEM, MEM_WB } forwarding_type;

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
        U_AUIPC =       7'b0010111,
        U_LUI =         7'b0110111,
        J_JAL =         7'b1101111,
        SYSTEM =        7'b1110011
} instruction_format_type;

typedef enum bit [2:0] {  
        BEQ     = 3'b000,
        BNE     = 3'b001,
        BLT     = 3'b100,
        BGE     = 3'b101,
        BLTU    = 3'b110,
        BGEU    = 3'b111
} branch_type;

typedef enum bit[2:0] { 
        R_TYPE,
        I_TYPE,
        S_TYPE,
        B_TYPE,
        U_TYPE,
        J_TYPE,
        SYS_TYPE,
} instruction_op_type;


endpackage
