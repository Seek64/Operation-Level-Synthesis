-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ADDING_types is

	 -- States
	type ADDING_state_t is (st_x_1, st_z_2);

	-- Operations
	subtype ADDING_operation_t is unsigned(31 downto 0);
	constant op_x_1_1 : ADDING_operation_t := "00000000000000000000000000000000";
	constant op_z_2_2 : ADDING_operation_t := "00000000000000000000000000000001";
	constant op_state_wait : ADDING_operation_t := "00000000000000000000000000000010";


end package ADDING_types;