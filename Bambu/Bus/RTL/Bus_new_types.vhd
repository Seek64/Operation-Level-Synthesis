-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Bus_new_types is

	 -- States
	type Bus_new_state_t is (st_master_in_1, st_slave_out0_2, st_slave_in0_3, st_master_out_4, st_slave_out1_5, st_slave_in1_6, st_slave_out2_7, st_slave_in2_8, st_slave_out3_9, st_slave_in3_10);

	-- Operations
	subtype Bus_new_operation_t is std_logic_vector(31 downto 0);
	constant op_master_in_1_1 : Bus_new_operation_t := "00000000000000000000000000000000";
	constant op_master_in_1_10 : Bus_new_operation_t := "00000000000000000000000000000001";
	constant op_master_in_1_2 : Bus_new_operation_t := "00000000000000000000000000000010";
	constant op_master_in_1_3 : Bus_new_operation_t := "00000000000000000000000000000011";
	constant op_master_in_1_4 : Bus_new_operation_t := "00000000000000000000000000000100";
	constant op_master_in_1_5 : Bus_new_operation_t := "00000000000000000000000000000101";
	constant op_master_in_1_6 : Bus_new_operation_t := "00000000000000000000000000000110";
	constant op_master_in_1_7 : Bus_new_operation_t := "00000000000000000000000000000111";
	constant op_master_in_1_8 : Bus_new_operation_t := "00000000000000000000000000001000";
	constant op_master_in_1_9 : Bus_new_operation_t := "00000000000000000000000000001001";
	constant op_master_out_4_14 : Bus_new_operation_t := "00000000000000000000000000001010";
	constant op_slave_in0_3_12 : Bus_new_operation_t := "00000000000000000000000000001011";
	constant op_slave_in0_3_13 : Bus_new_operation_t := "00000000000000000000000000001100";
	constant op_slave_in1_6_16 : Bus_new_operation_t := "00000000000000000000000000001101";
	constant op_slave_in1_6_17 : Bus_new_operation_t := "00000000000000000000000000001110";
	constant op_slave_in2_8_19 : Bus_new_operation_t := "00000000000000000000000000001111";
	constant op_slave_in2_8_20 : Bus_new_operation_t := "00000000000000000000000000010000";
	constant op_slave_in3_10_22 : Bus_new_operation_t := "00000000000000000000000000010001";
	constant op_slave_in3_10_23 : Bus_new_operation_t := "00000000000000000000000000010010";
	constant op_slave_out0_2_11 : Bus_new_operation_t := "00000000000000000000000000010011";
	constant op_slave_out1_5_15 : Bus_new_operation_t := "00000000000000000000000000010100";
	constant op_slave_out2_7_18 : Bus_new_operation_t := "00000000000000000000000000010101";
	constant op_slave_out3_9_21 : Bus_new_operation_t := "00000000000000000000000000010110";
	constant op_state_wait : Bus_new_operation_t := "00000000000000000000000000010111";

	-- Enum Types
	subtype trans_t is std_logic_vector(0 downto 0);
	constant SINGLE_READ : trans_t := "0";
	constant SINGLE_WRITE : trans_t := "1";
	subtype ack_t is std_logic_vector(7 downto 0);
	constant ERR : ack_t := "00000000";
	constant OK : ack_t := "00000001";
	constant RTY : ack_t := "00000010";

	-- Compound Types
	type bus_req_t is record
		addr: std_logic_vector(31 downto 0);
		data: std_logic_vector(31 downto 0);
		trans_type: trans_t;
	end record;
	type bus_resp_t is record
		ack: ack_t;
		data: std_logic_vector(31 downto 0);
	end record;

end package Bus_new_types;