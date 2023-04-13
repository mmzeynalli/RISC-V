Here is the list of R-type commands and their decomposotion:

### Integer register-register operations (RV32I):

|                 | instruction | description            | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| --------------- | ----------- | ---------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <li>- [ ] </li> | `sll`       | Shift Left Logical     | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `srl`       | Shift Right Logical    | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `sra`       | Shift Right Arithmetic | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `add`       | Addition               | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `sub`       | Subtraction            | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `xor`       | Bitwise XOR            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `or`        | Bitwise OR             | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `and`       | Bitwise AND            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `slt`       | Set Less Than          | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `sltu`      | Set Less Than Unsigned | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |

### Integer multiplication and division (RV32M):
|                 | instruction | description                                          | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| --------------- | ----------- | ---------------------------------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <li>- [ ] </li> | `mul`       | Multiplication                                       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `mulh`      | Multiplication High (signed × signed → signed)       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `mulhsu`    | Multiplication High (signed × unsigned → signed)     | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `mulhu`     | Multiplication High (unsigned × unsigned → unsigned) | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `div`       | Division (signed / signed → signed)                  | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `divu`      | Division (unsigned / unsigned → unsigned)            | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `rem`       | Remainder (signed % signed → signed)                 | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] </li> | `remu`      | Remainder (unsigned % unsigned → unsigned)           | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |


### Single-precision floating-point register-register operations (RV32F): (SPFP -> Single-Precision Floating-Point)
|                 | instruction | description                   | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| --------------- | ----------- | ----------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <li>- [ ] </li> | `fmw.w.x`   | Move From Integer             | `0101100`      | `00000`     | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fmw.x.w`   | Move To Integer               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fcvt.s.w`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fcvt.s.wu` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fcvt.w.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fcvt.wu.s` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fadd.s`    | SPFP Addition                 | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fsub.s`    | SPFP Subtraction              | `0000100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fmul.s`    | SPFP Multiplication           | `0001000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fdiv.s`    | SPFP Division                 | `0001100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fsqrt.s`   | SPFP Square Root              | `0101100`      | `00000`     | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fmadd.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fmsub.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fnmsub.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fnmadd.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fsgnj.s`   | SPFP Sign Injection           | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fsgnjn.s`  | SPFP Sign Injection (Negated) | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fsgnjx.s`  | SPFP Sign Injection (XOR)     | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fmin.s`    | SPFP Minimum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `fmax.s`    | SPFP Maximum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] </li> | `feq.s`     | Compare Float =               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `flt.s`     | Compare Float <               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fle.s`     | Compare Float <=              | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fclass.s`  |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `frcsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `frrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `frflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fscsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fsrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] </li> | `fsflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |


### Double-precision floating-point register-register operations (RV32D):
| instruction | description | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ----------- | ----------- | -------------- | ----------- | ----------- | -------------- | --------- |
