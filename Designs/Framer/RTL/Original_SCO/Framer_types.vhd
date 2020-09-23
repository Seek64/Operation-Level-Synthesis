-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Framer_types is

	 -- States
	type Framer_state_t is (st_state_1, st_state_2, st_state_3, st_state_4);

	-- Operations
	subtype Framer_operation_t is std_logic_vector(4 downto 0);
	constant op_state_1_1 : Framer_operation_t := "00000";
	constant op_state_1_10 : Framer_operation_t := "00001";
	constant op_state_1_3 : Framer_operation_t := "00010";
	constant op_state_1_5 : Framer_operation_t := "00011";
	constant op_state_1_7 : Framer_operation_t := "00100";
	constant op_state_2_11 : Framer_operation_t := "00101";
	constant op_state_2_13 : Framer_operation_t := "00110";
	constant op_state_2_15 : Framer_operation_t := "00111";
	constant op_state_2_17 : Framer_operation_t := "01000";
	constant op_state_2_19 : Framer_operation_t := "01001";
	constant op_state_2_21 : Framer_operation_t := "01010";
	constant op_state_2_24 : Framer_operation_t := "01011";
	constant op_state_3_25 : Framer_operation_t := "01100";
	constant op_state_3_27 : Framer_operation_t := "01101";
	constant op_state_3_29 : Framer_operation_t := "01110";
	constant op_state_3_31 : Framer_operation_t := "01111";
	constant op_state_3_33 : Framer_operation_t := "10000";
	constant op_state_3_35 : Framer_operation_t := "10001";
	constant op_state_3_38 : Framer_operation_t := "10010";
	constant op_state_4_39 : Framer_operation_t := "10011";
	constant op_state_4_41 : Framer_operation_t := "10100";
	constant op_state_4_43 : Framer_operation_t := "10101";
	constant op_state_4_45 : Framer_operation_t := "10110";
	constant op_state_4_47 : Framer_operation_t := "10111";
	constant op_state_4_49 : Framer_operation_t := "11000";
	constant op_state_4_52 : Framer_operation_t := "11001";

	-- Enum Types
	subtype Phases is std_logic_vector(2 downto 0);
	constant FIND_SYNC : Phases := "000";
	constant INITIALISE : Phases := "001";
	constant MISS : Phases := "010";
	constant SEARCH : Phases := "011";
	constant SYNC : Phases := "100";

	-- Compound Types
	type marker_t is record
		isMarker: std_logic;
		markerAlignment: std_logic_vector(31 downto 0);
	end record;

	-- Constants
	constant FRM_PULSE_POS: std_logic_vector(31 downto 0) := x"00000000";
	constant WORDS_IN_FRAME: std_logic_vector(31 downto 0) := x"00000040";

end package Framer_types;