import common::*;

module uart(
        input clk,
        input rst,
        input rx,
        output logic [7:0] data,
        output logic is_data_rdy
);

parameter BAUD = 115200;
localparam FREQUENCY_IN_HZ = 100_000_000;
localparam BAUD_COUNT_CHECK = FREQUENCY_IN_HZ / BAUD;
localparam NUM_DATA_BITS = 8;  

typedef enum {standby, wait_half_start_bit, wait_full_data_bit, capture_data_bit, wait_full_last_bit} uart_state_type;
uart_state_type uart_state, uart_state_next;

int cycle_count, cycle_count_next;
int data_bit_count, data_bit_count_next;

logic [7:0] data_next;


always @(posedge clk)
begin
        if (rst == RESET)
        begin
                uart_state <= standby;
                data <= 0;
                cycle_count <= 0;
                data_bit_count <= 0;
                is_data_rdy <= 0;
        end 
        else
        begin
                uart_state <= uart_state_next;
                data <= data_next;
                cycle_count <= cycle_count_next;
                data_bit_count <= data_bit_count_next;
        end
end    


always @(*) begin
        uart_state_next <= uart_state;
        cycle_count_next <= cycle_count;
        data_next <= data;
        data_bit_count_next <= data_bit_count;
        is_data_rdy <= 0;
    
        case (uart_state)
        
        standby:
                if (rx == 0)
                        uart_state_next <= wait_half_start_bit;

        wait_half_start_bit: 
        begin
                cycle_count_next <= cycle_count + 1;
                if (cycle_count == BAUD_COUNT_CHECK / 2) begin
                        cycle_count_next <= 0;
                        uart_state_next <= wait_full_data_bit;
                end
        end
                
        wait_full_data_bit: 
        begin
                cycle_count_next <= cycle_count + 1; 
                if (cycle_count == BAUD_COUNT_CHECK) begin
                        cycle_count_next <= 0;
                        uart_state_next <= capture_data_bit;
                end 
        end 
                
        capture_data_bit: 
        begin
                data_next = {rx, data[NUM_DATA_BITS-1:1]};
                data_bit_count_next <= data_bit_count + 1;

                if (data_bit_count == 7)
                begin
                        uart_state_next <= wait_full_last_bit;
                        is_data_rdy <= 1;
                end
                else
                        uart_state_next <= wait_full_data_bit;
        end    

        wait_full_last_bit:
        begin
                is_data_rdy  <= 0;
                cycle_count_next <= cycle_count + 1;
                if (cycle_count == BAUD_COUNT_CHECK) begin
                        uart_state_next <= standby;
                        data_bit_count_next <= 0;
                        cycle_count_next <= 0;                        
                end 
        end                             
        endcase
end


    
endmodule
