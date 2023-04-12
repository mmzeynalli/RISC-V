Here is the list of R-type commands and their decomposotion:

### Integer register-register operations (RV32I):

| instruction | description            | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ----------- | ---------------------- | -------------- | ----------- | ----------- | -------------- | --------- |
| `add`       | Addition               | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| `sub`       | Subtraction            | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| `sll`       | Shift Left Logical     | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| `slt`       | Set Less Than          | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| `sltu`      | Set Less Than Unsigned | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |
| `xor`       | Bitwise XOR            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| `srl`       | Shift Right Logical    | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| `sra`       | Shift Right Arithmetic | `0100000`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| `or`        | Bitwise OR             | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| `and`       | Bitwise AND            | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |

### Integer multiplication and division (RV32M):
| instruction | description                                          | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ----------- | ---------------------------------------------------- | -------------- | ----------- | ----------- | -------------- | --------- | ------------ |
| `mul`       | Multiplication                                       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `0110011`    |
| `mulh`      | Multiplication High (signed × signed → signed)       | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `0110011`    |
| `mulhsu`    | Multiplication High (signed × unsigned → signed)     | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `0110011`    |
| `mulhu`     | Multiplication High (unsigned × unsigned → unsigned) | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `011`          | `rd[4:0]` | `0110011`    |
| `div`       | Division (signed / signed → signed)                  | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `100`          | `rd[4:0]` | `0110011`    |
| `divu`      | Division (unsigned / unsigned → unsigned)            | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `101`          | `rd[4:0]` | `0110011`    |
| `rem`       | Remainder (signed % signed → signed)                 | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `110`          | `rd[4:0]` | `0110011`    |
| `remu`      | Remainder (unsigned % unsigned → unsigned)           | `0000001`      | `rs2[4:0]`  | `rs1[4:0]`  | `111`          | `rd[4:0]` | `0110011`    |


### Single-precision floating-point register-register operations (RV32F): (SPFP -> Single-Precision Floating-Point)
| instruction | description                   | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ----------- | ----------------------------- | -------------- | ----------- | ----------- | -------------- | --------- |
| `fmw.w.x`   | Move From Integer             | `0101100`      | `00000`     | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| `fmw.x.w`   | Move To Integer               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fcvt.s.w`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fcvt.s.wu` |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fmw.w.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fmw.wu.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fadd.s`    | SPFP Addition                 | `0000000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| `fsub.s`    | SPFP Subtraction              | `0000100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| `fmul.s`    | SPFP Multiplication           | `0001000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| `fdiv.s`    | SPFP Division                 | `0001100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| `fsqrt.s`   | SPFP Square Root              | `0101100`      | `00000`     | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| `fmadd.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fmsub.s`   |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fnmsub.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fnmadd.s`  |                               | `x`            | `x`         | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fsgnj.s`   | SPFP Sign Injection           | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| `fsgnjn.s`  | SPFP Sign Injection (Negated) | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| `fsgnjx.s`  | SPFP Sign Injection (XOR)     | `0010000`      | `rs2[4:0]`  | `rs1[4:0]`  | `010`          | `rd[4:0]` | `1010011`    |
| `fmin.s`    | SPFP Minimum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `000`          | `rd[4:0]` | `1010011`    |
| `fmax.s`    | SPFP Maximum                  | `0010100`      | `rs2[4:0]`  | `rs1[4:0]`  | `001`          | `rd[4:0]` | `1010011`    |
| `feq.s`     | Compare Float =               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `flt.s`     | Compare Float <               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fle.s`     | Compare Float <=              | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fclass.s`  |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `frcsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `frrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `frflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fscsr`     |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fsrm`      |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |
| `fsflags`   |                               | `x`            | `rs2[4:0]`  | `rs1[4:0]`  | `x`            | `rd[4:0]` | `x`          |


### Double-precision floating-point register-register operations (RV32D):
| instruction | description | funct7 (31:25) | rs2 (24:20) | rs1 (19:15) | funct3 (14:12) | rd (11:7) | opcode (6:0) |
| ----------- | ----------- | -------------- | ----------- | ----------- | -------------- | --------- |
