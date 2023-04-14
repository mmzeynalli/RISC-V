# R-TYPE
(The rest:

[I-Type](docs/i_type.md)

[SB-Type](docs/sb_type.md)

[UJ-Type](docs/uj_type.md)
)

Here is the list of R-type commands and their decomposotion:

### Integer register-register operations (RV32I):

| Implemented                | instruction | description            | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| -------------------------- | ----------- | ---------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <ul> <li>- [ ] </li> </ul> | `sll`       | Shift Left Logical     | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `srl`       | Shift Right Logical    | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `sra`       | Shift Right Arithmetic | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `add`       | Addition               | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `sub`       | Subtraction            | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `xor`       | Bitwise XOR            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `or`        | Bitwise OR             | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `and`       | Bitwise AND            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `slt`       | Set Less Than          | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `sltu`      | Set Less Than Unsigned | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |

### Integer multiplication and division (RV32M):
| Implemented                | instruction | description                                          | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| -------------------------- | ----------- | ---------------------------------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <ul> <li>- [ ] </li> </ul> | `mul`       | Multiplication                                       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `mulh`      | Multiplication High (signed × signed → signed)       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `mulhsu`    | Multiplication High (signed × unsigned → signed)     | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `mulhu`     | Multiplication High (unsigned × unsigned → unsigned) | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `div`       | Division (signed / signed → signed)                  | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `divu`      | Division (unsigned / unsigned → unsigned)            | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `rem`       | Remainder (signed % signed → signed)                 | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| <ul> <li>- [ ] </li> </ul> | `remu`      | Remainder (unsigned % unsigned → unsigned)           | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |


### Single-precision floating-point register-register operations (RV32F): (SPFP -> Single-Precision Floating-Point)
| Implemented                | instruction | description                   | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| -------------------------- | ----------- | ----------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <ul> <li>- [ ] </li> </ul> | `fmw.w.x`   | Move From Integer             | `0101100`      | `00000`     | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fmw.x.w`   | Move To Integer               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fcvt.s.w`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fcvt.s.wu` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fcvt.w.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fcvt.wu.s` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fadd.s`    | SPFP Addition                 | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fsub.s`    | SPFP Subtraction              | `0000100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fmul.s`    | SPFP Multiplication           | `0001000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fdiv.s`    | SPFP Division                 | `0001100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fsqrt.s`   | SPFP Square Root              | `0101100`      | `00000`     | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fmadd.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fmsub.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fnmsub.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fnmadd.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fsgnj.s`   | SPFP Sign Injection           | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fsgnjn.s`  | SPFP Sign Injection (Negated) | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fsgnjx.s`  | SPFP Sign Injection (XOR)     | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fmin.s`    | SPFP Minimum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `fmax.s`    | SPFP Maximum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| <ul> <li>- [ ] </li> </ul> | `feq.s`     | Compare Float =               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `flt.s`     | Compare Float <               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fle.s`     | Compare Float <=              | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fclass.s`  |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `frcsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `frrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `frflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fscsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fsrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <ul> <li>- [ ] </li> </ul> | `fsflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |


### Double-precision floating-point register-register operations (RV32D):
| instruction | description | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ----------- | ----------- | -------------- | ----------- | ----------- | -------------- | --------- |
