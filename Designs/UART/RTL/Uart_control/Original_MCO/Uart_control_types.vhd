-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Uart_control_types is

	 -- States
	type Uart_control_state_t is (st_IDLE_1);

	-- Operations
	subtype Uart_control_operation_t is std_logic_vector(5 downto 0);
	constant op_IDLE_1_1 : Uart_control_operation_t := "000000";
	constant op_IDLE_1_10 : Uart_control_operation_t := "000001";
	constant op_IDLE_1_11 : Uart_control_operation_t := "000010";
	constant op_IDLE_1_12 : Uart_control_operation_t := "000011";
	constant op_IDLE_1_13 : Uart_control_operation_t := "000100";
	constant op_IDLE_1_14 : Uart_control_operation_t := "000101";
	constant op_IDLE_1_15 : Uart_control_operation_t := "000110";
	constant op_IDLE_1_17 : Uart_control_operation_t := "000111";
	constant op_IDLE_1_18 : Uart_control_operation_t := "001000";
	constant op_IDLE_1_19 : Uart_control_operation_t := "001001";
	constant op_IDLE_1_2 : Uart_control_operation_t := "001010";
	constant op_IDLE_1_20 : Uart_control_operation_t := "001011";
	constant op_IDLE_1_21 : Uart_control_operation_t := "001100";
	constant op_IDLE_1_22 : Uart_control_operation_t := "001101";
	constant op_IDLE_1_23 : Uart_control_operation_t := "001110";
	constant op_IDLE_1_25 : Uart_control_operation_t := "001111";
	constant op_IDLE_1_26 : Uart_control_operation_t := "010000";
	constant op_IDLE_1_27 : Uart_control_operation_t := "010001";
	constant op_IDLE_1_28 : Uart_control_operation_t := "010010";
	constant op_IDLE_1_29 : Uart_control_operation_t := "010011";
	constant op_IDLE_1_3 : Uart_control_operation_t := "010100";
	constant op_IDLE_1_30 : Uart_control_operation_t := "010101";
	constant op_IDLE_1_31 : Uart_control_operation_t := "010110";
	constant op_IDLE_1_33 : Uart_control_operation_t := "010111";
	constant op_IDLE_1_34 : Uart_control_operation_t := "011000";
	constant op_IDLE_1_35 : Uart_control_operation_t := "011001";
	constant op_IDLE_1_36 : Uart_control_operation_t := "011010";
	constant op_IDLE_1_37 : Uart_control_operation_t := "011011";
	constant op_IDLE_1_38 : Uart_control_operation_t := "011100";
	constant op_IDLE_1_39 : Uart_control_operation_t := "011101";
	constant op_IDLE_1_4 : Uart_control_operation_t := "011110";
	constant op_IDLE_1_40 : Uart_control_operation_t := "011111";
	constant op_IDLE_1_41 : Uart_control_operation_t := "100000";
	constant op_IDLE_1_42 : Uart_control_operation_t := "100001";
	constant op_IDLE_1_43 : Uart_control_operation_t := "100010";
	constant op_IDLE_1_44 : Uart_control_operation_t := "100011";
	constant op_IDLE_1_45 : Uart_control_operation_t := "100100";
	constant op_IDLE_1_46 : Uart_control_operation_t := "100101";
	constant op_IDLE_1_47 : Uart_control_operation_t := "100110";
	constant op_IDLE_1_48 : Uart_control_operation_t := "100111";
	constant op_IDLE_1_49 : Uart_control_operation_t := "101000";
	constant op_IDLE_1_5 : Uart_control_operation_t := "101001";
	constant op_IDLE_1_50 : Uart_control_operation_t := "101010";
	constant op_IDLE_1_51 : Uart_control_operation_t := "101011";
	constant op_IDLE_1_52 : Uart_control_operation_t := "101100";
	constant op_IDLE_1_53 : Uart_control_operation_t := "101101";
	constant op_IDLE_1_54 : Uart_control_operation_t := "101110";
	constant op_IDLE_1_55 : Uart_control_operation_t := "101111";
	constant op_IDLE_1_56 : Uart_control_operation_t := "110000";
	constant op_IDLE_1_57 : Uart_control_operation_t := "110001";
	constant op_IDLE_1_58 : Uart_control_operation_t := "110010";
	constant op_IDLE_1_59 : Uart_control_operation_t := "110011";
	constant op_IDLE_1_6 : Uart_control_operation_t := "110100";
	constant op_IDLE_1_60 : Uart_control_operation_t := "110101";
	constant op_IDLE_1_61 : Uart_control_operation_t := "110110";
	constant op_IDLE_1_62 : Uart_control_operation_t := "110111";
	constant op_IDLE_1_63 : Uart_control_operation_t := "111000";
	constant op_IDLE_1_64 : Uart_control_operation_t := "111001";
	constant op_IDLE_1_7 : Uart_control_operation_t := "111010";
	constant op_IDLE_1_9 : Uart_control_operation_t := "111011";

	-- Enum Types
	subtype trans_t is std_logic_vector(0 downto 0);
	constant READ : trans_t := "0";
	constant WRITE : trans_t := "1";


	-- Compound Types
	type bus_req_t is record
		addr: std_logic_vector(31 downto 0);
		data: std_logic_vector(31 downto 0);
		trans_type: trans_t;
	end record;

	type tasks_t is record
		start_rx: std_logic;
		start_tx: std_logic;
		stop_rx: std_logic;
		stop_tx: std_logic;
	end record;

	type tx_events_t is record
		done: std_logic;
	end record;

	type config_t is record
		odd_parity: std_logic;
		parity: std_logic;
		two_stop_bits: std_logic;
	end record;

	type rx_events_t is record
		error_src: std_logic_vector(31 downto 0);
		ready: std_logic;
		timeout: std_logic;
	end record;

	type events_t is record
		cts: std_logic;
		error: std_logic;
		ncts: std_logic;
		rx_timeout: std_logic;
		rxd_ready: std_logic;
		txd_ready: std_logic;
	end record;

	type bus_resp_t is record
		data: std_logic_vector(31 downto 0);
		valid: std_logic;
	end record;

	type tx_control_t is record
		active: std_logic;
		cts: std_logic;
	end record;


	-- Constants
	constant ADDR_TASKS_START_RX: std_logic_vector(31 downto 0) := x"00000000";
	constant ADDR_TASKS_STOP_RX: std_logic_vector(31 downto 0) := x"00000004";
	constant ADDR_TASKS_START_TX: std_logic_vector(31 downto 0) := x"00000008";
	constant ADDR_TASKS_STOP_TX: std_logic_vector(31 downto 0) := x"0000000c";
	constant ADDR_ERROR_SRC: std_logic_vector(31 downto 0) := x"00000480";
	constant ADDR_ENABLE: std_logic_vector(31 downto 0) := x"00000500";
	constant ADDR_CONFIG: std_logic_vector(31 downto 0) := x"0000056c";
	constant CONFIG_STOP_MASK: std_logic_vector(31 downto 0) := x"00000010";
	constant CONFIG_HWFC_MASK: std_logic_vector(31 downto 0) := x"00000001";

end package Uart_control_types;