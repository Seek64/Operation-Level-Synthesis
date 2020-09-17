config_rtl -reset all -reset_async -reset_level high
config_schedule -effort high -relax_ii_for_timing=0 -verbose=0
config_bind -effort high
config_interface -trim_dangling_port
set_directive_latency -max=0 Uart_tx_operations
set_directive_interface -mode ap_ctrl_none Uart_tx_operations
set_directive_interface -mode ap_none Uart_tx_operations data_in_notify_sig
set_directive_interface -mode ap_none Uart_tx_operations events_out_sig
set_directive_interface -mode ap_none Uart_tx_operations data_in_notify_notify
set_directive_interface -mode ap_none Uart_tx_operations events_out_notify
set_directive_interface -mode ap_none Uart_tx_operations txd_notify
set_directive_interface -mode ap_none Uart_tx_operations out_txd_bit
set_directive_interface -mode ap_none Uart_tx_operations out_data
set_directive_allocation -limit 1 -type function Uart_tx_operations get_data_bit
set_directive_allocation -limit 1 -type function Uart_tx_operations get_even_parity
