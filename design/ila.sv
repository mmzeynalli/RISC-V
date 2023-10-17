import common::*;

module ila_rm import common::*;
(
    input rst,
    input register_array register_file,
    output logic ok
);

register_array expected_values;

always_comb begin: rst_exp_regs
    if (rst == RESET)
    begin
        for (int i = 0; i < $size(expected_values); i++)
            expected_values[i] = '{default: '0};  // hard code here
        
        // ok = 0;
    end
end


always_comb begin : check_regs
    ok = 1;
    
    for (int i = 0; i < $size(expected_values); i++)
    begin
        if (register_file[i] != expected_values[i])
        begin
            ok = 0;
            break;
        end
    end
end


endmodule


module ila_dm import common::*;
(
    input rst,
    input memory_array memory_file,
    output logic ok
);

memory_array expected_values;

always_comb begin : rst_exp_mem
    if (rst == RESET)
    begin
        for (int i = 0; i < $size(expected_values); i++)
            expected_values[i] = '{default: '0};  // hard code here
        
        // ok = 0;
    end
end


always_comb begin : check_mem
    ok = 1;
    
    for (int i = 0; i < $size(expected_values); i++)
        if (memory_file[i] != expected_values[i])
        begin
            ok = 0;
            break;
        end
end

endmodule