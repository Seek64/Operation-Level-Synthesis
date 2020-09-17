library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Uart_tx_operations;
use work.Uart_tx_types.all;

entity Uart_tx_module is
port(
	config_in_sig: in config_t;
	control_in_sig: in tx_control_t;
	data_in_sig: in data_t;
	txd_sig: out std_logic;
	data_in_notify_sig: out std_logic;
	events_out_sig: out tx_events_t;
	data_in_notify_notify: out std_logic;
	events_out_notify: out std_logic;
	txd_notify: out std_logic;
	txd_sync: in std_logic;
	clk: in std_logic;
	rst: in std_logic
);
end Uart_tx_module;

architecture Uart_tx_arch of Uart_tx_module is

	-- Internal Registers
	signal txd_bit: std_logic;
	signal data: std_logic_vector(31 downto 0);
	signal out_txd_bit: std_logic;
	signal out_data: std_logic_vector(31 downto 0);

	-- Operation Module Inputs
	signal config_in_sig_odd_parity_in: std_logic;
	signal data_in_sig_data_in: std_logic_vector(31 downto 0);
	signal active_operation_in: std_logic_vector(4 downto 0);

	-- Module Outputs
	signal data_in_notify_sig_out: std_logic;
	signal events_out_sig_done_out: std_logic;
	signal data_in_notify_notify_out: std_logic;
	signal events_out_notify_out: std_logic;
	signal txd_notify_out: std_logic;

	-- Monitor Signals
	signal next_state: Uart_tx_state_t;
	signal active_operation: Uart_tx_operation_t;
	signal active_state: Uart_tx_state_t;

	component Uart_tx_operations is
	port(
		ap_clk: in std_logic;
		ap_rst: in std_logic;
		config_in_sig_odd_parity: in std_logic;
		data_in_sig_data_V: in std_logic_vector(31 downto 0);
		data_in_notify_sig: out std_logic;
		events_out_sig_done: out std_logic;
		out_txd_bit: out std_logic;
		out_data_V: out std_logic_vector(31 downto 0);
		data_in_notify_notify: out std_logic;
		events_out_notify: out std_logic;
		txd_notify: out std_logic;
		active_operation: in std_logic_vector(4 downto 0)
	);
	end component;

begin

	operations_inst: Uart_tx_operations
	port map(
		ap_clk => clk,
		ap_rst => rst,
		config_in_sig_odd_parity => config_in_sig_odd_parity_in,
		data_in_sig_data_V => data_in_sig_data_in,
		data_in_notify_sig => data_in_notify_sig_out,
		events_out_sig_done => events_out_sig_done_out,
		out_txd_bit => out_txd_bit,
		out_data_V => out_data,
		data_in_notify_notify => data_in_notify_notify_out,
		events_out_notify => events_out_notify_out,
		txd_notify => txd_notify_out,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, txd_sync, data_in_sig.valid, control_in_sig.active, control_in_sig.cts, config_in_sig.parity, config_in_sig.two_stop_bits)
	begin
		case active_state is
		when st_IDLE_1 =>
			if ((data_in_sig.valid = '1') and (control_in_sig.active = '1') and not((control_in_sig.cts = '1'))) then 
				active_operation <= op_IDLE_1_1;
				next_state <= st_DATA_NOTIFY_2;
			elsif (not((control_in_sig.active = '1'))) then 
				active_operation <= op_IDLE_1_2;
				next_state <= st_IDLE_1;
			else
				active_operation <= op_IDLE_1_3;
				next_state <= st_IDLE_1;
			end if;
		when st_DATA_NOTIFY_2 =>
				active_operation <= op_DATA_NOTIFY_2_4;
				next_state <= st_TRANSMITTING_START_3;
		when st_TRANSMITTING_START_3 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_START_3_5;
				next_state <= st_TRANSMITTING_DATA_ZERO_4;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_DATA_ZERO_4 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_DATA_ZERO_4_6;
				next_state <= st_TRANSMITTING_DATA_ONE_5;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_DATA_ONE_5 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_DATA_ONE_5_7;
				next_state <= st_TRANSMITTING_DATA_TWO_6;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_DATA_TWO_6 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_DATA_TWO_6_8;
				next_state <= st_TRANSMITTING_DATA_THREE_7;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_DATA_THREE_7 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_DATA_THREE_7_9;
				next_state <= st_TRANSMITTING_DATA_FOUR_8;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_DATA_FOUR_8 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_DATA_FOUR_8_10;
				next_state <= st_TRANSMITTING_DATA_FIVE_9;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_DATA_FIVE_9 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_DATA_FIVE_9_11;
				next_state <= st_TRANSMITTING_DATA_SIX_10;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_DATA_SIX_10 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_DATA_SIX_10_12;
				next_state <= st_TRANSMITTING_DATA_SEVEN_11;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_DATA_SEVEN_11 =>
			if ((txd_sync = '1') and (config_in_sig.parity = '1')) then 
				active_operation <= op_TRANSMITTING_DATA_SEVEN_11_13;
				next_state <= st_TRANSMITTING_PARITY_12;
			elsif ((txd_sync = '1') and not((config_in_sig.parity = '1'))) then 
				active_operation <= op_TRANSMITTING_DATA_SEVEN_11_14;
				next_state <= st_TRANSMITTING_STOP_FIRST_13;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_PARITY_12 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_PARITY_12_15;
				next_state <= st_TRANSMITTING_STOP_FIRST_13;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_STOP_FIRST_13 =>
			if ((txd_sync = '1') and (config_in_sig.two_stop_bits = '1')) then 
				active_operation <= op_TRANSMITTING_STOP_FIRST_13_16;
				next_state <= st_TRANSMITTING_STOP_SECOND_14;
			elsif ((txd_sync = '1') and not((config_in_sig.two_stop_bits = '1'))) then 
				active_operation <= op_TRANSMITTING_STOP_FIRST_13_17;
				next_state <= st_STOP_NOTIFY_15;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_TRANSMITTING_STOP_SECOND_14 =>
			if ((txd_sync = '1')) then 
				active_operation <= op_TRANSMITTING_STOP_SECOND_14_18;
				next_state <= st_STOP_NOTIFY_15;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_STOP_NOTIFY_15 =>
				active_operation <= op_STOP_NOTIFY_15_19;
				next_state <= st_IDLE_1;
		end case;
	end process;


	-- Operation Module Outputs
	data_in_notify_sig <= data_in_notify_sig_out;
	events_out_sig.done <= events_out_sig_done_out;
	txd_bit <= out_txd_bit;
	data <= out_data;

	-- Output Register to Output Mapping
	txd_sig <= txd_bit;

	-- Notify Signals
	data_in_notify_notify <= data_in_notify_notify_out;
	events_out_notify <= events_out_notify_out;
	txd_notify <= txd_notify_out;

	-- Operation Module Inputs
	active_operation_in <= active_operation;
	config_in_sig_odd_parity_in <= config_in_sig.odd_parity;
	data_in_sig_data_in <= data_in_sig.data;

	-- Control process
	process (clk, rst)
	begin
		if (rst = '1') then
			active_state <= st_IDLE_1;
		elsif (clk = '1' and clk'event) then
			active_state <= next_state;
		end if;
	end process;

end Uart_tx_arch;
