library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Uart_rx_operations;
use work.Uart_rx_types.all;

entity Uart_rx_module is
port(
	rxd_sig: in std_logic;
	config_in_sig: in config_t;
	data_out_sync_sig: in std_logic;
	control_active_in_sig: in std_logic;
	events_out_sig: out rx_events_t;
	data_out_sig: out data_t;
	events_out_notify: out std_logic;
	rxd_notify: out std_logic;
	rxd_sync: in std_logic;
	clk: in std_logic;
	rst: in std_logic
);
end Uart_rx_module;

architecture Uart_rx_arch of Uart_rx_module is

	-- Internal Registers
	signal suspending_count: std_logic_vector(31 downto 0);
	signal timeout: std_logic;
	signal parity: std_logic;
	signal first_stop_bit: std_logic;
	signal rx_bit: std_logic;
	signal data_out_msg: data_t;
	signal events_out_msg: rx_events_t;
	signal wait_framing_break: std_logic;
	signal out_suspending_count: std_logic_vector(31 downto 0);
	signal out_data_out_msg_valid: std_logic;
	signal out_events_out_msg_ready: std_logic;
	signal out_events_out_msg_error_src: std_logic_vector(31 downto 0);
	signal out_timeout: std_logic;
	signal out_parity: std_logic;
	signal out_first_stop_bit: std_logic;
	signal out_rx_bit: std_logic;
	signal out_data_out_msg_data: std_logic_vector(31 downto 0);
	signal out_events_out_msg_timeout: std_logic;
	signal out_wait_framing_break: std_logic;

	-- Operation Module Inputs
	signal rxd_sig_in: std_logic;
	signal active_operation_in: std_logic_vector(5 downto 0);

	-- Module Outputs
	signal events_out_sig_timeout_out: std_logic;
	signal events_out_sig_ready_out: std_logic;
	signal events_out_sig_error_src_out: std_logic_vector(31 downto 0);
	signal events_out_notify_out: std_logic;
	signal rxd_notify_out: std_logic;

	-- Monitor Signals
	signal active_operation: Uart_rx_operation_t;
	signal next_state: Uart_rx_state_t;
	signal active_state: Uart_rx_state_t;

	-- Functions
	function parity_not_correct(data: std_logic_vector(31 downto 0); odd_parity: std_logic; parity_bit: std_logic) return std_logic;

	function parity_not_correct(data: std_logic_vector(31 downto 0); odd_parity: std_logic; parity_bit: std_logic) return std_logic is
	begin
		return ((odd_parity xor ((((((((data(0) xor data(1)) xor data(2)) xor data(3)) xor data(4)) xor data(5)) xor data(6)) xor data(7)))) xor parity_bit);
	end parity_not_correct;


	component Uart_rx_operations is
	port(
		ap_clk: in std_logic;
		ap_rst: in std_logic;
		rxd_sig: in std_logic;
		events_out_sig_timeout: out std_logic;
		events_out_sig_ready: out std_logic;
		events_out_sig_error_src_V: out std_logic_vector(31 downto 0);
		out_suspending_count_V: out std_logic_vector(31 downto 0);
		out_data_out_msg_valid: out std_logic;
		out_events_out_msg_ready: out std_logic;
		out_events_out_msg_error_src_V: out std_logic_vector(31 downto 0);
		out_timeout: out std_logic;
		out_parity: out std_logic;
		out_first_stop_bit: out std_logic;
		out_rx_bit: out std_logic;
		out_data_out_msg_data_V: out std_logic_vector(31 downto 0);
		out_events_out_msg_timeout: out std_logic;
		out_wait_framing_break: out std_logic;
		events_out_notify: out std_logic;
		rxd_notify: out std_logic;
		active_operation: in std_logic_vector(5 downto 0)
	);
	end component;

begin

	operations_inst: Uart_rx_operations
	port map(
		ap_clk => clk,
		ap_rst => rst,
		rxd_sig => rxd_sig_in,
		events_out_sig_timeout => events_out_sig_timeout_out,
		events_out_sig_ready => events_out_sig_ready_out,
		events_out_sig_error_src_V => events_out_sig_error_src_out,
		out_suspending_count_V => out_suspending_count,
		out_data_out_msg_valid => out_data_out_msg_valid,
		out_events_out_msg_ready => out_events_out_msg_ready,
		out_events_out_msg_error_src_V => out_events_out_msg_error_src,
		out_timeout => out_timeout,
		out_parity => out_parity,
		out_first_stop_bit => out_first_stop_bit,
		out_rx_bit => out_rx_bit,
		out_data_out_msg_data_V => out_data_out_msg_data,
		out_events_out_msg_timeout => out_events_out_msg_timeout,
		out_wait_framing_break => out_wait_framing_break,
		events_out_notify => events_out_notify_out,
		rxd_notify => rxd_notify_out,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, rxd_sync, rxd_sig, config_in_sig.parity, config_in_sig.two_stop_bits, config_in_sig.odd_parity, data_out_sync_sig, control_active_in_sig, suspending_count, data_out_msg.valid, timeout, parity, first_stop_bit, rx_bit, data_out_msg.data, wait_framing_break)
	begin
		case active_state is
		when st_IDLE_1 =>
			if ((rxd_sync = '1') and (control_active_in_sig = '1') and (data_out_sync_sig = '1') and not((wait_framing_break = '1')) and not((rxd_sig = '1'))) then
				active_operation <= op_IDLE_1_2;
				next_state <= st_GET_BIT_ZERO_2;
			elsif ((rxd_sync = '1') and (control_active_in_sig = '1') and (data_out_sync_sig = '1') and not((not((wait_framing_break = '1')) and not((rxd_sig = '1'))))) then
				active_operation <= op_IDLE_1_3;
				next_state <= st_IDLE_1;
			elsif ((rxd_sync = '1') and (control_active_in_sig = '1') and not((data_out_sync_sig = '1')) and not((wait_framing_break = '1')) and not((rxd_sig = '1')) and (data_out_msg.valid = '1')) then
				active_operation <= op_IDLE_1_5;
				next_state <= st_GET_BIT_ZERO_2;
			elsif ((rxd_sync = '1') and (control_active_in_sig = '1') and not((data_out_sync_sig = '1')) and not((wait_framing_break = '1')) and not((rxd_sig = '1')) and not((data_out_msg.valid = '1'))) then
				active_operation <= op_IDLE_1_6;
				next_state <= st_GET_BIT_ZERO_2;
			elsif ((rxd_sync = '1') and (control_active_in_sig = '1') and not((data_out_sync_sig = '1')) and not((not((wait_framing_break = '1')) and not((rxd_sig = '1'))))) then
				active_operation <= op_IDLE_1_7;
				next_state <= st_IDLE_1;
			elsif ((rxd_sync = '1') and not((timeout = '1')) and not((control_active_in_sig = '1')) and (data_out_sync_sig = '1') and not((wait_framing_break = '1')) and not((rxd_sig = '1'))) then
				active_operation <= op_IDLE_1_10;
				next_state <= st_GET_BIT_ZERO_2;
			elsif ((rxd_sync = '1') and not((timeout = '1')) and not((control_active_in_sig = '1')) and (data_out_sync_sig = '1') and not((not((wait_framing_break = '1')) and not((rxd_sig = '1'))))) then
				active_operation <= op_IDLE_1_11;
				next_state <= st_IDLE_1;
			elsif ((rxd_sync = '1') and not((timeout = '1')) and not((control_active_in_sig = '1')) and not((data_out_sync_sig = '1')) and not((wait_framing_break = '1')) and not((rxd_sig = '1')) and (data_out_msg.valid = '1')) then
				active_operation <= op_IDLE_1_14;
				next_state <= st_GET_BIT_ZERO_2;
			elsif ((rxd_sync = '1') and not((timeout = '1')) and not((control_active_in_sig = '1')) and not((data_out_sync_sig = '1')) and not((wait_framing_break = '1')) and not((rxd_sig = '1')) and not((data_out_msg.valid = '1'))) then
				active_operation <= op_IDLE_1_15;
				next_state <= st_GET_BIT_ZERO_2;
			elsif ((rxd_sync = '1') and not((timeout = '1')) and not((control_active_in_sig = '1')) and not((data_out_sync_sig = '1')) and not((not((wait_framing_break = '1')) and not((rxd_sig = '1'))))) then
				active_operation <= op_IDLE_1_16;
				next_state <= st_IDLE_1;
			elsif ((rxd_sync = '1') and (timeout = '1') and not((control_active_in_sig = '1'))) then
				active_operation <= op_IDLE_1_17;
				next_state <= st_IDLE_1;
			elsif (not((rxd_sync = '1')) and (control_active_in_sig = '1') and (data_out_sync_sig = '1')) then
				active_operation <= op_IDLE_1_33;
				next_state <= st_IDLE_1;
			elsif (not((rxd_sync = '1')) and (control_active_in_sig = '1') and not((data_out_sync_sig = '1'))) then
				active_operation <= op_IDLE_1_36;
				next_state <= st_IDLE_1;
			elsif (not((rxd_sync = '1')) and not((timeout = '1')) and not((control_active_in_sig = '1')) and (data_out_sync_sig = '1') and (x"00000027" <= ((not((rx_bit = '1')) and not((wait_framing_break = '1'))))?(x"0000000b" + unsigned(suspending_count)):(x"00000001" + unsigned(suspending_count)))) then
				active_operation <= op_IDLE_1_40;
				next_state <= st_IDLE_1;
			elsif (not((rxd_sync = '1')) and not((timeout = '1')) and not((control_active_in_sig = '1')) and (data_out_sync_sig = '1') and not((x"00000027" <= ((not((rx_bit = '1')) and not((wait_framing_break = '1'))))?(x"0000000b" + unsigned(suspending_count)):(x"00000001" + unsigned(suspending_count))))) then
				active_operation <= op_IDLE_1_41;
				next_state <= st_IDLE_1;
			elsif (not((rxd_sync = '1')) and not((timeout = '1')) and not((control_active_in_sig = '1')) and not((data_out_sync_sig = '1')) and (x"00000027" <= ((not((rx_bit = '1')) and not((wait_framing_break = '1'))))?(x"0000000b" + unsigned(suspending_count)):(x"00000001" + unsigned(suspending_count)))) then
				active_operation <= op_IDLE_1_44;
				next_state <= st_IDLE_1;
			elsif (not((rxd_sync = '1')) and not((timeout = '1')) and not((control_active_in_sig = '1')) and not((data_out_sync_sig = '1')) and not((x"00000027" <= ((not((rx_bit = '1')) and not((wait_framing_break = '1'))))?(x"0000000b" + unsigned(suspending_count)):(x"00000001" + unsigned(suspending_count))))) then
				active_operation <= op_IDLE_1_45;
				next_state <= st_IDLE_1;
			else
				active_operation <= op_IDLE_1_49;
				next_state <= st_IDLE_1;
			end if;
		when st_GET_BIT_ZERO_2 =>
			if ((rxd_sync = '1')) then
				active_operation <= op_GET_BIT_ZERO_2_18;
				next_state <= st_GET_BIT_ONE_3;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_ONE_3 =>
			if ((rxd_sync = '1')) then
				active_operation <= op_GET_BIT_ONE_3_19;
				next_state <= st_GET_BIT_TWO_4;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_TWO_4 =>
			if ((rxd_sync = '1')) then
				active_operation <= op_GET_BIT_TWO_4_20;
				next_state <= st_GET_BIT_THREE_5;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_THREE_5 =>
			if ((rxd_sync = '1')) then
				active_operation <= op_GET_BIT_THREE_5_21;
				next_state <= st_GET_BIT_FOUR_6;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_FOUR_6 =>
			if ((rxd_sync = '1')) then
				active_operation <= op_GET_BIT_FOUR_6_22;
				next_state <= st_GET_BIT_FIVE_7;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_FIVE_7 =>
			if ((rxd_sync = '1')) then
				active_operation <= op_GET_BIT_FIVE_7_23;
				next_state <= st_GET_BIT_SIX_8;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_SIX_8 =>
			if ((rxd_sync = '1')) then
				active_operation <= op_GET_BIT_SIX_8_24;
				next_state <= st_GET_BIT_SEVEN_9;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_SEVEN_9 =>
			if ((rxd_sync = '1') and (config_in_sig.parity = '1')) then
				active_operation <= op_GET_BIT_SEVEN_9_25;
				next_state <= st_GET_PARITY_BIT_10;
			elsif ((rxd_sync = '1') and not((config_in_sig.parity = '1'))) then
				active_operation <= op_GET_BIT_SEVEN_9_26;
				next_state <= st_GET_STOP_BIT_11;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_PARITY_BIT_10 =>
			if ((rxd_sync = '1') and parity_not_correct(data_out_msg.data, (config_in_sig.odd_parity = '1'), (rxd_sig = '1'))) then
				active_operation <= op_GET_PARITY_BIT_10_27;
				next_state <= st_GET_STOP_BIT_11;
			elsif ((rxd_sync = '1') and not(parity_not_correct(data_out_msg.data, (config_in_sig.odd_parity = '1'), (rxd_sig = '1')))) then
				active_operation <= op_GET_PARITY_BIT_10_28;
				next_state <= st_GET_STOP_BIT_11;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_STOP_BIT_11 =>
			if ((rxd_sync = '1') and not((rxd_sig = '1')) and (config_in_sig.two_stop_bits = '1')) then
				active_operation <= op_GET_STOP_BIT_11_29;
				next_state <= st_GET_STOP_BIT_SECOND_12;
			elsif ((rxd_sync = '1') and not((rxd_sig = '1')) and not((config_in_sig.two_stop_bits = '1'))) then
				active_operation <= op_GET_STOP_BIT_11_30;
				next_state <= st_IDLE_1;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_STOP_BIT_SECOND_12 =>
			if ((rxd_sync = '1') and not((parity = '1')) and not((first_stop_bit = '1')) and not((rxd_sig = '1')) and (data_out_msg.data = x"00000000")) then
				active_operation <= op_GET_STOP_BIT_SECOND_12_31;
				next_state <= st_IDLE_1;
			elsif ((rxd_sync = '1') and not(((not((parity = '1')) and not((first_stop_bit = '1'))) and (data_out_msg.data = x"00000000"))) and not((rxd_sig = '1'))) then
				active_operation <= op_GET_STOP_BIT_SECOND_12_32;
				next_state <= st_IDLE_1;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		end case;
	end process;


	-- Operation Module Outputs
	events_out_sig.timeout <= events_out_sig_timeout_out;
	events_out_sig.ready <= events_out_sig_ready_out;
	events_out_sig.error_src <= events_out_sig_error_src_out;
	suspending_count <= out_suspending_count;
	data_out_msg.valid <= out_data_out_msg_valid;
	events_out_msg.ready <= out_events_out_msg_ready;
	events_out_msg.error_src <= out_events_out_msg_error_src;
	timeout <= out_timeout;
	parity <= out_parity;
	first_stop_bit <= out_first_stop_bit;
	rx_bit <= out_rx_bit;
	data_out_msg.data <= out_data_out_msg_data;
	events_out_msg.timeout <= out_events_out_msg_timeout;
	wait_framing_break <= out_wait_framing_break;

	-- Output Register to Output Mapping
	data_out_sig <= data_out_msg;

	-- Notify Signals
	events_out_notify <= events_out_notify_out;
	rxd_notify <= rxd_notify_out;

	-- Operation Module Inputs
	active_operation_in <= active_operation;
	rxd_sig_in <= rxd_sig;

	-- Control process
	process (clk, rst)
	begin
		if (rst = '1') then
			active_state <= st_IDLE_1;
		elsif (clk = '1' and clk'event) then
			active_state <= next_state;
		end if;
	end process;

end Uart_rx_arch;
