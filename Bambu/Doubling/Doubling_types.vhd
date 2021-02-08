-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Doubling_types is

	 -- States
	type Doubling_state_t is (st_x_1, st_z_2);

	-- Operations
	subtype Doubling_operation_t is unsigned(31 downto 0);
	constant op_x_1_1 : Doubling_operation_t := "00000000000000000000000000000000";
	constant op_z_2_2 : Doubling_operation_t := "00000000000000000000000000000001";
	constant op_state_wait : Doubling_operation_t := "00000000000000000000000000000010";


end package Doubling_types;