#
# @author:Don Dennis
# machinecodeconst.py
#
# Constants and variable declaring various
# machine instructions


class MachineCodeConst:
    # Definition of opcodes used in assembly language instructions
    INSTR_LUI = 'lui'
    INSTR_AUIPC = 'auipc'
    INSTR_JAL = 'jal'
    INSTR_JALR = 'jalr'
    INSTR_BEQ = 'beq'
    INSTR_BNE = 'bne'
    INSTR_BLT = 'blt'
    INSTR_BGE = 'bge'
    INSTR_BLTU = 'bltu'
    INSTR_BGEU = 'bgeu'
    INSTR_LB = 'lb'
    INSTR_LH = 'lh'
    INSTR_LW = 'lw'
    INSTR_LBU = 'lbu'
    INSTR_LHU = 'lhu'
    INSTR_SB = 'sb'
    INSTR_SH = 'sh'
    INSTR_SW = 'sw'
    INSTR_ADDI = 'addi'
    INSTR_SLTI = 'slti'
    INSTR_SLTIU = 'sltiu'
    INSTR_XORI = 'xori'
    INSTR_ORI = 'ori'
    INSTR_ANDI = 'andi'
    INSTR_SLLI = 'slli'
    INSTR_SRLI = 'srli'
    INSTR_SRAI = 'srai'
    INSTR_ADD = 'add'
    INSTR_SUB = 'sub'
    INSTR_SLL = 'sll'
    INSTR_SLT = 'slt'
    INSTR_SLTU = 'sltu'
    INSTR_XOR = 'xor'
    INSTR_SRL = 'srl'
    INSTR_SRA = 'sra'
    INSTR_OR = 'or'
    INSTR_AND = 'and'
    INSTR_MUL = 'mul'

    # Compressed Instructions
    INSTR_C_LW = 'c.lw'
    INSTR_C_SW = 'c.sw'
    INSTR_C_ADD = 'c.add'
    INSTR_C_ADDI = 'c.addi'
    INSTR_C_SUB = 'c.sub'
    INSTR_C_AND = 'c.and'
    INSTR_C_ANDI = 'c.andi'
    INSTR_C_OR = 'c.or'
    INSTR_C_XOR = 'c.xor'
    INSTR_C_MV = 'c.mv'
    INSTR_C_LI = 'c.li'
    INSTR_C_LUI = 'c.lui'
    INSTR_C_SLLI = 'c.slli'
    INSTR_C_SRAI = 'c.srai'
    INSTR_C_SRLI = 'c.srli'

    # All reserved opcodes
    ALL_INSTR = [INSTR_LUI, INSTR_AUIPC, INSTR_JAL,
                 INSTR_JALR, INSTR_BEQ, INSTR_BNE, INSTR_BLT,
                 INSTR_BGE, INSTR_BLTU, INSTR_BGEU, INSTR_LB,
                 INSTR_LH, INSTR_LW, INSTR_LBU, INSTR_LHU,
                 INSTR_SB, INSTR_SH, INSTR_SW, INSTR_ADDI,
                 INSTR_SLTI, INSTR_SLTIU, INSTR_XORI,
                 INSTR_ORI, INSTR_ANDI, INSTR_SLLI,
                 INSTR_SRLI, INSTR_SRAI, INSTR_ADD,
                 INSTR_SUB, INSTR_SLL, INSTR_SLT,
                 INSTR_SLTU, INSTR_XOR, INSTR_SRL,
                 INSTR_SRA, INSTR_OR, INSTR_AND,
                 INSTR_MUL
                 ]
    
    # All compressed opcodes
    ALL_C_INSTR = [INSTR_C_LW, INSTR_C_SW, INSTR_C_ADD,
                   INSTR_C_ADDI, INSTR_C_SUB, INSTR_C_AND,
                   INSTR_C_ANDI, INSTR_C_OR, INSTR_C_XOR,
                   INSTR_C_MV, INSTR_C_LI, INSTR_C_LUI,
                   INSTR_C_SLLI, INSTR_C_SRAI, INSTR_C_SRLI]

    # All instruction in a type
    INSTR_TYPE_U = [INSTR_LUI, INSTR_AUIPC]
    INSTR_TYPE_UJ = [INSTR_JAL]
    INSTR_TYPE_S = [INSTR_SW, INSTR_SB, INSTR_SH]
    INSTR_TYPE_SB = [INSTR_BEQ, INSTR_BNE, INSTR_BLT,
                     INSTR_BLTU, INSTR_BGE, INSTR_BGEU]
    INSTR_TYPE_I = [INSTR_ADDI, INSTR_SLTI, INSTR_SLTIU,
                    INSTR_ORI, INSTR_XORI, INSTR_ANDI,
                    INSTR_SLLI, INSTR_SRLI, INSTR_SRAI,
                    INSTR_JALR, INSTR_LW, INSTR_LB,
                    INSTR_LH, INSTR_LBU, INSTR_LHU]
    INSTR_TYPE_R = [INSTR_ADD, INSTR_SUB, INSTR_SLL,
                    INSTR_SLT, INSTR_SLTU, INSTR_XOR,
                    INSTR_SRL, INSTR_SRA, INSTR_OR, INSTR_AND,
                    INSTR_MUL]

    # Binary Opcodes
    BOP_LUI = '0110111'
    BOP_AUIPC = '0010111'
    BOP_JAL = '1101111'
    BOP_JALR = '1100111'
    BOP_BRANCH = '1100011'
    BOP_LOAD = '0000011'
    BOP_STORE = '0100011'
    BOP_ARITHI = '0010011'
    BOP_ARITH = '0110011'
    # Not supported
    # [FENCE, FENCE.I]
    BOP_MISCMEM = '0001111'
    # [ ECALL, EBREAK, CSRRW, CSRRS, cSRRC, CSRRWI, CSRRSI, CSRRCI]
    BOP_SYSTEM = '1110011'

    # The instruction in each distinct binary opcode
    INSTR_BOP_LUI = [INSTR_LUI]
    INSTR_BOP_AUIPC = [INSTR_AUIPC]
    INSTR_BOP_JAL = [INSTR_JAL]
    INSTR_BOP_JALR = [INSTR_JALR]
    INSTR_BOP_BRANCH = [INSTR_BEQ, INSTR_BNE, INSTR_BLT,
                        INSTR_BLTU, INSTR_BGE, INSTR_BGEU]
    INSTR_BOP_LOAD = [INSTR_LW, INSTR_LB,
                      INSTR_LH, INSTR_LBU, INSTR_LHU]
    INSTR_BOP_STORE = [INSTR_SW, INSTR_SB, INSTR_SH]
    INSTR_BOP_ARITHI = [INSTR_ADDI, INSTR_SLTI, INSTR_SLTIU,
                        INSTR_ORI, INSTR_XORI, INSTR_ANDI,
                        INSTR_SLLI, INSTR_SRLI, INSTR_SRAI]
    INSTR_BOP_ARITH = [INSTR_ADD, INSTR_SUB, INSTR_SLL,
                       INSTR_SLT, INSTR_SLTU, INSTR_XOR,
                       INSTR_SRL, INSTR_SRA, INSTR_OR, INSTR_AND,
                       INSTR_MUL]

    # FUNCT for each instruction type
    FUNCT3_ARITHI = {
        INSTR_ADDI: '000',
        INSTR_SLTI: '010',
        INSTR_SLTIU: '011',
        INSTR_ORI: '110',
        INSTR_XORI: '100',
        INSTR_ANDI: '111',
        INSTR_SLLI: '001',
        INSTR_SRLI: '101',
        INSTR_SRAI: '101'
    }

    FUNCT3_JALR = {
        INSTR_JALR: '000'
    }

    FUNCT3_LOAD = {
        INSTR_LB: '000',
        INSTR_LH: '001',
        INSTR_LW: '010',
        INSTR_LBU: '100',
        INSTR_LHU: '101'
    }

    FUNCT3_ARITH = {
        INSTR_ADD: '000',
        INSTR_SUB: '000',
        INSTR_SLL: '001',
        INSTR_SLT: '010',
        INSTR_SLTU: '011',
        INSTR_XOR: '100',
        INSTR_SRL: '101',
        INSTR_SRA: '101',
        INSTR_OR: '110',
        INSTR_AND: '111',
        INSTR_MUL: '000'
    }

    FUNCT7_ARITH = {
        INSTR_ADD: '0000000',
        INSTR_SUB: '0100000',
        INSTR_SLL: '0000000',
        INSTR_SLT: '0000000',
        INSTR_SLTU: '0000000',
        INSTR_XOR: '0000000',
        INSTR_SRL: '0000000',
        INSTR_SRA: '0100000',
        INSTR_OR: '0000000',
        INSTR_AND: '0000000',
        INSTR_MUL: '0000001'
    }

    FUNCT3_STORE = {
        INSTR_SB: '000',
        INSTR_SH: '001',
        INSTR_SW: '010'
    }

    FUNCT3_BRANCH = {
        INSTR_BEQ: '000',
        INSTR_BNE: '001',
        INSTR_BLT: '100',
        INSTR_BGE: '101',
        INSTR_BLTU: '110',
        INSTR_BGEU: '111'
    }

    # Binary Opcodes for compressed instructions
    BOP_C_LOAD = '00'
    BOP_C_STORE = '01'
    BOP_C_MISC_ARITH = '10'
    BOP_C_JUMP = '11'

    # The compressed instruction in each distinct binary opcode
    INSTR_BOP_C_LOAD = [INSTR_C_LW]
    INSTR_BOP_C_STORE = [INSTR_C_SW]
    INSTR_BOP_C_MISC_ARITH = [INSTR_C_ADD, INSTR_C_ADDI, INSTR_C_SUB,
                              INSTR_C_AND, INSTR_C_ANDI, INSTR_C_OR,
                              INSTR_C_XOR, INSTR_C_MV, INSTR_C_LI,
                              INSTR_C_LUI, INSTR_C_SLLI, INSTR_C_SRAI, INSTR_C_SRLI]
    INSTR_BOP_C_JUMP = []

    # Formats for compressed instructions
    FORMAT_CR = 'cr'
    FORMAT_CI = 'ci'
    FORMAT_CS = 'cs'
    FORMAT_CL = 'cl'

    # Instruction formats for each compressed instruction
    INSTR_FORMAT = {
        INSTR_C_LW: FORMAT_CL,
        INSTR_C_SW: FORMAT_CS,
        INSTR_C_ADD: FORMAT_CR,
        INSTR_C_ADDI: FORMAT_CI,
        INSTR_C_SUB: FORMAT_CR,
        INSTR_C_AND: FORMAT_CR,
        INSTR_C_ANDI: FORMAT_CI,
        INSTR_C_OR: FORMAT_CR,
        INSTR_C_XOR: FORMAT_CR,
        INSTR_C_MV: FORMAT_CR,
        INSTR_C_LI: FORMAT_CI,
        INSTR_C_LUI: FORMAT_CI,
        INSTR_C_SLLI: FORMAT_CI,
        INSTR_C_SRAI: FORMAT_CI,
        INSTR_C_SRLI: FORMAT_CI
    }
    # FUNCT4 values for compressed instructions in CR format
    FUNCT4_CR = {
        INSTR_C_ADD: '0000',
        INSTR_C_SUB: '0000',
        INSTR_C_AND: '0000',
        INSTR_C_OR: '0000',
        INSTR_C_XOR: '0000',
        INSTR_C_MV: '0000'
    }

    # FUNCT3 values for compressed instructions in CI format
    FUNCT3_CI = {
        INSTR_C_ADDI: '000',
        INSTR_C_ANDI: '111',
        INSTR_C_LI: '010',
        INSTR_C_LUI: '011',
        INSTR_C_SLLI: '001',
        INSTR_C_SRAI: '101',
        INSTR_C_SRLI: '101'
    }

    


