import common::*;

module instruction_decode (
        input clk,
        input [31:0] instruction
        // output ?
);


instruction_op_type optype;
reg [6:0] opcode;
reg [4:0] rd, rs1, rs2;
reg [2:0] func3;
reg [6:0] funct7;
reg [20:0] imm;

always_comb begin : decompose
        opcode = instruction[6:0];
        rd = instruction[11:7];  // optype != S_TYPE && optype != B_TYPE
        func3 = instruction[14:12]; // optype != U_TYPE
        rs1 = instruction[19:15]; // optype != U_TYPE
        rs2 = instruction[24:20]; // optype != I_TYPE && optype != U_TYPE && optype != J_TYPE
        funct7 = instruction[31:25]; // optype == R_TYPE
        imm = generate_imm();
end

always_comb begin : get_optype
        case (opcode)
                OP, OP_FP, MADD, MSUB, NMSUB, NMADD:
                        optype = R_TYPE;
                OP_IMM, JALR, LOAD, LOAD_FP:
                        optype = I_TYPE;
                STORE, STORE_FP:
                        optype = S_TYPE;
                BRANCH:
                        optype = B_TYPE;
                U_LUI:
                        optype = U_TYPE;
                J_JAL:
                        optype = J_TYPE;
                SYSTEM:
                        optype = SYS_TYPE;
                default:
                        $error("Unknown opcode!");
        endcase

end

function generate_imm();
        
        case (optype)
                R_TYPE: return 0;
                I_TYPE: return instruction[31:20];
                S_TYPE: return {instruction[31:25], instruction[11:7]};
                B_TYPE: return {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
                U_TYPE: return instruction[31:12];
                J_TYPE: return {instruction[31], instruction[19:12], instruction[30:21], 1'b0};
                default: 
                        $error("Unknown format!");
        endcase

endfunction


endmodule
