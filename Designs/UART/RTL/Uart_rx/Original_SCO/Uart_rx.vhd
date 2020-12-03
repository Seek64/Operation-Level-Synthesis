library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Uart_rx_operations;
use work.Uart_rx_types.all;

entity Uart_rx_module is
port(
	rxd_sig: in std_logic;
	control_active_in_sig: in std_logic;
	data_out_sync_sig: in std_logic;
	config_in_sig: in config_t;
	data_out_sig: out data_t;
	events_out_sig: out rx_events_t;
	events_out_notify: out std_logic;
	rxd_notify: out std_logic;
	rxd_sync: in std_logic;
	clk: in std_logic;
	rst: in std_logic
);
end Uart_rx_module;

architecture Uart_rx_arch of Uart_rx_module is

	-- Internal Registers
	signal parity: std_logic;
	signal timeout: std_logic;
	signal data_out_msg: data_t;
	signal wait_framing_break: std_logic;
	signal events_out_msg: rx_events_t;
	signal suspending_count: std_logic_vector(31 downto 0);
	signal first_stop_bit: std_logic;

	-- Operation Module Inputs
	signal rxd_sig_in: std_logic;
	signal active_operation_in: std_logic_vector(5 downto 0);

	-- Module Outputs
	signal events_out_sig_error_src_out: std_logic_vector(31 downto 0);
	signal events_out_sig_timeout_out: std_logic;
	signal events_out_sig_ready_out: std_logic;
	signal events_out_notify_out: std_logic;
	signal rxd_notify_out: std_logic;

	-- Monitor Signals
	signal next_state: Uart_rx_state_t;
	signal active_state: Uart_rx_state_t;
	signal active_operation: Uart_rx_operation_t;

	-- Functions
	function bool_to_sl(x : boolean) return std_logic;
	function parity_not_correct(data: std_logic_vector(31 downto 0); odd_parity: std_logic; parity_bit: std_logic) return std_logic;

	function bool_to_sl(x : boolean) return std_logic is
	begin
  	if x then
    	return '1';
  	else
    	return '0';
  	end if;
  end bool_to_sl;

	function parity_not_correct(data: std_logic_vector(31 downto 0); odd_parity: std_logic; parity_bit: std_logic) return std_logic is
	begin
		return bool_to_sl(bool_to_sl(odd_parity /= bool_to_sl(((((((((data and x"00000001") xor (std_logic_vector(shift_right(unsigned(data), 1)) and x"00000001")) xor (std_logic_vector(shift_right(unsigned(data), 2)) and x"00000001")) xor (std_logic_vector(shift_right(unsigned(data), 3)) and x"00000001")) xor (std_logic_vector(shift_right(unsigned(data), 4)) and x"00000001")) xor (std_logic_vector(shift_right(unsigned(data), 5)) and x"00000001")) xor (std_logic_vector(shift_right(unsigned(data), 6)) and x"00000001")) xor (std_logic_vector(shift_right(unsigned(data), 7)) and x"00000001")) = x"00000001")) /= parity_bit);
	end parity_not_correct;


	component Uart_rx_operations is
	port(
		ap_clk: in std_logic;
		ap_rst: in std_logic;
		rxd_sig: in std_logic;
		events_out_sig_error_src_V: out std_logic_vector(31 downto 0);
		events_out_sig_timeout: out std_logic;
		events_out_sig_ready: out std_logic;
		parity: out std_logic;
		data_out_msg_valid: out std_logic;
		timeout: out std_logic;
		data_out_msg_data_V: out std_logic_vector(31 downto 0);
		wait_framing_break: out std_logic;
		events_out_msg_ready: out std_logic;
		events_out_msg_timeout: out std_logic;
		events_out_msg_error_src_V: out std_logic_vector(31 downto 0);
		suspending_count_V: out std_logic_vector(31 downto 0);
		first_stop_bit: out std_logic;
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
		events_out_sig_error_src_V => events_out_sig_error_src_out,
		events_out_sig_timeout => events_out_sig_timeout_out,
		events_out_sig_ready => events_out_sig_ready_out,
		parity => parity,
		data_out_msg_valid => data_out_msg.valid,
		timeout => timeout,
		data_out_msg_data_V => data_out_msg.data,
		wait_framing_break => wait_framing_break,
		events_out_msg_ready => events_out_msg.ready,
		events_out_msg_timeout => events_out_msg.timeout,
		events_out_msg_error_src_V => events_out_msg.error_src,
		suspending_count_V => suspending_count,
		first_stop_bit => first_stop_bit,
		events_out_notify => events_out_notify_out,
		rxd_notify => rxd_notify_out,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, rxd_sync, rxd_sig, control_active_in_sig, data_out_sync_sig, config_in_sig.parity, config_in_sig.odd_parity, config_in_sig.two_stop_bits, parity, data_out_msg.valid, timeout, data_out_msg.data, wait_framing_break, suspending_count, first_stop_bit)
	begin
		case active_state is
		when st_IDLE_1 =>
			if (rxd_sync and control_active_in_sig and data_out_sync_sig and not(wait_framing_break) and not(rxd_sig)) = '1' then 
				active_operation <= op_IDLE_1_2;
				next_state <= st_GET_BIT_ZERO_2;
			elsif (rxd_sync and control_active_in_sig and data_out_sync_sig and not((not(wait_framing_break) and not(rxd_sig)))) = '1' then 
				active_operation <= op_IDLE_1_3;
				next_state <= st_IDLE_1;
			elsif (rxd_sync and control_active_in_sig and not(data_out_sync_sig) and not(wait_framing_break) and not(rxd_sig) and data_out_msg.valid) = '1' then 
				active_operation <= op_IDLE_1_5;
				next_state <= st_GET_BIT_ZERO_2;
			elsif (rxd_sync and control_active_in_sig and not(data_out_sync_sig) and not(wait_framing_break) and not(rxd_sig) and not(data_out_msg.valid)) = '1' then 
				active_operation <= op_IDLE_1_6;
				next_state <= st_GET_BIT_ZERO_2;
			elsif (rxd_sync and control_active_in_sig and not(data_out_sync_sig) and not((not(wait_framing_break) and not(rxd_sig)))) = '1' then 
				active_operation <= op_IDLE_1_7;
				next_state <= st_IDLE_1;
			elsif (rxd_sync and not(timeout) and not(control_active_in_sig) and data_out_sync_sig and not(wait_framing_break) and not(rxd_sig)) = '1' then 
				active_operation <= op_IDLE_1_10;
				next_state <= st_GET_BIT_ZERO_2;
			elsif (rxd_sync and not(timeout) and not(control_active_in_sig) and data_out_sync_sig and not((not(wait_framing_break) and not(rxd_sig)))) = '1' then 
				active_operation <= op_IDLE_1_11;
				next_state <= st_IDLE_1;
			elsif (rxd_sync and not(timeout) and not(control_active_in_sig) and not(data_out_sync_sig) and not(wait_framing_break) and not(rxd_sig) and data_out_msg.valid) = '1' then 
				active_operation <= op_IDLE_1_14;
				next_state <= st_GET_BIT_ZERO_2;
			elsif (rxd_sync and not(timeout) and not(control_active_in_sig) and not(data_out_sync_sig) and not(wait_framing_break) and not(rxd_sig) and not(data_out_msg.valid)) = '1' then 
				active_operation <= op_IDLE_1_15;
				next_state <= st_GET_BIT_ZERO_2;
			elsif (rxd_sync and not(timeout) and not(control_active_in_sig) and not(data_out_sync_sig) and not((not(wait_framing_break) and not(rxd_sig)))) = '1' then 
				active_operation <= op_IDLE_1_16;
				next_state <= st_IDLE_1;
			elsif (rxd_sync and timeout and not(control_active_in_sig)) = '1' then 
				active_operation <= op_IDLE_1_17;
				next_state <= st_IDLE_1;
			elsif (not(rxd_sync) and control_active_in_sig and data_out_sync_sig) = '1' then 
				active_operation <= op_IDLE_1_36;
				next_state <= st_IDLE_1;
			elsif (not(rxd_sync) and control_active_in_sig and not(data_out_sync_sig)) = '1' then 
				active_operation <= op_IDLE_1_39;
				next_state <= st_IDLE_1;
			elsif (not(rxd_sync) and not(timeout) and not(control_active_in_sig) and data_out_sync_sig and bool_to_sl(x"00000027" <= (x"00000001" + unsigned(suspending_count)))) = '1' then 
				active_operation <= op_IDLE_1_43;
				next_state <= st_IDLE_1;
			elsif (not(rxd_sync) and not(timeout) and not(control_active_in_sig) and data_out_sync_sig and not(bool_to_sl(x"00000027" <= (x"00000001" + unsigned(suspending_count))))) = '1' then 
				active_operation <= op_IDLE_1_44;
				next_state <= st_IDLE_1;
			elsif (not(rxd_sync) and not(timeout) and not(control_active_in_sig) and not(data_out_sync_sig) and bool_to_sl(x"00000027" <= (x"00000001" + unsigned(suspending_count)))) = '1' then 
				active_operation <= op_IDLE_1_47;
				next_state <= st_IDLE_1;
			elsif (not(rxd_sync) and not(timeout) and not(control_active_in_sig) and not(data_out_sync_sig) and not(bool_to_sl(x"00000027" <= (x"00000001" + unsigned(suspending_count))))) = '1' then 
				active_operation <= op_IDLE_1_48;
				next_state <= st_IDLE_1;
			else
				active_operation <= op_IDLE_1_52;
				next_state <= st_IDLE_1;
			end if;
		when st_GET_BIT_ZERO_2 =>
			if (rxd_sync) = '1' then 
				active_operation <= op_GET_BIT_ZERO_2_18;
				next_state <= st_GET_BIT_ONE_3;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_ONE_3 =>
			if (rxd_sync) = '1' then 
				active_operation <= op_GET_BIT_ONE_3_19;
				next_state <= st_GET_BIT_TWO_4;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_TWO_4 =>
			if (rxd_sync) = '1' then 
				active_operation <= op_GET_BIT_TWO_4_20;
				next_state <= st_GET_BIT_THREE_5;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_THREE_5 =>
			if (rxd_sync) = '1' then 
				active_operation <= op_GET_BIT_THREE_5_21;
				next_state <= st_GET_BIT_FOUR_6;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_FOUR_6 =>
			if (rxd_sync) = '1' then 
				active_operation <= op_GET_BIT_FOUR_6_22;
				next_state <= st_GET_BIT_FIVE_7;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_FIVE_7 =>
			if (rxd_sync) = '1' then 
				active_operation <= op_GET_BIT_FIVE_7_23;
				next_state <= st_GET_BIT_SIX_8;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_SIX_8 =>
			if (rxd_sync) = '1' then 
				active_operation <= op_GET_BIT_SIX_8_24;
				next_state <= st_GET_BIT_SEVEN_9;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_BIT_SEVEN_9 =>
			if (rxd_sync and config_in_sig.parity) = '1' then 
				active_operation <= op_GET_BIT_SEVEN_9_25;
				next_state <= st_GET_PARITY_BIT_10;
			elsif (rxd_sync and not(config_in_sig.parity)) = '1' then 
				active_operation <= op_GET_BIT_SEVEN_9_26;
				next_state <= st_GET_STOP_BIT_11;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_PARITY_BIT_10 =>
			if (rxd_sync and parity_not_correct(data_out_msg.data, config_in_sig.odd_parity, rxd_sig)) = '1' then 
				active_operation <= op_GET_PARITY_BIT_10_27;
				next_state <= st_GET_STOP_BIT_11;
			elsif (rxd_sync and not(parity_not_correct(data_out_msg.data, config_in_sig.odd_parity, rxd_sig))) = '1' then 
				active_operation <= op_GET_PARITY_BIT_10_28;
				next_state <= st_GET_STOP_BIT_11;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_STOP_BIT_11 =>
			if (rxd_sync and not(rxd_sig) and config_in_sig.two_stop_bits) = '1' then 
				active_operation <= op_GET_STOP_BIT_11_29;
				next_state <= st_GET_STOP_BIT_SECOND_12;
			elsif (rxd_sync and not(rxd_sig) and not(config_in_sig.two_stop_bits)) = '1' then 
				active_operation <= op_GET_STOP_BIT_11_30;
				next_state <= st_IDLE_1;
			elsif (rxd_sync and rxd_sig and config_in_sig.two_stop_bits) = '1' then 
				active_operation <= op_GET_STOP_BIT_11_31;
				next_state <= st_GET_STOP_BIT_SECOND_12;
			elsif (rxd_sync and rxd_sig and not(config_in_sig.two_stop_bits)) = '1' then 
				active_operation <= op_GET_STOP_BIT_11_32;
				next_state <= st_IDLE_1;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_GET_STOP_BIT_SECOND_12 =>
			if (rxd_sync and not(parity) and not(first_stop_bit) and not(rxd_sig) and bool_to_sl(data_out_msg.data = x"00000000")) = '1' then 
				active_operation <= op_GET_STOP_BIT_SECOND_12_33;
				next_state <= st_IDLE_1;
			elsif (rxd_sync and not(((not(parity) and not(first_stop_bit)) and bool_to_sl(data_out_msg.data = x"00000000"))) and not(rxd_sig)) = '1' then 
				active_operation <= op_GET_STOP_BIT_SECOND_12_34;
				next_state <= st_IDLE_1;
			elsif (rxd_sync and rxd_sig) = '1' then 
				active_operation <= op_GET_STOP_BIT_SECOND_12_35;
				next_state <= st_IDLE_1;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		end case;
	end process;


	-- Operation Module Outputs
	events_out_sig.error_src <= events_out_sig_error_src_out;
	events_out_sig.timeout <= events_out_sig_timeout_out;
	events_out_sig.ready <= events_out_sig_ready_out;

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
