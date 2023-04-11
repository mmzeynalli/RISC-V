package common;

        const logic     RESET                   = 1'b0;
        const int       INSTRUCTION_WIDTH       = 32;

        enum bit[3:0] { AND, OR, SADD, SSUB, UADD, USUB, SHIFT, MUL, DIV, REM } alu_operation_type;

endpackage
