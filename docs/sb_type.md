# SB-TYPE


Switch to:

[R-Type](/docs/r_type.md)

[I-Type](/docs/i_type.md)

[UJ-Type](/docs/uj_type.md)


---

Here is the list of S-type and B-type commands and their decomposotion:

### STORE

| Implemented                | instruction | description      | imm12 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | imm12 (11:7) | opcode (6:0) |
| -------------------------- | ----------- | ---------------- | ------------- | ----------- | ----------- | -------------- | ------------ | ------------ |
| <ul> <li>- [ ] </li> </ul> | `sb`        | Store Byte       | `imm[11:5]`   | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `imm[4:0]`   | `0100011`    |
| <ul> <li>- [ ] </li> </ul> | `sh`        | Store Halfword   | `imm[11:5]`   | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `imm[4:0]`   | `0100011`    |
| <ul> <li>- [ ] </li> </ul> | `sw`        | Store Word       | `imm[11:5]`   | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `imm[4:0]`   | `0100011`    |
| <ul> <li>- [ ] </li> </ul> | `fsw`       | Store Float Word | `imm[11:5]`   | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `imm[4:0]`   | `0100111`    |

### Branches

| Implemented                | instruction | description                               | imm13 (31:25)   | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | imm13 (11:7)   | opcode (6:0) |
| -------------------------- | ----------- | ----------------------------------------- | --------------- | ----------- | ----------- | -------------- | -------------- | ------------ |
| <ul> <li>- [ ] </li> </ul> | `beq`       | Branch if equal                           | `imm[12\|10:5]` | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `imm[4:1\|11]` | `1100011`    |
| <ul> <li>- [ ] </li> </ul> | `bne`       | Branch if not equal                       | `imm[12\|10:5]` | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `imm[4:1\|11]` | `1100011`    |
| <ul> <li>- [ ] </li> </ul> | `blt`       | Branch if less than                       | `imm[12\|10:5]` | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `imm[4:1\|11]` | `1100011`    |
| <ul> <li>- [ ] </li> </ul> | `bge`       | Branch if greater than or equal           | `imm[12\|10:5]` | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `imm[4:1\|11]` | `1100011`    |
| <ul> <li>- [ ] </li> </ul> | `bltu`      | Branch if less than, unsigned             | `imm[12\|10:5]` | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `imm[4:1\|11]` | `1100011`    |
| <ul> <li>- [ ] </li> </ul> | `bgeu`      | Branch if greater than or equal, unsigned | `imm[12\|10:5]` | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `imm[4:1\|11]` | `1100011`    |
