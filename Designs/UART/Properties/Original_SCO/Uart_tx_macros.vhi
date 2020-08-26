-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro txd_sync : boolean := end macro;
-- macro data_in_notify_notify : boolean := end macro;
-- macro events_out_notify : boolean := end macro;
-- macro txd_notify : boolean := end macro;


-- DP SIGNALS --
-- macro config_in_sig : config_t := config_in_sig end macro;
macro config_in_sig_odd_parity : boolean := config_in_sig.odd_parity end macro;
macro config_in_sig_parity : boolean := config_in_sig.parity end macro;
macro config_in_sig_two_stop_bits : boolean := config_in_sig.two_stop_bits end macro;
-- macro control_in_sig : tx_control_t := control_in_sig end macro;
macro control_in_sig_active : boolean := control_in_sig.active end macro;
macro control_in_sig_cts : boolean := control_in_sig.cts end macro;
-- macro data_in_sig : data_t := data_in_sig end macro;
macro data_in_sig_data : std_logic_vector := data_in_sig.data end macro;
macro data_in_sig_valid : boolean := data_in_sig.valid end macro;
-- macro data_in_notify_sig : boolean := data_in_notify_sig end macro;
-- macro events_out_sig : tx_events_t := events_out_sig end macro;
macro events_out_sig_done : boolean := events_out_sig.done end macro;
-- macro txd_sig : boolean := txd_sig end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
-- macro data : std_logic_vector := data end macro;
-- macro txd_bit : boolean := txd_bit end macro;


-- STATES --
macro IDLE_1 : boolean := active_state = st_IDLE_1 end macro;
macro DATA_NOTIFY_2 : boolean := active_state = st_DATA_NOTIFY_2 end macro;
macro TRANSMITTING_START_3 : boolean := active_state = st_TRANSMITTING_START_3 end macro;
macro TRANSMITTING_DATA_ZERO_4 : boolean := active_state = st_TRANSMITTING_DATA_ZERO_4 end macro;
macro TRANSMITTING_DATA_ONE_5 : boolean := active_state = st_TRANSMITTING_DATA_ONE_5 end macro;
macro TRANSMITTING_DATA_TWO_6 : boolean := active_state = st_TRANSMITTING_DATA_TWO_6 end macro;
macro TRANSMITTING_DATA_THREE_7 : boolean := active_state = st_TRANSMITTING_DATA_THREE_7 end macro;
macro TRANSMITTING_DATA_FOUR_8 : boolean := active_state = st_TRANSMITTING_DATA_FOUR_8 end macro;
macro TRANSMITTING_DATA_FIVE_9 : boolean := active_state = st_TRANSMITTING_DATA_FIVE_9 end macro;
macro TRANSMITTING_DATA_SIX_10 : boolean := active_state = st_TRANSMITTING_DATA_SIX_10 end macro;
macro TRANSMITTING_DATA_SEVEN_11 : boolean := active_state = st_TRANSMITTING_DATA_SEVEN_11 end macro;
macro TRANSMITTING_PARITY_12 : boolean := active_state = st_TRANSMITTING_PARITY_12 end macro;
macro TRANSMITTING_STOP_FIRST_13 : boolean := active_state = st_TRANSMITTING_STOP_FIRST_13 end macro;
macro TRANSMITTING_STOP_SECOND_14 : boolean := active_state = st_TRANSMITTING_STOP_SECOND_14 end macro;
macro STOP_NOTIFY_15 : boolean := active_state = st_STOP_NOTIFY_15 end macro;


