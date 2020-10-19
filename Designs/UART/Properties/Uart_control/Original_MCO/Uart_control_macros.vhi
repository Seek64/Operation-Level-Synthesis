-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro bus_in_sync : boolean := end macro;
-- macro cts_in_sync : boolean := end macro;
-- macro rx_events_in_sync : boolean := end macro;
-- macro tasks_in_sync : boolean := end macro;
-- macro tx_events_in_sync : boolean := end macro;
-- macro events_out_notify : boolean := end macro;


-- DP SIGNALS --
-- macro bus_in_sig : bus_req_t := bus_in_sig end macro;
macro bus_in_sig_addr : std_logic_vector := bus_in_sig.addr end macro;
macro bus_in_sig_data : std_logic_vector := bus_in_sig.data end macro;
macro bus_in_sig_trans_type : trans_t := bus_in_sig.trans_type end macro;
-- macro bus_out_sig : bus_resp_t := bus_out_sig end macro;
macro bus_out_sig_data : std_logic_vector := bus_out_sig.data end macro;
macro bus_out_sig_valid : boolean := bus_out_sig.valid end macro;
-- macro cts_in_sig : boolean := cts_in_sig end macro;
-- macro events_out_sig : events_t := events_out_sig end macro;
macro events_out_sig_cts : boolean := events_out_sig.cts end macro;
macro events_out_sig_error : boolean := events_out_sig.error end macro;
macro events_out_sig_ncts : boolean := events_out_sig.ncts end macro;
macro events_out_sig_rx_timeout : boolean := events_out_sig.rx_timeout end macro;
macro events_out_sig_rxd_ready : boolean := events_out_sig.rxd_ready end macro;
macro events_out_sig_txd_ready : boolean := events_out_sig.txd_ready end macro;
-- macro rts_out_sig : boolean := rts_out_sig end macro;
-- macro rx_active_out_sig : boolean := rx_active_out_sig end macro;
-- macro rx_config_out_sig : config_t := rx_config_out_sig end macro;
macro rx_config_out_sig_odd_parity : boolean := rx_config_out_sig.odd_parity end macro;
macro rx_config_out_sig_parity : boolean := rx_config_out_sig.parity end macro;
macro rx_config_out_sig_two_stop_bits : boolean := rx_config_out_sig.two_stop_bits end macro;
-- macro rx_events_in_sig : rx_events_t := rx_events_in_sig end macro;
macro rx_events_in_sig_error_src : std_logic_vector := rx_events_in_sig.error_src end macro;
macro rx_events_in_sig_ready : boolean := rx_events_in_sig.ready end macro;
macro rx_events_in_sig_timeout : boolean := rx_events_in_sig.timeout end macro;
-- macro tasks_in_sig : tasks_t := tasks_in_sig end macro;
macro tasks_in_sig_start_rx : boolean := tasks_in_sig.start_rx end macro;
macro tasks_in_sig_start_tx : boolean := tasks_in_sig.start_tx end macro;
macro tasks_in_sig_stop_rx : boolean := tasks_in_sig.stop_rx end macro;
macro tasks_in_sig_stop_tx : boolean := tasks_in_sig.stop_tx end macro;
-- macro tx_config_out_sig : config_t := tx_config_out_sig end macro;
macro tx_config_out_sig_odd_parity : boolean := tx_config_out_sig.odd_parity end macro;
macro tx_config_out_sig_parity : boolean := tx_config_out_sig.parity end macro;
macro tx_config_out_sig_two_stop_bits : boolean := tx_config_out_sig.two_stop_bits end macro;
-- macro tx_control_out_sig : tx_control_t := tx_control_out_sig end macro;
macro tx_control_out_sig_active : boolean := tx_control_out_sig.active end macro;
macro tx_control_out_sig_cts : boolean := tx_control_out_sig.cts end macro;
-- macro tx_events_in_sig : tx_events_t := tx_events_in_sig end macro;
macro tx_events_in_sig_done : boolean := tx_events_in_sig.done end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
-- macro enable : std_logic_vector := enable end macro;
-- macro error_src : std_logic_vector := error_src end macro;
-- macro frame_config : std_logic_vector := frame_config end macro;
-- macro rts_internal : boolean := rts_internal end macro;
-- macro rx_active_out_msg : boolean := rx_active_out_msg end macro;
macro tx_control_out_msg_active : boolean := tx_control_out_msg.active end macro;
macro tx_control_out_msg_cts : boolean := tx_control_out_msg.cts end macro;


-- STATES --
macro IDLE_1 : boolean := active_state = st_IDLE_1 and (ready_sig = '1' or idle_sig = '1') end macro;

macro t_min : unsigned := 2; end macro;
macro t_max : unsigned := 5; end macro;
