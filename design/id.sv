import common::*;

module instruction_decode (
        input [INSTRUCTION_WIDTH-1:0] mem_instruction,
        input [DATA_WIDTH-1:0] read1_data,
        output instruction_format_type opcode,
        output instruction_op_type optype,
        output logic [4:0] rd,
        output logic [4:0] rs1,
        output logic [4:0] rs2,
        output logic [2:0] funct3,
        output logic [6:0] funct7,
        output logic [IMM_WIDTH-1:0] imm,
        output logic [31:0] pc_JALR
);


logic [INSTRUCTION_WIDTH-1:0] instruction;
logic is_compressed;

compressed compressed(
        .mem_instruction(mem_instruction),
        .is_compressed(is_compressed),
        .instruction(instruction)  // extended or the same
);

always_comb begin : decompose
        rd <= instruction[11:7];  // optype != S_TYPE && optype != B_TYPE
        funct3 <= instruction[14:12]; // optype != U_TYPE
        rs1 <= instruction[19:15]; // optype != U_TYPE
        rs2 <= instruction[24:20]; // optype != I_TYPE && optype != U_TYPE && optype != J_TYPE
        funct7 <= instruction[31:25]; // optype == R_TYPE
end

always_comb begin : get_optype
        opcode = instruction_format_type'(instruction[6:0]);

        case (opcode)
                OP, OP_FP, MADD, MSUB, NMSUB, NMADD:
                        optype = R_TYPE;
                OP_IMM, JALR, LOAD, LOAD_FP:
                        optype = I_TYPE;
                STORE, STORE_FP:
                        optype = S_TYPE;
                BRANCH:
                        optype = B_TYPE;
                U_LUI, U_AUIPC:
                        optype = U_TYPE;
                J_JAL:
                        optype = J_TYPE;
                SYSTEM:
                        optype = SYS_TYPE;
                default:
                        optype = R_TYPE;
        endcase
        
        imm = generate_imm();
end

function [IMM_WIDTH-1:0] generate_imm();
        
        case (optype)
                R_TYPE: return 21'b0;
                I_TYPE: return 21'(signed'(instruction[31:20]));
                S_TYPE: return 21'(signed'({instruction[31:25], instruction[11:7]}));
                B_TYPE: return 21'(signed'({instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}));
                U_TYPE: return 21'(signed'({instruction[31:12]}));
                J_TYPE: return 21'(signed'({instruction[31], instruction[19:12], instruction[20],instruction[30:21]}));
                default: 
                        return 21'b0;
        endcase

endfunction

always_comb begin
        if(opcode == JALR)
                pc_JALR = ((32'(signed'(imm))) + read1_data) & ~1;

        
end

endmodule
