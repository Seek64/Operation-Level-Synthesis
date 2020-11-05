library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Uart_control_operations;
use work.Uart_control_types.all;

entity Uart_control_module is
port(
	tx_events_in_sig: in tx_events_t;
	bus_in_sig: in bus_req_t;
	tasks_in_sig: in tasks_t;
	cts_in_sig: in std_logic;
	rx_events_in_sig: in rx_events_t;
	tx_control_out_sig: out tx_control_t;
	rx_config_out_sig: out config_t;
	bus_out_sig: out bus_resp_t;
	events_out_sig: out events_t;
	tx_config_out_sig: out config_t;
	rts_out_sig: out std_logic;
	rx_active_out_sig: out std_logic;
	events_out_notify: out std_logic;
	bus_in_sync: in std_logic;
	cts_in_sync: in std_logic;
	rx_events_in_sync: in std_logic;
	tasks_in_sync: in std_logic;
	tx_events_in_sync: in std_logic;
	rst: in std_logic;
	clk: in std_logic
);
end Uart_control_module;

architecture Uart_control_arch of Uart_control_module is

	-- Internal Registers
	signal rts_internal: std_logic;
	signal error_src: std_logic_vector(31 downto 0);
	signal frame_config: std_logic_vector(31 downto 0);
	signal enable: std_logic_vector(31 downto 0);
	signal tx_control_out_msg: tx_control_t;
	signal rx_active_out_msg: std_logic;
	signal in_rts_internal: std_logic;
	signal in_error_src: std_logic_vector(31 downto 0);
	signal in_frame_config: std_logic_vector(31 downto 0);
	signal in_enable: std_logic_vector(31 downto 0);
	signal in_tx_control_out_msg_active: std_logic;
	signal in_rx_active_out_msg: std_logic;
	signal out_rts_internal: std_logic;
	signal out_rts_internal_vld: std_logic;
	signal out_tx_control_out_msg_cts: std_logic;
	signal out_tx_control_out_msg_cts_vld: std_logic;
	signal out_error_src: std_logic_vector(31 downto 0);
	signal out_error_src_vld: std_logic;
	signal out_frame_config: std_logic_vector(31 downto 0);
	signal out_frame_config_vld: std_logic;
	signal out_enable: std_logic_vector(31 downto 0);
	signal out_enable_vld: std_logic;
	signal out_tx_control_out_msg_active: std_logic;
	signal out_tx_control_out_msg_active_vld: std_logic;
	signal out_rx_active_out_msg: std_logic;
	signal out_rx_active_out_msg_vld: std_logic;

	-- Module Inputs
	signal tx_events_in_sig_done_in: std_logic;
	signal rx_events_in_sig_timeout_in: std_logic;
	signal tasks_in_sig_start_rx_in: std_logic;
	signal tasks_in_sig_start_tx_in: std_logic;
	signal cts_in_sig_in: std_logic;
	signal bus_in_sig_addr_in: std_logic_vector(31 downto 0);
	signal bus_in_sig_data_in: std_logic_vector(31 downto 0);
	signal bus_in_sig_trans_type_in: std_logic_vector(0 downto 0);
	signal rx_events_in_sig_error_src_in: std_logic_vector(31 downto 0);
	signal rx_events_in_sig_ready_in: std_logic;
	signal tasks_in_sig_stop_rx_in: std_logic;
	signal tasks_in_sig_stop_tx_in: std_logic;
	signal active_operation_in: std_logic_vector(5 downto 0);

	-- Module Outputs
	signal tx_control_out_sig_reg : tx_control_t;
	signal rx_config_out_sig_reg : config_t;
	signal bus_out_sig_reg : bus_resp_t;
	signal events_out_sig_reg : events_t;
	signal tx_config_out_sig_reg : config_t;
	signal rts_out_sig_reg : std_logic;
	signal rx_active_out_sig_reg : std_logic;
	signal rx_config_out_sig_odd_parity_out: std_logic;
	signal rx_config_out_sig_odd_parity_vld: std_logic;
	signal rx_config_out_sig_parity_out: std_logic;
	signal rx_config_out_sig_parity_vld: std_logic;
	signal rx_config_out_sig_two_stop_bits_out: std_logic;
	signal rx_config_out_sig_two_stop_bits_vld: std_logic;
	signal events_out_sig_cts_out: std_logic;
	signal events_out_sig_cts_vld: std_logic;
	signal events_out_sig_error_out: std_logic;
	signal events_out_sig_error_vld: std_logic;
	signal bus_out_sig_data_out: std_logic_vector(31 downto 0);
	signal bus_out_sig_data_vld: std_logic;
	signal bus_out_sig_valid_out: std_logic;
	signal bus_out_sig_valid_vld: std_logic;
	signal events_out_sig_rxd_ready_out: std_logic;
	signal events_out_sig_rxd_ready_vld: std_logic;
	signal events_out_sig_txd_ready_out: std_logic;
	signal events_out_sig_txd_ready_vld: std_logic;
	signal events_out_sig_ncts_out: std_logic;
	signal events_out_sig_ncts_vld: std_logic;
	signal events_out_sig_rx_timeout_out: std_logic;
	signal events_out_sig_rx_timeout_vld: std_logic;
	signal tx_config_out_sig_odd_parity_out: std_logic;
	signal tx_config_out_sig_odd_parity_vld: std_logic;
	signal tx_config_out_sig_parity_out: std_logic;
	signal tx_config_out_sig_parity_vld: std_logic;
	signal tx_config_out_sig_two_stop_bits_out: std_logic;
	signal tx_config_out_sig_two_stop_bits_vld: std_logic;
	signal events_out_notify_out: std_logic;
	signal events_out_notify_vld: std_logic;
	signal events_out_notify_reg: std_logic;

	-- Handshaking Protocol Signals (Communication between top and operations_inst)
	signal ready_sig: std_logic;
	signal done_sig: std_logic;
	signal idle_sig: std_logic;
	signal start_sig: std_logic;

	-- Monitor Signals
	signal active_operation: Uart_control_operation_t;
	signal active_state: Uart_control_state_t;
	signal wait_state: std_logic;
	signal next_state: Uart_control_state_t;

	-- Functions
	function bool_to_sl(x : boolean) return std_logic;
	function HWFC(stop_bit: std_logic_vector(31 downto 0)) return std_logic;
	function ENABLE_SET(enable: std_logic_vector(31 downto 0)) return std_logic;

	function bool_to_sl(x : boolean) return std_logic is
	begin
  	if x then
    	return '1';
  	else
    	return '0';
  	end if;
  end bool_to_sl;

	function HWFC(stop_bit: std_logic_vector(31 downto 0)) return std_logic is
	begin
		return bool_to_sl((stop_bit and CONFIG_HWFC_MASK) /= x"00000000");
	end HWFC;

	function ENABLE_SET(enable: std_logic_vector(31 downto 0)) return std_logic is
	begin
		return bool_to_sl((enable and x"00000001") /= x"00000000");
	end ENABLE_SET;


	component Uart_control_operations is
	port(
		ap_rst: in std_logic;
		ap_clk: in std_logic;
		ap_ready: out std_logic;
		ap_done: out std_logic;
		ap_idle: out std_logic;
		ap_start: in std_logic;
		tx_events_in_sig_done: in std_logic;
		rx_events_in_sig_timeout: in std_logic;
		tasks_in_sig_start_rx: in std_logic;
		tasks_in_sig_start_tx: in std_logic;
		cts_in_sig: in std_logic;
		bus_in_sig_addr_V: in std_logic_vector(31 downto 0);
		bus_in_sig_data_V: in std_logic_vector(31 downto 0);
		bus_in_sig_trans_type: in std_logic_vector(0 downto 0);
		rx_events_in_sig_error_src_V: in std_logic_vector(31 downto 0);
		rx_events_in_sig_ready: in std_logic;
		tasks_in_sig_stop_rx: in std_logic;
		tasks_in_sig_stop_tx: in std_logic;
		rx_config_out_sig_odd_parity: out std_logic;
		rx_config_out_sig_odd_parity_ap_vld: out std_logic;
		rx_config_out_sig_parity: out std_logic;
		rx_config_out_sig_parity_ap_vld: out std_logic;
		rx_config_out_sig_two_stop_bits: out std_logic;
		rx_config_out_sig_two_stop_bits_ap_vld: out std_logic;
		events_out_sig_cts: out std_logic;
		events_out_sig_cts_ap_vld: out std_logic;
		events_out_sig_error: out std_logic;
		events_out_sig_error_ap_vld: out std_logic;
		bus_out_sig_data_V: out std_logic_vector(31 downto 0);
		bus_out_sig_data_V_ap_vld: out std_logic;
		bus_out_sig_valid: out std_logic;
		bus_out_sig_valid_ap_vld: out std_logic;
		events_out_sig_rxd_ready: out std_logic;
		events_out_sig_rxd_ready_ap_vld: out std_logic;
		events_out_sig_txd_ready: out std_logic;
		events_out_sig_txd_ready_ap_vld: out std_logic;
		events_out_sig_ncts: out std_logic;
		events_out_sig_ncts_ap_vld: out std_logic;
		events_out_sig_rx_timeout: out std_logic;
		events_out_sig_rx_timeout_ap_vld: out std_logic;
		tx_config_out_sig_odd_parity: out std_logic;
		tx_config_out_sig_odd_parity_ap_vld: out std_logic;
		tx_config_out_sig_parity: out std_logic;
		tx_config_out_sig_parity_ap_vld: out std_logic;
		tx_config_out_sig_two_stop_bits: out std_logic;
		tx_config_out_sig_two_stop_bits_ap_vld: out std_logic;
		in_rts_internal: in std_logic;
		in_error_src_V: in std_logic_vector(31 downto 0);
		in_frame_config_V: in std_logic_vector(31 downto 0);
		in_enable_V: in std_logic_vector(31 downto 0);
		in_tx_control_out_msg_active: in std_logic;
		in_rx_active_out_msg: in std_logic;
		out_rts_internal: out std_logic;
		out_rts_internal_ap_vld: out std_logic;
		out_tx_control_out_msg_cts: out std_logic;
		out_tx_control_out_msg_cts_ap_vld: out std_logic;
		out_error_src_V: out std_logic_vector(31 downto 0);
		out_error_src_V_ap_vld: out std_logic;
		out_frame_config_V: out std_logic_vector(31 downto 0);
		out_frame_config_V_ap_vld: out std_logic;
		out_enable_V: out std_logic_vector(31 downto 0);
		out_enable_V_ap_vld: out std_logic;
		out_tx_control_out_msg_active: out std_logic;
		out_tx_control_out_msg_active_ap_vld: out std_logic;
		out_rx_active_out_msg: out std_logic;
		out_rx_active_out_msg_ap_vld: out std_logic;
		events_out_notify: out std_logic;
		events_out_notify_ap_vld: out std_logic;
		active_operation: in std_logic_vector(5 downto 0)
	);
	end component;

begin

	operations_inst: Uart_control_operations
	port map(
		ap_rst => rst,
		ap_clk => clk,
		ap_ready => ready_sig,
		ap_done => done_sig,
		ap_idle => idle_sig,
		ap_start => start_sig,
		tx_events_in_sig_done => tx_events_in_sig_done_in,
		rx_events_in_sig_timeout => rx_events_in_sig_timeout_in,
		tasks_in_sig_start_rx => tasks_in_sig_start_rx_in,
		tasks_in_sig_start_tx => tasks_in_sig_start_tx_in,
		cts_in_sig => cts_in_sig_in,
		bus_in_sig_addr_V => bus_in_sig_addr_in,
		bus_in_sig_data_V => bus_in_sig_data_in,
		bus_in_sig_trans_type => bus_in_sig_trans_type_in,
		rx_events_in_sig_error_src_V => rx_events_in_sig_error_src_in,
		rx_events_in_sig_ready => rx_events_in_sig_ready_in,
		tasks_in_sig_stop_rx => tasks_in_sig_stop_rx_in,
		tasks_in_sig_stop_tx => tasks_in_sig_stop_tx_in,
		rx_config_out_sig_odd_parity => rx_config_out_sig_odd_parity_out,
		rx_config_out_sig_odd_parity_ap_vld => rx_config_out_sig_odd_parity_vld,
		rx_config_out_sig_parity => rx_config_out_sig_parity_out,
		rx_config_out_sig_parity_ap_vld => rx_config_out_sig_parity_vld,
		rx_config_out_sig_two_stop_bits => rx_config_out_sig_two_stop_bits_out,
		rx_config_out_sig_two_stop_bits_ap_vld => rx_config_out_sig_two_stop_bits_vld,
		events_out_sig_cts => events_out_sig_cts_out,
		events_out_sig_cts_ap_vld => events_out_sig_cts_vld,
		events_out_sig_error => events_out_sig_error_out,
		events_out_sig_error_ap_vld => events_out_sig_error_vld,
		bus_out_sig_data_V => bus_out_sig_data_out,
		bus_out_sig_data_V_ap_vld => bus_out_sig_data_vld,
		bus_out_sig_valid => bus_out_sig_valid_out,
		bus_out_sig_valid_ap_vld => bus_out_sig_valid_vld,
		events_out_sig_rxd_ready => events_out_sig_rxd_ready_out,
		events_out_sig_rxd_ready_ap_vld => events_out_sig_rxd_ready_vld,
		events_out_sig_txd_ready => events_out_sig_txd_ready_out,
		events_out_sig_txd_ready_ap_vld => events_out_sig_txd_ready_vld,
		events_out_sig_ncts => events_out_sig_ncts_out,
		events_out_sig_ncts_ap_vld => events_out_sig_ncts_vld,
		events_out_sig_rx_timeout => events_out_sig_rx_timeout_out,
		events_out_sig_rx_timeout_ap_vld => events_out_sig_rx_timeout_vld,
		tx_config_out_sig_odd_parity => tx_config_out_sig_odd_parity_out,
		tx_config_out_sig_odd_parity_ap_vld => tx_config_out_sig_odd_parity_vld,
		tx_config_out_sig_parity => tx_config_out_sig_parity_out,
		tx_config_out_sig_parity_ap_vld => tx_config_out_sig_parity_vld,
		tx_config_out_sig_two_stop_bits => tx_config_out_sig_two_stop_bits_out,
		tx_config_out_sig_two_stop_bits_ap_vld => tx_config_out_sig_two_stop_bits_vld,
		in_rts_internal => in_rts_internal,
		in_error_src_V => in_error_src,
		in_frame_config_V => in_frame_config,
		in_enable_V => in_enable,
		in_tx_control_out_msg_active => in_tx_control_out_msg_active,
		in_rx_active_out_msg => in_rx_active_out_msg,
		out_rts_internal => out_rts_internal,
		out_rts_internal_ap_vld => out_rts_internal_vld,
		out_tx_control_out_msg_cts => out_tx_control_out_msg_cts,
		out_tx_control_out_msg_cts_ap_vld => out_tx_control_out_msg_cts_vld,
		out_error_src_V => out_error_src,
		out_error_src_V_ap_vld => out_error_src_vld,
		out_frame_config_V => out_frame_config,
		out_frame_config_V_ap_vld => out_frame_config_vld,
		out_enable_V => out_enable,
		out_enable_V_ap_vld => out_enable_vld,
		out_tx_control_out_msg_active => out_tx_control_out_msg_active,
		out_tx_control_out_msg_active_ap_vld => out_tx_control_out_msg_active_vld,
		out_rx_active_out_msg => out_rx_active_out_msg,
		out_rx_active_out_msg_ap_vld => out_rx_active_out_msg_vld,
		events_out_notify => events_out_notify_out,
		events_out_notify_ap_vld  => events_out_notify_vld,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, tasks_in_sync, cts_in_sync, rx_events_in_sync, bus_in_sync, tx_events_in_sync, frame_config, enable)
	begin
		case active_state is
		when st_IDLE_1 =>
			if (bus_in_sync and tasks_in_sync and cts_in_sync and tx_events_in_sync and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_1;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and cts_in_sync and tx_events_in_sync and not(rx_events_in_sync) and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_2;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and cts_in_sync and not(tx_events_in_sync) and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_3;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and cts_in_sync and not(tx_events_in_sync) and not(rx_events_in_sync) and ENABLE_SET(enable) and HWFC(frame_config)) = '1' then
				active_operation <= op_IDLE_1_4;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and not(cts_in_sync) and tx_events_in_sync and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_5;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and not(cts_in_sync) and tx_events_in_sync and not(rx_events_in_sync) and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_6;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and not(cts_in_sync) and not(tx_events_in_sync) and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_7;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and cts_in_sync and tx_events_in_sync and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_9;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and cts_in_sync and tx_events_in_sync and not(rx_events_in_sync) and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_10;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and cts_in_sync and not(tx_events_in_sync) and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_11;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and cts_in_sync and not(tx_events_in_sync) and not(rx_events_in_sync) and ENABLE_SET(enable) and HWFC(frame_config)) = '1' then
				active_operation <= op_IDLE_1_12;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and not(cts_in_sync) and tx_events_in_sync and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_13;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and not(cts_in_sync) and tx_events_in_sync and not(rx_events_in_sync) and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_14;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and not(cts_in_sync) and not(tx_events_in_sync) and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_15;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and cts_in_sync and tx_events_in_sync and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_17;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and cts_in_sync and tx_events_in_sync and not(rx_events_in_sync) and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_18;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and cts_in_sync and not(tx_events_in_sync) and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_19;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and cts_in_sync and not(tx_events_in_sync) and not(rx_events_in_sync) and ENABLE_SET(enable) and HWFC(frame_config)) = '1' then
				active_operation <= op_IDLE_1_20;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and not(cts_in_sync) and tx_events_in_sync and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_21;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and not(cts_in_sync) and tx_events_in_sync and not(rx_events_in_sync) and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_22;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and not(cts_in_sync) and not(tx_events_in_sync) and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_23;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and cts_in_sync and tx_events_in_sync and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_25;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and cts_in_sync and tx_events_in_sync and not(rx_events_in_sync) and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_26;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and cts_in_sync and not(tx_events_in_sync) and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_27;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and cts_in_sync and not(tx_events_in_sync) and not(rx_events_in_sync) and ENABLE_SET(enable) and HWFC(frame_config)) = '1' then
				active_operation <= op_IDLE_1_28;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and not(cts_in_sync) and tx_events_in_sync and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_29;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and not(cts_in_sync) and tx_events_in_sync and not(rx_events_in_sync) and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_30;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and not(cts_in_sync) and not(tx_events_in_sync) and rx_events_in_sync and ENABLE_SET(enable)) = '1' then
				active_operation <= op_IDLE_1_31;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and cts_in_sync and tx_events_in_sync and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_33;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and cts_in_sync and tx_events_in_sync and not(rx_events_in_sync) and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_34;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and cts_in_sync and not(tx_events_in_sync) and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_35;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and cts_in_sync and not(tx_events_in_sync) and not(rx_events_in_sync) and not((ENABLE_SET(enable) and HWFC(frame_config)))) = '1' then
				active_operation <= op_IDLE_1_36;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and not(cts_in_sync) and tx_events_in_sync and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_37;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and not(cts_in_sync) and tx_events_in_sync and not(rx_events_in_sync) and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_38;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and not(cts_in_sync) and not(tx_events_in_sync) and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_39;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and tasks_in_sync and not(cts_in_sync) and not(tx_events_in_sync) and not(rx_events_in_sync)) = '1' then
				active_operation <= op_IDLE_1_40;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and cts_in_sync and tx_events_in_sync and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_41;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and cts_in_sync and tx_events_in_sync and not(rx_events_in_sync) and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_42;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and cts_in_sync and not(tx_events_in_sync) and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_43;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and cts_in_sync and not(tx_events_in_sync) and not(rx_events_in_sync) and not((ENABLE_SET(enable) and HWFC(frame_config)))) = '1' then
				active_operation <= op_IDLE_1_44;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and not(cts_in_sync) and tx_events_in_sync and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_45;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and not(cts_in_sync) and tx_events_in_sync and not(rx_events_in_sync) and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_46;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and not(cts_in_sync) and not(tx_events_in_sync) and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_47;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (bus_in_sync and not(tasks_in_sync) and not(cts_in_sync) and not(tx_events_in_sync) and not(rx_events_in_sync)) = '1' then
				active_operation <= op_IDLE_1_48;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and cts_in_sync and tx_events_in_sync and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_49;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and cts_in_sync and tx_events_in_sync and not(rx_events_in_sync) and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_50;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and cts_in_sync and not(tx_events_in_sync) and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_51;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and cts_in_sync and not(tx_events_in_sync) and not(rx_events_in_sync) and not((ENABLE_SET(enable) and HWFC(frame_config)))) = '1' then
				active_operation <= op_IDLE_1_52;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and not(cts_in_sync) and tx_events_in_sync and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_53;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and not(cts_in_sync) and tx_events_in_sync and not(rx_events_in_sync) and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_54;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and not(cts_in_sync) and not(tx_events_in_sync) and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_55;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and tasks_in_sync and not(cts_in_sync) and not(tx_events_in_sync) and not(rx_events_in_sync)) = '1' then
				active_operation <= op_IDLE_1_56;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and cts_in_sync and tx_events_in_sync and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_57;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and cts_in_sync and tx_events_in_sync and not(rx_events_in_sync) and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_58;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and cts_in_sync and not(tx_events_in_sync) and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_59;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and cts_in_sync and not(tx_events_in_sync) and not(rx_events_in_sync) and not((ENABLE_SET(enable) and HWFC(frame_config)))) = '1' then
				active_operation <= op_IDLE_1_60;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and not(cts_in_sync) and tx_events_in_sync and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_61;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and not(cts_in_sync) and tx_events_in_sync and not(rx_events_in_sync) and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_62;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			elsif (not(bus_in_sync) and not(tasks_in_sync) and not(cts_in_sync) and not(tx_events_in_sync) and rx_events_in_sync and not(ENABLE_SET(enable))) = '1' then
				active_operation <= op_IDLE_1_63;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			else
				active_operation <= op_IDLE_1_64;
				next_state <= st_IDLE_1;
				wait_state <= '0';
			end if;
		end case;
	end process;

	-- Output Processes
	process (clk, rst)
	begin
		if (rst = '1') then
			tx_control_out_sig_reg.active <= '0';
		elsif (clk = '1' and clk'event) then
			if (out_tx_control_out_msg_active_vld = '1') then
				tx_control_out_sig_reg.active <= out_tx_control_out_msg_active;
			end if;
		end if;
	end process;

	process (clk, done_sig, out_tx_control_out_msg_active_vld)
	begin
		if (rst = '1') then
			tx_control_out_sig.active <= '0';
		elsif ((done_sig = '1') and (out_tx_control_out_msg_active_vld = '1')) then
			tx_control_out_sig.active <= out_tx_control_out_msg_active;
		else
			tx_control_out_sig.active <= tx_control_out_sig_reg.active;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			tx_control_out_sig_reg.cts <= '1';
		elsif (clk = '1' and clk'event) then
			if (out_tx_control_out_msg_cts_vld = '1') then
				tx_control_out_sig_reg.cts <= out_tx_control_out_msg_cts;
			end if;
		end if;
	end process;

	process (clk, done_sig, out_tx_control_out_msg_cts_vld)
	begin
		if (rst = '1') then
			tx_control_out_sig.cts <= '1';
		elsif ((done_sig = '1') and (out_tx_control_out_msg_cts_vld = '1')) then
			tx_control_out_sig.cts <= out_tx_control_out_msg_cts;
		else
			tx_control_out_sig.cts <= tx_control_out_sig_reg.cts;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			rx_config_out_sig_reg.odd_parity <= '0';
		elsif (clk = '1' and clk'event) then
			if (rx_config_out_sig_odd_parity_vld = '1') then
				rx_config_out_sig_reg.odd_parity <= rx_config_out_sig_odd_parity_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, rx_config_out_sig_odd_parity_vld)
	begin
		if (rst = '1') then
			rx_config_out_sig.odd_parity <= '0';
		elsif ((done_sig = '1') and (rx_config_out_sig_odd_parity_vld = '1')) then
			rx_config_out_sig.odd_parity <= rx_config_out_sig_odd_parity_out;
		else
			rx_config_out_sig.odd_parity <= rx_config_out_sig_reg.odd_parity;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			rx_config_out_sig_reg.parity <= '0';
		elsif (clk = '1' and clk'event) then
			if (rx_config_out_sig_parity_vld = '1') then
				rx_config_out_sig_reg.parity <= rx_config_out_sig_parity_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, rx_config_out_sig_parity_vld)
	begin
		if (rst = '1') then
			rx_config_out_sig.parity <= '0';
		elsif ((done_sig = '1') and (rx_config_out_sig_parity_vld = '1')) then
			rx_config_out_sig.parity <= rx_config_out_sig_parity_out;
		else
			rx_config_out_sig.parity <= rx_config_out_sig_reg.parity;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			rx_config_out_sig_reg.two_stop_bits <= '0';
		elsif (clk = '1' and clk'event) then
			if (rx_config_out_sig_two_stop_bits_vld = '1') then
				rx_config_out_sig_reg.two_stop_bits <= rx_config_out_sig_two_stop_bits_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, rx_config_out_sig_two_stop_bits_vld)
	begin
		if (rst = '1') then
			rx_config_out_sig.two_stop_bits <= '0';
		elsif ((done_sig = '1') and (rx_config_out_sig_two_stop_bits_vld = '1')) then
			rx_config_out_sig.two_stop_bits <= rx_config_out_sig_two_stop_bits_out;
		else
			rx_config_out_sig.two_stop_bits <= rx_config_out_sig_reg.two_stop_bits;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			bus_out_sig_reg.data <= x"00000000";
		elsif (clk = '1' and clk'event) then
			if (bus_out_sig_data_vld = '1') then
				bus_out_sig_reg.data <= bus_out_sig_data_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, bus_out_sig_data_vld)
	begin
		if (rst = '1') then
			bus_out_sig.data <= x"00000000";
		elsif ((done_sig = '1') and (bus_out_sig_data_vld = '1')) then
			bus_out_sig.data <= bus_out_sig_data_out;
		else
			bus_out_sig.data <= bus_out_sig_reg.data;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			bus_out_sig_reg.valid <= '0';
		elsif (clk = '1' and clk'event) then
			if (bus_out_sig_valid_vld = '1') then
				bus_out_sig_reg.valid <= bus_out_sig_valid_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, bus_out_sig_valid_vld)
	begin
		if (rst = '1') then
			bus_out_sig.valid <= '0';
		elsif ((done_sig = '1') and (bus_out_sig_valid_vld = '1')) then
			bus_out_sig.valid <= bus_out_sig_valid_out;
		else
			bus_out_sig.valid <= bus_out_sig_reg.valid;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			events_out_sig_reg.cts <= '0';
		elsif (clk = '1' and clk'event) then
			if (events_out_sig_cts_vld = '1') then
				events_out_sig_reg.cts <= events_out_sig_cts_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, events_out_sig_cts_vld)
	begin
		if (rst = '1') then
			events_out_sig.cts <= '0';
		elsif ((done_sig = '1') and (events_out_sig_cts_vld = '1')) then
			events_out_sig.cts <= events_out_sig_cts_out;
		else
			events_out_sig.cts <= events_out_sig_reg.cts;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			events_out_sig_reg.error <= '0';
		elsif (clk = '1' and clk'event) then
			if (events_out_sig_error_vld = '1') then
				events_out_sig_reg.error <= events_out_sig_error_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, events_out_sig_error_vld)
	begin
		if (rst = '1') then
			events_out_sig.error <= '0';
		elsif ((done_sig = '1') and (events_out_sig_error_vld = '1')) then
			events_out_sig.error <= events_out_sig_error_out;
		else
			events_out_sig.error <= events_out_sig_reg.error;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			events_out_sig_reg.ncts <= '0';
		elsif (clk = '1' and clk'event) then
			if (events_out_sig_ncts_vld = '1') then
				events_out_sig_reg.ncts <= events_out_sig_ncts_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, events_out_sig_ncts_vld)
	begin
		if (rst = '1') then
			events_out_sig.ncts <= '0';
		elsif ((done_sig = '1') and (events_out_sig_ncts_vld = '1')) then
			events_out_sig.ncts <= events_out_sig_ncts_out;
		else
			events_out_sig.ncts <= events_out_sig_reg.ncts;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			events_out_sig_reg.rx_timeout <= '0';
		elsif (clk = '1' and clk'event) then
			if (events_out_sig_rx_timeout_vld = '1') then
				events_out_sig_reg.rx_timeout <= events_out_sig_rx_timeout_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, events_out_sig_rx_timeout_vld)
	begin
		if (rst = '1') then
			events_out_sig.rx_timeout <= '0';
		elsif ((done_sig = '1') and (events_out_sig_rx_timeout_vld = '1')) then
			events_out_sig.rx_timeout <= events_out_sig_rx_timeout_out;
		else
			events_out_sig.rx_timeout <= events_out_sig_reg.rx_timeout;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			events_out_sig_reg.rxd_ready <= '0';
		elsif (clk = '1' and clk'event) then
			if (events_out_sig_rxd_ready_vld = '1') then
				events_out_sig_reg.rxd_ready <= events_out_sig_rxd_ready_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, events_out_sig_rxd_ready_vld)
	begin
		if (rst = '1') then
			events_out_sig.rxd_ready <= '0';
		elsif ((done_sig = '1') and (events_out_sig_rxd_ready_vld = '1')) then
			events_out_sig.rxd_ready <= events_out_sig_rxd_ready_out;
		else
			events_out_sig.rxd_ready <= events_out_sig_reg.rxd_ready;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			events_out_sig_reg.txd_ready <= '0';
		elsif (clk = '1' and clk'event) then
			if (events_out_sig_txd_ready_vld = '1') then
				events_out_sig_reg.txd_ready <= events_out_sig_txd_ready_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, events_out_sig_txd_ready_vld)
	begin
		if (rst = '1') then
			events_out_sig.txd_ready <= '0';
		elsif ((done_sig = '1') and (events_out_sig_txd_ready_vld = '1')) then
			events_out_sig.txd_ready <= events_out_sig_txd_ready_out;
		else
			events_out_sig.txd_ready <= events_out_sig_reg.txd_ready;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			tx_config_out_sig_reg.odd_parity <= '0';
		elsif (clk = '1' and clk'event) then
			if (tx_config_out_sig_odd_parity_vld = '1') then
				tx_config_out_sig_reg.odd_parity <= tx_config_out_sig_odd_parity_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, tx_config_out_sig_odd_parity_vld)
	begin
		if (rst = '1') then
			tx_config_out_sig.odd_parity <= '0';
		elsif ((done_sig = '1') and (tx_config_out_sig_odd_parity_vld = '1')) then
			tx_config_out_sig.odd_parity <= tx_config_out_sig_odd_parity_out;
		else
			tx_config_out_sig.odd_parity <= tx_config_out_sig_reg.odd_parity;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			tx_config_out_sig_reg.parity <= '0';
		elsif (clk = '1' and clk'event) then
			if (tx_config_out_sig_parity_vld = '1') then
				tx_config_out_sig_reg.parity <= tx_config_out_sig_parity_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, tx_config_out_sig_parity_vld)
	begin
		if (rst = '1') then
			tx_config_out_sig.parity <= '0';
		elsif ((done_sig = '1') and (tx_config_out_sig_parity_vld = '1')) then
			tx_config_out_sig.parity <= tx_config_out_sig_parity_out;
		else
			tx_config_out_sig.parity <= tx_config_out_sig_reg.parity;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			tx_config_out_sig_reg.two_stop_bits <= '0';
		elsif (clk = '1' and clk'event) then
			if (tx_config_out_sig_two_stop_bits_vld = '1') then
				tx_config_out_sig_reg.two_stop_bits <= tx_config_out_sig_two_stop_bits_out;
			end if;
		end if;
	end process;

	process (clk, done_sig, tx_config_out_sig_two_stop_bits_vld)
	begin
		if (rst = '1') then
			tx_config_out_sig.two_stop_bits <= '0';
		elsif ((done_sig = '1') and (tx_config_out_sig_two_stop_bits_vld = '1')) then
			tx_config_out_sig.two_stop_bits <= tx_config_out_sig_two_stop_bits_out;
		else
			tx_config_out_sig.two_stop_bits <= tx_config_out_sig_reg.two_stop_bits;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			rts_out_sig_reg <= '0';
		elsif (clk = '1' and clk'event) then
			if (out_rts_internal_vld = '1') then
				rts_out_sig_reg <= out_rts_internal;
			end if;
		end if;
	end process;

	process (clk, done_sig, out_rts_internal_vld)
	begin
		if (rst = '1') then
			rts_out_sig <= '0';
		elsif ((done_sig = '1') and (out_rts_internal_vld = '1')) then
			rts_out_sig <= out_rts_internal;
		else
			rts_out_sig <= rts_out_sig_reg;
		end if;
	end process;

	process (clk, rst)
	begin
		if (rst = '1') then
			rx_active_out_sig_reg <= '0';
		elsif (clk = '1' and clk'event) then
			if (out_rx_active_out_msg_vld = '1') then
				rx_active_out_sig_reg <= out_rx_active_out_msg;
			end if;
		end if;
	end process;

	process (clk, done_sig, out_rx_active_out_msg_vld)
	begin
		if (rst = '1') then
			rx_active_out_sig <= '0';
		elsif ((done_sig = '1') and (out_rx_active_out_msg_vld = '1')) then
			rx_active_out_sig <= out_rx_active_out_msg;
		else
			rx_active_out_sig <= rx_active_out_sig_reg;
		end if;
	end process;

	-- Notify Processes
	process (clk, rst)
	begin
		if (rst = '1') then
			events_out_notify_reg <= '0';
		elsif (clk = '1' and clk'event) then
			if (events_out_notify_vld = '1') then
				events_out_notify_reg <= events_out_notify_out;
			end if;
		end if;
	end process;

	process (rst, done_sig, events_out_notify_vld)
	begin
		if (rst = '1') then
			events_out_notify <= '0';
		elsif (done_sig = '1') then
			if (events_out_notify_vld = '1') then
				events_out_notify <= events_out_notify_out;
			else
				events_out_notify <= events_out_notify_reg;
			end if;
		else
			events_out_notify <= '0';
		end if;
	end process;

	-- Internal Variables
	process (rst, out_tx_control_out_msg_cts_vld)
	begin
		if (rst = '1') then
			tx_control_out_msg.cts <= '1';
		elsif (out_tx_control_out_msg_cts_vld = '1') then
			tx_control_out_msg.cts <= out_tx_control_out_msg_cts;
		end if;
	end process;

	with out_rts_internal_vld select
		rts_internal <= in_rts_internal when '0',
			out_rts_internal when others;

	with out_error_src_vld select
		error_src <= in_error_src when '0',
			out_error_src when others;

	with out_frame_config_vld select
		frame_config <= in_frame_config when '0',
			out_frame_config when others;

	with out_enable_vld select
		enable <= in_enable when '0',
			out_enable when others;

	with out_tx_control_out_msg_active_vld select
		tx_control_out_msg.active <= in_tx_control_out_msg_active when '0',
			out_tx_control_out_msg_active when others;

	with out_rx_active_out_msg_vld select
		rx_active_out_msg <= in_rx_active_out_msg when '0',
			out_rx_active_out_msg when others;

	process(clk, rst)
	begin
		if (rst = '1') then
			in_rts_internal <= '0';
		elsif (clk = '1' and clk'event) then
			in_rts_internal <= rts_internal;
		end if;
	end process;

	process(clk, rst)
	begin
		if (rst = '1') then
			in_error_src <= x"00000000";
		elsif (clk = '1' and clk'event) then
			in_error_src <= error_src;
		end if;
	end process;

	process(clk, rst)
	begin
		if (rst = '1') then
			in_frame_config <= x"00000000";
		elsif (clk = '1' and clk'event) then
			in_frame_config <= frame_config;
		end if;
	end process;

	process(clk, rst)
	begin
		if (rst = '1') then
			in_enable <= x"00000000";
		elsif (clk = '1' and clk'event) then
			in_enable <= enable;
		end if;
	end process;

	process(clk, rst)
	begin
		if (rst = '1') then
			in_tx_control_out_msg_active <= '0';
		elsif (clk = '1' and clk'event) then
			in_tx_control_out_msg_active <= tx_control_out_msg.active;
		end if;
	end process;

	process(clk, rst)
	begin
		if (rst = '1') then
			in_rx_active_out_msg <= '0';
		elsif (clk = '1' and clk'event) then
			in_rx_active_out_msg <= rx_active_out_msg;
		end if;
	end process;

	-- Control process
	process (clk, rst)
	begin
		if (rst = '1') then
			start_sig <= '0';
			active_state <= st_IDLE_1;
		elsif (clk = '1' and clk'event) then
			if ((idle_sig = '1' or ready_sig = '1') and wait_state = '0') then
				start_sig <= '1';
				active_state <= next_state;
				active_operation_in <= active_operation;
				tx_events_in_sig_done_in <= tx_events_in_sig.done;
				rx_events_in_sig_timeout_in <= rx_events_in_sig.timeout;
				tasks_in_sig_start_rx_in <= tasks_in_sig.start_rx;
				tasks_in_sig_start_tx_in <= tasks_in_sig.start_tx;
				cts_in_sig_in <= cts_in_sig;
				bus_in_sig_addr_in <= bus_in_sig.addr;
				bus_in_sig_data_in <= bus_in_sig.data;
				bus_in_sig_trans_type_in <= bus_in_sig.trans_type;
				rx_events_in_sig_error_src_in <= rx_events_in_sig.error_src;
				rx_events_in_sig_ready_in <= rx_events_in_sig.ready;
				tasks_in_sig_stop_rx_in <= tasks_in_sig.stop_rx;
				tasks_in_sig_stop_tx_in <= tasks_in_sig.stop_tx;
			elsif ((idle_sig = '1' or  ready_sig = '1') and wait_state = '1') then
				start_sig <= '0';
			end if;
		end if;
	end process;

end Uart_control_arch;
