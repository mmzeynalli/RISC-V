import common::*;

module uart_tx(
        input clk,
        input rst,

        input tx_en,
        input [7:0] tx_byte,
        output logic tx,
        output logic tx_done
);

typedef enum {tx_idle, tx_start_bit, tx_wait_clk_cycle, tx_send_data_bits, tx_stop_bit, tx_cleanup} uart_tx_state_type;
uart_tx_state_type tx_uart_state, tx_uart_state_next;

int cycle_count, cycle_count_next;
int ii, ii_next;
logic tx_done_next, tx_next;


always @(posedge clk)
begin
        if (rst == RESET)
        begin
                tx_uart_state = tx_idle;
                cycle_count = 0;
                ii = 0;
                tx_done = 1;
                tx = 1;
        end 
        else
        begin
                tx_uart_state = tx_uart_state_next;
                cycle_count = cycle_count_next;
                ii = ii_next;
                tx_done = tx_done_next;
                tx = tx_next;
        end
end    

always_comb begin : transmit
                
        tx_uart_state_next = tx_uart_state;
        cycle_count_next = cycle_count;
        tx_done_next = tx_done;
        tx_next = tx;
        ii_next = ii;

        case (tx_uart_state)
                tx_idle:
                begin
                        tx_next = 1;
                        cycle_count_next = '0;

                        if (tx_en)
                        begin
                                tx_uart_state_next = tx_start_bit;
                                tx_done_next = 0;
                        end
                end
                tx_start_bit:
                begin
                        tx_next = 0;
                        tx_uart_state_next = tx_wait_clk_cycle;
                end
                tx_wait_clk_cycle:
                begin
                        cycle_count_next = cycle_count + 1; 

                        if (cycle_count == BAUD_COUNT_CHECK) begin
                                cycle_count_next = 0;
                                tx_uart_state_next = tx_send_data_bits;
                        end
                end
                tx_send_data_bits:
                begin
                        tx_next = tx_byte[ii];
                        ii_next = ii + 1;
                        tx_uart_state_next = tx_wait_clk_cycle;

                        if (ii == NUM_DATA_BITS - 1)
                        begin
                                ii_next = 0;
                                tx_uart_state_next = tx_stop_bit;
                        end
                end
                tx_stop_bit:
                begin
                        tx_next = 1;

                        cycle_count_next = cycle_count + 1; 

                        if (cycle_count == BAUD_COUNT_CHECK) begin
                                cycle_count_next = 0;
                                tx_uart_state_next = tx_cleanup;
                        end 
                end
                tx_cleanup:
                begin
                        // Stay here 1 clock
                        tx_uart_state_next = tx_idle;
                        tx_done_next = 1;
                end 
        endcase
end

    
endmodule
