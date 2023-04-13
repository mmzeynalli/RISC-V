Here is the list of I-type commands and their decomposotion:

### Integer register-integer operations (RV32I):

| Implemented                        | instruction | description | imm12 (31:20)  | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ---------------------------------- | ----------- | ----------- | -------------- | ----------- | -------------- | --------- | ------------ |
| <input type="checkbox" disabled /> | `slli`      |             | `imm[11:5]`    | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `srli`      |             | `imm[11:5]`    | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `srai`      |             | `imm[11:5]`    | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `addi`      |             | `imm[11:0]`    | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `xori`      |             | `imm[11:0]`    | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `ori`       |             | `imm[11:0]`    | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `andi`      |             | `imm[11:0]`    | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `slti`      |             | `imm[11:0]`    | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `sltiu`     |             | `imm[11:0]`    | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0010011`    |
| <input type="checkbox" disabled /> | `jalr`      |             | `imm[11:0]`    | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1100111`    |
|                                    |             |             |                |             |                |           |              |
| <input type="checkbox" disabled /> | `fence.i`   |             | `000000000000` | `00000`     | `001`          | `00000`   | `0001111`    |
| <input type="checkbox" disabled /> | `ecall`     |             | `000000000000` | `00000`     | `000`          | `00000`   | `1110011`    |
| <input type="checkbox" disabled /> | `ebreak`    |             | `000000000001` | `00000`     | `000`          | `00000`   | `1110011`    |

### Load Integer Operations
| Implemented                        | instruction | description | imm12 (31:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ---------------------------------- | ----------- | ----------- | ------------- | ----------- | -------------- | --------- | ------------ |
| <input type="checkbox" disabled /> | `lb`        |             | `imm[11:0]`   | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0000011`    |
| <input type="checkbox" disabled /> | `lh`        |             | `imm[11:0]`   | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0000011`    |
| <input type="checkbox" disabled /> | `lbu`       |             | `imm[11:0]`   | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0000011`    |
| <input type="checkbox" disabled /> | `lhu`       |             | `imm[11:0]`   | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0000011`    |
| <input type="checkbox" disabled /> | `lw`        |             | `imm[11:0]`   | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0000011`    |




### Single-precision floating-point register-integer operations (RV32F)
| Implemented                        | instruction | description     | imm12 (31:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ---------------------------------- | ----------- | --------------- | ------------- | ----------- | -------------- | --------- | ------------ |
| <input type="checkbox" disabled /> | `flw`       | Load float word | `imm[11:0]`   | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0000111`    |
