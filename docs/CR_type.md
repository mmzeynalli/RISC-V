# CR-TYPE


Switch to:

[R-Type](/docs/r_type.md)

[I-Type](/docs/i_type.md)

[UJ-Type](/docs/uj_type.md)

[SB-Type](/docs/sb_type.md)

---

Here is the list of CR-type commands and their decomposotion:

### compressed instuction opcode 00
| instruction | funct(15:13) | imm(12:10) | rs1(9:7) | imm(6,5)  | rd/rs2(4:2) | opcode(1,0) |
| ----------- | ------------ | ---------- | -------- | --------- | ----------- | ----------- |
| C.LW        | 010          | uimm[5:3]  | rs1      | uimm[2,6] | rd          | 00          |
| C.SW        | 110          | uimm[5:3]  | rs1      | uimm[2,6] | rs2         | 00          |


### compressed instuction opcode 01
| instruction | funct(15:13) | imm(12)   | rs1/rd(11:7) | imm/rs2(6:2) | opcode(1,0) |
| ----------- | ------------ | --------- | ------------ | ------------ | ----------- |
| C.ADDI      | 000          | nzimm[5]  | /= 0         | nzimm[4:0]   | 01          |
| C.LUI       | 000          | nzimm[17] | rd /= {0,2}  | nzimm[16:12] | 01          |
| C.LI        | 010          | imm[5]    | /= 0         | imm[4:0]     | 01          |
| C.SRLI      | 100          | nzimm[5]  | 00    rs1/rd | nzimm[4:0]   | 01          |
| C.SRAI      | 100          | nzimm[5]  | 01    rs1/rd | nzimm[4:0]   | 01          |
| C.ANDI      | 100          | imm[5]    | 10    rs1/rd | imm[5:0]     | 01          |
| C.SUB       | 100          | 0         | 11    rs1/rd | 00,rs2       | 01          |
| C.XOR       | 100          | 0         | 11    rs1/rd | 01,rs2       | 01          |
| C.OR        | 100          | 0         | 11    rs1/rd | 10,rs2       | 01          |
| C.AND       | 100          | 0         | 11    rs1/rd | 11,rs2       | 01          |


### compressed instuction opcode 10
| instruction | funct(15:13) | imm(12)   | rs1/rd(11:7) | imm/rs2(6:2) | opcode(1,0) |
| ----------- | ------------ | --------- | ------------ | ------------ | ----------- |
| C.SLLI      | 000          | nzuimm[5] | /= 0         | nzuimm[5:0]  | 10          |
| C.ADD       | 100          | 1         | /= 0         | /= 0         | 10          |

