Here is the list of U-type and J-type commands and their decomposotion:


### Upper immediates


|           | Instruction | Description               | imm20 (31:12) | rd (11:7) | opcode (6:0) |
| --------- | ----------- | ------------------------- | ------------- | --------- | ------------ |
| <li>- [ ] | `lui`       | Load upper immediate      | `imm[20:0]`   | `rd[4:0]` | `0110111`    |
| <li>- [ ] | `auipc`     | Add upper immediate to PC | `imm[20:0]`   | `rd[4:0]` | `0010111`    |


### Jump

|           | Instruction | Description   | imm20 (31:12)              | rd (11:7) | opcode (6:0) |
| --------- | ----------- | ------------- | -------------------------- | --------- | ------------ |
| <li>- [ ] | `jal`       | Jump And Link | `imm[20\|10:1\|11\|19:12]` | `rd[4:0]` | `1101111`    |
