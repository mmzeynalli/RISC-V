Here is the list of R-type commands and their decomposotion:

### Integer register-register operations (RV32I):

|           | instruction | description            | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| --------- | ----------- | ---------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <li>- [ ] | `sll`       | Shift Left Logical     | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `srl`       | Shift Right Logical    | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `sra`       | Shift Right Arithmetic | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `add`       | Addition               | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `sub`       | Subtraction            | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `xor`       | Bitwise XOR            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `or`        | Bitwise OR             | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `and`       | Bitwise AND            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `slt`       | Set Less Than          | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `sltu`      | Set Less Than Unsigned | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |

### Integer multiplication and division (RV32M):
|           | instruction | description                                          | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| --------- | ----------- | ---------------------------------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <li>- [ ] | `mul`       | Multiplication                                       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `mulh`      | Multiplication High (signed × signed → signed)       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `mulhsu`    | Multiplication High (signed × unsigned → signed)     | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `mulhu`     | Multiplication High (unsigned × unsigned → unsigned) | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `div`       | Division (signed / signed → signed)                  | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `divu`      | Division (unsigned / unsigned → unsigned)            | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `rem`       | Remainder (signed % signed → signed)                 | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| <li>- [ ] | `remu`      | Remainder (unsigned % unsigned → unsigned)           | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |


### Single-precision floating-point register-register operations (RV32F): (SPFP -> Single-Precision Floating-Point)
|           | instruction | description                   | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| --------- | ----------- | ----------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <li>- [ ] | `fmw.w.x`   | Move From Integer             | `0101100`      | `00000`     | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fmw.x.w`   | Move To Integer               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fcvt.s.w`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fcvt.s.wu` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fcvt.w.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fcvt.wu.s` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fadd.s`    | SPFP Addition                 | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fsub.s`    | SPFP Subtraction              | `0000100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fmul.s`    | SPFP Multiplication           | `0001000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fdiv.s`    | SPFP Division                 | `0001100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fsqrt.s`   | SPFP Square Root              | `0101100`      | `00000`     | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fmadd.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fmsub.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fnmsub.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fnmadd.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fsgnj.s`   | SPFP Sign Injection           | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fsgnjn.s`  | SPFP Sign Injection (Negated) | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fsgnjx.s`  | SPFP Sign Injection (XOR)     | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fmin.s`    | SPFP Minimum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `fmax.s`    | SPFP Maximum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| <li>- [ ] | `feq.s`     | Compare Float =               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `flt.s`     | Compare Float <               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fle.s`     | Compare Float <=              | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fclass.s`  |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `frcsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `frrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `frflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fscsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fsrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <li>- [ ] | `fsflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |


### Double-precision floating-point register-register operations (RV32D):
| instruction | description | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ----------- | ----------- | -------------- | ----------- | ----------- | -------------- | --------- |
