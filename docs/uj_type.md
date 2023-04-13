Here is the list of U-type and J-type commands and their decomposotion:


### Upper immediates


| Implemented                | Instruction | Description               | imm20 (31:12) | rd (11:7) | opcode (6:0) |
| -------------------------- | ----------- | ------------------------- | ------------- | --------- | ------------ |
| <ul> <li>- [ ] </li> </ul> | `lui`       | Load upper immediate      | `imm[20:0]`   | `rd[4:0]` | `0110111`    |
| <ul> <li>- [ ] </li> </ul> | `auipc`     | Add upper immediate to PC | `imm[20:0]`   | `rd[4:0]` | `0010111`    |


### Jump

| Implemented                | Instruction | Description   | imm20 (31:12)              | rd (11:7) | opcode (6:0) |
| -------------------------- | ----------- | ------------- | -------------------------- | --------- | ------------ |
| <ul> <li>- [ ] </li> </ul> | `jal`       | Jump And Link | `imm[20\|10:1\|11\|19:12]` | `rd[4:0]` | `1101111`    |
