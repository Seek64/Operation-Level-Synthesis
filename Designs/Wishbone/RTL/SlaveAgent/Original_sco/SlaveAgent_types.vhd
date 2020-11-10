-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package SlaveAgent_types is

	 -- States
	type SlaveAgent_state_t is (st_IDLE_1, st_state_2, st_state_3, st_state_4, st_state_5, st_DONE_6);

	-- Operations
	subtype SlaveAgent_operation_t is std_logic_vector(3 downto 0);
	constant op_DONE_6_10 : SlaveAgent_operation_t := "0000";
	constant op_DONE_6_8 : SlaveAgent_operation_t := "0001";
	constant op_DONE_6_9 : SlaveAgent_operation_t := "0010";
	constant op_IDLE_1_1 : SlaveAgent_operation_t := "0011";
	constant op_IDLE_1_2 : SlaveAgent_operation_t := "0100";
	constant op_IDLE_1_3 : SlaveAgent_operation_t := "0101";
	constant op_state_2_4 : SlaveAgent_operation_t := "0110";
	constant op_state_3_5 : SlaveAgent_operation_t := "0111";
	constant op_state_4_6 : SlaveAgent_operation_t := "1000";
	constant op_state_5_7 : SlaveAgent_operation_t := "1001";
	constant op_state_wait : SlaveAgent_operation_t := "1010";

	-- Enum Types
	subtype trans_t is std_logic_vector(0 downto 0);
	constant SINGLE_READ : trans_t := "0";
	constant SINGLE_WRITE : trans_t := "1";

	subtype Sections is std_logic_vector(1 downto 0);
	constant DONE : Sections := "00";
	constant IDLE : Sections := "01";
	constant READ : Sections := "10";
	constant WRITE : Sections := "11";

	subtype ack_t is std_logic_vector(1 downto 0);
	constant ERR : ack_t := "00";
	constant OK : ack_t := "01";
	constant RTY : ack_t := "10";


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

	type slave_signals is record
		ack: std_logic;
		data: std_logic_vector(31 downto 0);
		err: std_logic;
	end record;

	type master_signals is record
		addr: std_logic_vector(31 downto 0);
		cyc: std_logic;
		data: std_logic_vector(31 downto 0);
		stb: std_logic;
		we: std_logic;
	end record;


end package SlaveAgent_types;