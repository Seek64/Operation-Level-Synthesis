-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Uart_tx_types is

	 -- States
	type Uart_tx_state_t is (st_IDLE_1, st_DATA_NOTIFY_2, st_TRANSMITTING_START_3, st_TRANSMITTING_DATA_ZERO_4, st_TRANSMITTING_DATA_ONE_5, st_TRANSMITTING_DATA_TWO_6, st_TRANSMITTING_DATA_THREE_7, st_TRANSMITTING_DATA_FOUR_8, st_TRANSMITTING_DATA_FIVE_9, st_TRANSMITTING_DATA_SIX_10, st_TRANSMITTING_DATA_SEVEN_11, st_TRANSMITTING_PARITY_12, st_TRANSMITTING_STOP_FIRST_13, st_TRANSMITTING_STOP_SECOND_14, st_STOP_NOTIFY_15);

	-- Operations
	subtype Uart_tx_operation_t is std_logic_vector(4 downto 0);
	constant op_DATA_NOTIFY_2_4 : Uart_tx_operation_t := "00000";
	constant op_IDLE_1_1 : Uart_tx_operation_t := "00001";
	constant op_IDLE_1_2 : Uart_tx_operation_t := "00010";
	constant op_IDLE_1_3 : Uart_tx_operation_t := "00011";
	constant op_STOP_NOTIFY_15_19 : Uart_tx_operation_t := "00100";
	constant op_TRANSMITTING_DATA_FIVE_9_11 : Uart_tx_operation_t := "00101";
	constant op_TRANSMITTING_DATA_FOUR_8_10 : Uart_tx_operation_t := "00110";
	constant op_TRANSMITTING_DATA_ONE_5_7 : Uart_tx_operation_t := "00111";
	constant op_TRANSMITTING_DATA_SEVEN_11_13 : Uart_tx_operation_t := "01000";
	constant op_TRANSMITTING_DATA_SEVEN_11_14 : Uart_tx_operation_t := "01001";
	constant op_TRANSMITTING_DATA_SIX_10_12 : Uart_tx_operation_t := "01010";
	constant op_TRANSMITTING_DATA_THREE_7_9 : Uart_tx_operation_t := "01011";
	constant op_TRANSMITTING_DATA_TWO_6_8 : Uart_tx_operation_t := "01100";
	constant op_TRANSMITTING_DATA_ZERO_4_6 : Uart_tx_operation_t := "01101";
	constant op_TRANSMITTING_PARITY_12_15 : Uart_tx_operation_t := "01110";
	constant op_TRANSMITTING_START_3_5 : Uart_tx_operation_t := "01111";
	constant op_TRANSMITTING_STOP_FIRST_13_16 : Uart_tx_operation_t := "10000";
	constant op_TRANSMITTING_STOP_FIRST_13_17 : Uart_tx_operation_t := "10001";
	constant op_TRANSMITTING_STOP_SECOND_14_18 : Uart_tx_operation_t := "10010";
	constant op_state_wait : Uart_tx_operation_t := "10011";


	-- Compound Types
	type config_t is record
		odd_parity: std_logic;
		parity: std_logic;
		two_stop_bits: std_logic;
	end record;
	type tx_control_t is record
		active: std_logic;
		cts: std_logic;
	end record;
	type tx_events_t is record
		done: std_logic;
	end record;
	type data_t is record
		data: std_logic_vector(31 downto 0);
		valid: std_logic;
	end record;

end package Uart_tx_types;