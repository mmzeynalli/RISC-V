Here is the list of S-type and B-type commands and their decomposotion:


### STORE

| instruction | description      | imm13 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | imm13 (11:7) | opcode (6:0) |
| ----------- | ---------------- | ------------- | ----------- | ----------- | -------------- | ------------ | ------------ |
| `sb`        | Store Byte       | `imm[11:5]`   | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `imm[4:0]`   | `0100011`    |
| `sh`        | Store Halfword   | `imm[11:5]`   | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `imm[4:0]`   | `0100011`    |
| `sw`        | Store Word       | `imm[11:5]`   | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `imm[4:0]`   | `0100011`    |
| `fsw`       | Store Float Word | `imm[11:5]`   | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `imm[4:0]`   | `0100111`    |

### Branches

| instruction | description                               | imm12 (31:25)   | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | imm12 (11:7)   | opcode (6:0) |
| ----------- | ----------------------------------------- | --------------- | ----------- | ----------- | -------------- | -------------- | ------------ |
| `beq`       | Branch if equal                           | `imm[12\|10:5]` | `rs2`       | `rs1`       | `000`          | `imm[4:1\|11]` | `1100011`    |
| `bne`       | Branch if not equal                       | `imm[12\|10:5]` | `rs2`       | `rs1`       | `001`          | `imm[4:1\|11]` | `1100011`    |
| `blt`       | Branch if less than                       | `imm[12\|10:5]` | `rs2`       | `rs1`       | `100`          | `imm[4:1\|11]` | `1100011`    |
| `bge`       | Branch if greater than or equal           | `imm[12\|10:5]` | `rs2`       | `rs1`       | `101`          | `imm[4:1\|11]` | `1100011`    |
| `bltu`      | Branch if less than, unsigned             | `imm[12\|10:5]` | `rs2`       | `rs1`       | `110`          | `imm[4:1\|11]` | `1100011`    |
| `bgeu`      | Branch if greater than or equal, unsigned | `imm[12\|10:5]` | `rs2`       | `rs1`       | `111`          | `imm[4:1\|11]` | `1100011`    |
