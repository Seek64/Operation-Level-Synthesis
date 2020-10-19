-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro rxd_sync : boolean := end macro;
-- macro events_out_notify : boolean := end macro;
-- macro rxd_notify : boolean := end macro;


-- DP SIGNALS --
-- macro config_in_sig : config_t := config_in_sig end macro;
macro config_in_sig_odd_parity : boolean := config_in_sig.odd_parity end macro;
macro config_in_sig_parity : boolean := config_in_sig.parity end macro;
macro config_in_sig_two_stop_bits : boolean := config_in_sig.two_stop_bits end macro;
-- macro control_active_in_sig : boolean := control_active_in_sig end macro;
-- macro data_out_sig : data_t := data_out_sig end macro;
macro data_out_sig_data : std_logic_vector := data_out_sig.data end macro;
macro data_out_sig_valid : boolean := data_out_sig.valid end macro;
-- macro data_out_sync_sig : boolean := data_out_sync_sig end macro;
-- macro events_out_sig : rx_events_t := events_out_sig end macro;
macro events_out_sig_error_src : std_logic_vector := events_out_sig.error_src end macro;
macro events_out_sig_ready : boolean := events_out_sig.ready end macro;
macro events_out_sig_timeout : boolean := events_out_sig.timeout end macro;
-- macro rxd_sig : boolean := rxd_sig end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro data_out_msg_data : std_logic_vector := data_out_msg.data end macro;
macro data_out_msg_valid : boolean := data_out_msg.valid end macro;
macro events_out_msg_error_src : std_logic_vector := events_out_msg.error_src end macro;
macro events_out_msg_ready : boolean := events_out_msg.ready end macro;
macro events_out_msg_timeout : boolean := events_out_msg.timeout end macro;
-- macro first_stop_bit : boolean := first_stop_bit end macro;
-- macro parity : boolean := parity end macro;
-- macro suspending_count : std_logic_vector := suspending_count end macro;
-- macro timeout : boolean := timeout end macro;
-- macro wait_framing_break : boolean := wait_framing_break end macro;


-- STATES --
macro IDLE_1 : boolean := active_state = st_IDLE_1 end macro;
macro GET_BIT_ZERO_2 : boolean := active_state = st_GET_BIT_ZERO_2 end macro;
macro GET_BIT_ONE_3 : boolean := active_state = st_GET_BIT_ONE_3 end macro;
macro GET_BIT_TWO_4 : boolean := active_state = st_GET_BIT_TWO_4 end macro;
macro GET_BIT_THREE_5 : boolean := active_state = st_GET_BIT_THREE_5 end macro;
macro GET_BIT_FOUR_6 : boolean := active_state = st_GET_BIT_FOUR_6 end macro;
macro GET_BIT_FIVE_7 : boolean := active_state = st_GET_BIT_FIVE_7 end macro;
macro GET_BIT_SIX_8 : boolean := active_state = st_GET_BIT_SIX_8 end macro;
macro GET_BIT_SEVEN_9 : boolean := active_state = st_GET_BIT_SEVEN_9 end macro;
macro GET_PARITY_BIT_10 : boolean := active_state = st_GET_PARITY_BIT_10 end macro;
macro GET_STOP_BIT_11 : boolean := active_state = st_GET_STOP_BIT_11 end macro;
macro GET_STOP_BIT_SECOND_12 : boolean := active_state = st_GET_STOP_BIT_SECOND_12 end macro;


