Here is the list of R-type commands and their decomposotion:

### Integer register-register operations (RV32I):

| Implemented                        | instruction | description            | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ---------------------------------- | ----------- | ---------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <input type="checkbox" disabled /> | `sll`       | Shift Left Logical     | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `srl`       | Shift Right Logical    | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `sra`       | Shift Right Arithmetic | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `add`       | Addition               | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `sub`       | Subtraction            | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `xor`       | Bitwise XOR            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `or`        | Bitwise OR             | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `and`       | Bitwise AND            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `slt`       | Set Less Than          | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `sltu`      | Set Less Than Unsigned | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |

### Integer multiplication and division (RV32M):
| Implemented                        | instruction | description                                          | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ---------------------------------- | ----------- | ---------------------------------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <input type="checkbox" disabled /> | `mul`       | Multiplication                                       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `mulh`      | Multiplication High (signed × signed → signed)       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `mulhsu`    | Multiplication High (signed × unsigned → signed)     | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `mulhu`     | Multiplication High (unsigned × unsigned → unsigned) | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `div`       | Division (signed / signed → signed)                  | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `divu`      | Division (unsigned / unsigned → unsigned)            | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `rem`       | Remainder (signed % signed → signed)                 | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| <input type="checkbox" disabled /> | `remu`      | Remainder (unsigned % unsigned → unsigned)           | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |


### Single-precision floating-point register-register operations (RV32F): (SPFP -> Single-Precision Floating-Point)
| Implemented                        | instruction | description                   | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ---------------------------------- | ----------- | ----------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| <input type="checkbox" disabled /> | `fmw.w.x`   | Move From Integer             | `0101100`      | `00000`     | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fmw.x.w`   | Move To Integer               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fcvt.s.w`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fcvt.s.wu` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fcvt.w.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fcvt.wu.s` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fadd.s`    | SPFP Addition                 | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fsub.s`    | SPFP Subtraction              | `0000100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fmul.s`    | SPFP Multiplication           | `0001000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fdiv.s`    | SPFP Division                 | `0001100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fsqrt.s`   | SPFP Square Root              | `0101100`      | `00000`     | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fmadd.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fmsub.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fnmsub.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fnmadd.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fsgnj.s`   | SPFP Sign Injection           | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fsgnjn.s`  | SPFP Sign Injection (Negated) | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fsgnjx.s`  | SPFP Sign Injection (XOR)     | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fmin.s`    | SPFP Minimum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `fmax.s`    | SPFP Maximum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| <input type="checkbox" disabled /> | `feq.s`     | Compare Float =               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `flt.s`     | Compare Float <               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fle.s`     | Compare Float <=              | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fclass.s`  |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `frcsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `frrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `frflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fscsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fsrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| <input type="checkbox" disabled /> | `fsflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |


### Double-precision floating-point register-register operations (RV32D):
| instruction | description | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ----------- | ----------- | -------------- | ----------- | ----------- | -------------- | --------- |
