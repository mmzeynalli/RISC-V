import common::*;

module uart_rx(
        input clk,
        input rst,

        input rx,
        output logic [7:0] data,
        output logic is_data_rdy
);

typedef enum {rx_standby, rx_wait_half_start_bit, rx_wait_full_data_bit, rx_capture_data_bit, rx_wait_full_last_bit} uart_rx_state_type;
uart_rx_state_type rx_uart_state, rx_uart_state_next;

int cycle_count, cycle_count_next;
int data_bit_count, data_bit_count_next;

logic [7:0] data_next;
logic is_data_rdy_next;


always @(posedge clk)
begin
        if (rst == RESET)
        begin
                rx_uart_state = rx_standby;
                data = 0;
                cycle_count = 0;
                data_bit_count = 0;
                is_data_rdy = 0;
        end 
        else
        begin
                rx_uart_state = rx_uart_state_next;
                data = data_next;
                cycle_count = cycle_count_next;
                data_bit_count = data_bit_count_next;
                is_data_rdy = is_data_rdy_next;                
        end
end    


always @(*) begin
        rx_uart_state_next = rx_uart_state;
        cycle_count_next = cycle_count;
        data_next = data;
        data_bit_count_next = data_bit_count;
        is_data_rdy_next = is_data_rdy;                
    
        case (rx_uart_state)
        
        rx_standby:
                if (rx == 0)
                        rx_uart_state_next = rx_wait_half_start_bit;

        rx_wait_half_start_bit: 
        begin
                cycle_count_next = cycle_count + 1;
                if (cycle_count == BAUD_COUNT_CHECK / 2) begin
                        cycle_count_next = 0;
                        rx_uart_state_next = rx_wait_full_data_bit;
                end
        end
                
        rx_wait_full_data_bit: 
        begin
                cycle_count_next = cycle_count + 1; 
                if (cycle_count == BAUD_COUNT_CHECK) begin
                        cycle_count_next = 0;
                        rx_uart_state_next = rx_capture_data_bit;
                end
        end 
                
        rx_capture_data_bit: 
        begin
                data_next = {rx, data[NUM_DATA_BITS-1:1]};
                data_bit_count_next = data_bit_count + 1;

                if (data_bit_count == 7)
                begin
                        rx_uart_state_next = rx_wait_full_last_bit;
                        is_data_rdy_next = 1;
                end
                else
                        rx_uart_state_next = rx_wait_full_data_bit;
        end    

        rx_wait_full_last_bit:
        begin
                is_data_rdy_next  = 0;
                cycle_count_next = cycle_count + 1;
                if (cycle_count == BAUD_COUNT_CHECK) begin
                        rx_uart_state_next = rx_standby;
                        data_bit_count_next = 0;
                        cycle_count_next = 0;                        
                end 
        end                             
        endcase
end
    
endmodule
