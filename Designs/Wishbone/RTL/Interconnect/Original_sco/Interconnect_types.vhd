-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Interconnect_types is

	 -- States
	type Interconnect_state_t is (st_state_1, st_state_2, st_state_3);

	-- Operations
	subtype Interconnect_operation_t is std_logic_vector(3 downto 0);
	constant op_state_1_1 : Interconnect_operation_t := "0000";
	constant op_state_1_2 : Interconnect_operation_t := "0001";
	constant op_state_1_3 : Interconnect_operation_t := "0010";
	constant op_state_1_4 : Interconnect_operation_t := "0011";
	constant op_state_1_5 : Interconnect_operation_t := "0100";
	constant op_state_1_6 : Interconnect_operation_t := "0101";
	constant op_state_2_10 : Interconnect_operation_t := "0110";
	constant op_state_2_11 : Interconnect_operation_t := "0111";
	constant op_state_2_12 : Interconnect_operation_t := "1000";
	constant op_state_2_13 : Interconnect_operation_t := "1001";
	constant op_state_2_14 : Interconnect_operation_t := "1010";
	constant op_state_2_7 : Interconnect_operation_t := "1011";
	constant op_state_2_8 : Interconnect_operation_t := "1100";
	constant op_state_2_9 : Interconnect_operation_t := "1101";
	constant op_state_3_15 : Interconnect_operation_t := "1110";
	constant op_state_3_16 : Interconnect_operation_t := "1111";

	-- Enum Types
	subtype Sections is std_logic_vector(1 downto 0);
	constant DONE : Sections := "00";
	constant IDLE : Sections := "01";
	constant START : Sections := "10";
	constant TRANSMITTING : Sections := "11";


	-- Compound Types
	type master_signals is record
		addr: std_logic_vector(31 downto 0);
		cyc: std_logic;
		data: std_logic_vector(31 downto 0);
		stb: std_logic;
		we: std_logic;
	end record;

	type slave_signals is record
		ack: std_logic;
		data: std_logic_vector(31 downto 0);
		err: std_logic;
	end record;


end package Interconnect_types;