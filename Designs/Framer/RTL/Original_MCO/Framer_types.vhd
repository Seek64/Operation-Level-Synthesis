-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Framer_types is

	 -- States
	type Framer_state_t is (st_state_1, st_state_2, st_state_3, st_state_4);

	-- Operations
	type Framer_operation_t is (op_state_1_1, op_state_1_10, op_state_1_3, op_state_1_5, op_state_1_7, op_state_2_11, op_state_2_13, op_state_2_15, op_state_2_17, op_state_2_19, op_state_2_21, op_state_2_24, op_state_3_25, op_state_3_27, op_state_3_29, op_state_3_31, op_state_3_33, op_state_3_35, op_state_3_38, op_state_4_39, op_state_4_41, op_state_4_43, op_state_4_45, op_state_4_47, op_state_4_49, op_state_4_52);

	-- Enum Types
	type Phases is (FIND_SYNC, INITIALISE, MISS, SEARCH, SYNC);

	-- Compound Types
	type marker_t is record
		isMarker: std_logic;
		markerAlignment: std_logic_vector(31 downto 0);
	end record;

	-- Array Types

	-- Constants
	constant FRM_PULSE_POS: std_logic_vector(31 downto 0) := x"00000000";
	constant WORDS_IN_FRAME: std_logic_vector(31 downto 0) := x"00000040";

end package Framer_types;