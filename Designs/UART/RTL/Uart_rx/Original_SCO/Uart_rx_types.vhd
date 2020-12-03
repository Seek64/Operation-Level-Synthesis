-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Uart_rx_types is

	 -- States
	type Uart_rx_state_t is (st_IDLE_1, st_GET_BIT_ZERO_2, st_GET_BIT_ONE_3, st_GET_BIT_TWO_4, st_GET_BIT_THREE_5, st_GET_BIT_FOUR_6, st_GET_BIT_FIVE_7, st_GET_BIT_SIX_8, st_GET_BIT_SEVEN_9, st_GET_PARITY_BIT_10, st_GET_STOP_BIT_11, st_GET_STOP_BIT_SECOND_12);

	-- Operations
	subtype Uart_rx_operation_t is std_logic_vector(5 downto 0);
	constant op_GET_BIT_FIVE_7_23 : Uart_rx_operation_t := "000000";
	constant op_GET_BIT_FOUR_6_22 : Uart_rx_operation_t := "000001";
	constant op_GET_BIT_ONE_3_19 : Uart_rx_operation_t := "000010";
	constant op_GET_BIT_SEVEN_9_25 : Uart_rx_operation_t := "000011";
	constant op_GET_BIT_SEVEN_9_26 : Uart_rx_operation_t := "000100";
	constant op_GET_BIT_SIX_8_24 : Uart_rx_operation_t := "000101";
	constant op_GET_BIT_THREE_5_21 : Uart_rx_operation_t := "000110";
	constant op_GET_BIT_TWO_4_20 : Uart_rx_operation_t := "000111";
	constant op_GET_BIT_ZERO_2_18 : Uart_rx_operation_t := "001000";
	constant op_GET_PARITY_BIT_10_27 : Uart_rx_operation_t := "001001";
	constant op_GET_PARITY_BIT_10_28 : Uart_rx_operation_t := "001010";
	constant op_GET_STOP_BIT_11_29 : Uart_rx_operation_t := "001011";
	constant op_GET_STOP_BIT_11_30 : Uart_rx_operation_t := "001100";
	constant op_GET_STOP_BIT_11_31 : Uart_rx_operation_t := "001101";
	constant op_GET_STOP_BIT_11_32 : Uart_rx_operation_t := "001110";
	constant op_GET_STOP_BIT_SECOND_12_33 : Uart_rx_operation_t := "001111";
	constant op_GET_STOP_BIT_SECOND_12_34 : Uart_rx_operation_t := "010000";
	constant op_GET_STOP_BIT_SECOND_12_35 : Uart_rx_operation_t := "010001";
	constant op_IDLE_1_10 : Uart_rx_operation_t := "010010";
	constant op_IDLE_1_11 : Uart_rx_operation_t := "010011";
	constant op_IDLE_1_14 : Uart_rx_operation_t := "010100";
	constant op_IDLE_1_15 : Uart_rx_operation_t := "010101";
	constant op_IDLE_1_16 : Uart_rx_operation_t := "010110";
	constant op_IDLE_1_17 : Uart_rx_operation_t := "010111";
	constant op_IDLE_1_2 : Uart_rx_operation_t := "011000";
	constant op_IDLE_1_3 : Uart_rx_operation_t := "011001";
	constant op_IDLE_1_36 : Uart_rx_operation_t := "011010";
	constant op_IDLE_1_39 : Uart_rx_operation_t := "011011";
	constant op_IDLE_1_43 : Uart_rx_operation_t := "011100";
	constant op_IDLE_1_44 : Uart_rx_operation_t := "011101";
	constant op_IDLE_1_47 : Uart_rx_operation_t := "011110";
	constant op_IDLE_1_48 : Uart_rx_operation_t := "011111";
	constant op_IDLE_1_5 : Uart_rx_operation_t := "100000";
	constant op_IDLE_1_52 : Uart_rx_operation_t := "100001";
	constant op_IDLE_1_6 : Uart_rx_operation_t := "100010";
	constant op_IDLE_1_7 : Uart_rx_operation_t := "100011";
	constant op_state_wait : Uart_rx_operation_t := "100100";


	-- Compound Types
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

	type data_t is record
		data: std_logic_vector(31 downto 0);
		valid: std_logic;
	end record;


	-- Constants
	constant ERROR_OVERRUN_MASK: std_logic_vector(31 downto 0) := x"00000001";
	constant ERROR_PARITY_MASK: std_logic_vector(31 downto 0) := x"00000002";
	constant ERROR_FRAMING_MASK: std_logic_vector(31 downto 0) := x"00000004";
	constant ERROR_BREAK_MASK: std_logic_vector(31 downto 0) := x"00000008";

end package Uart_rx_types;