library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Interconnect_operations;
use work.Interconnect_types.all;

entity Interconnect_module is
port(
	slave_in3_sig: in slave_signals;
	slave_in0_sig: in slave_signals;
	master_input_sig: in master_signals;
	slave_in1_sig: in slave_signals;
	slave_in2_sig: in slave_signals;
	master_output_sig: out slave_signals;
	slave_out0_sig: out master_signals;
	slave_out1_sig: out master_signals;
	slave_out2_sig: out master_signals;
	slave_out3_sig: out master_signals;
	clk: in std_logic;
	rst: in std_logic
);
end Interconnect_module;

architecture Interconnect_arch of Interconnect_module is

	-- Internal Registers
	signal from_master: master_signals;
	signal section: Sections;
	signal nextsection: Sections;
	signal slave_number: std_logic_vector(31 downto 0);
	signal to_master: slave_signals;

	-- Operation Module Inputs
	signal master_input_sig_cyc_in: std_logic;
	signal master_input_sig_data_in: std_logic_vector(31 downto 0);
	signal slave_in2_sig_ack_in: std_logic;
	signal slave_in2_sig_data_in: std_logic_vector(31 downto 0);
	signal slave_in2_sig_err_in: std_logic;
	signal slave_in3_sig_ack_in: std_logic;
	signal slave_in3_sig_data_in: std_logic_vector(31 downto 0);
	signal slave_in3_sig_err_in: std_logic;
	signal master_input_sig_addr_in: std_logic_vector(31 downto 0);
	signal slave_in0_sig_ack_in: std_logic;
	signal slave_in0_sig_data_in: std_logic_vector(31 downto 0);
	signal slave_in0_sig_err_in: std_logic;
	signal master_input_sig_stb_in: std_logic;
	signal master_input_sig_we_in: std_logic;
	signal slave_in1_sig_ack_in: std_logic;
	signal slave_in1_sig_data_in: std_logic_vector(31 downto 0);
	signal slave_in1_sig_err_in: std_logic;
	signal active_operation_in: std_logic_vector(3 downto 0);

	-- Module Outputs
	signal master_output_sig_ack_out: std_logic;
	signal master_output_sig_data_out: std_logic_vector(31 downto 0);
	signal master_output_sig_err_out: std_logic;
	signal slave_out0_sig_addr_out: std_logic_vector(31 downto 0);
	signal slave_out0_sig_cyc_out: std_logic;
	signal slave_out0_sig_data_out: std_logic_vector(31 downto 0);
	signal slave_out0_sig_stb_out: std_logic;
	signal slave_out0_sig_we_out: std_logic;
	signal slave_out1_sig_addr_out: std_logic_vector(31 downto 0);
	signal slave_out1_sig_cyc_out: std_logic;
	signal slave_out1_sig_data_out: std_logic_vector(31 downto 0);
	signal slave_out1_sig_stb_out: std_logic;
	signal slave_out1_sig_we_out: std_logic;
	signal slave_out2_sig_addr_out: std_logic_vector(31 downto 0);
	signal slave_out2_sig_cyc_out: std_logic;
	signal slave_out2_sig_data_out: std_logic_vector(31 downto 0);
	signal slave_out2_sig_stb_out: std_logic;
	signal slave_out2_sig_we_out: std_logic;
	signal slave_out3_sig_addr_out: std_logic_vector(31 downto 0);
	signal slave_out3_sig_cyc_out: std_logic;
	signal slave_out3_sig_data_out: std_logic_vector(31 downto 0);
	signal slave_out3_sig_stb_out: std_logic;
	signal slave_out3_sig_we_out: std_logic;

	-- Monitor Signals
	signal next_state: Interconnect_state_t;
	signal active_operation: Interconnect_operation_t;
	signal active_state: Interconnect_state_t;
	signal wait_state: std_logic;

	-- Functions
	function bool_to_sl(x : boolean) return std_logic;

	function bool_to_sl(x : boolean) return std_logic is
	begin
  	if x then
    	return '1';
  	else
    	return '0';
  	end if;
  end bool_to_sl;


	component Interconnect_operations is
	port(
		ap_clk: in std_logic;
		ap_rst: in std_logic;
		master_input_sig_cyc: in std_logic;
		master_input_sig_data_V: in std_logic_vector(31 downto 0);
		slave_in2_sig_ack: in std_logic;
		slave_in2_sig_data_V: in std_logic_vector(31 downto 0);
		slave_in2_sig_err: in std_logic;
		slave_in3_sig_ack: in std_logic;
		slave_in3_sig_data_V: in std_logic_vector(31 downto 0);
		slave_in3_sig_err: in std_logic;
		master_input_sig_addr_V: in std_logic_vector(31 downto 0);
		slave_in0_sig_ack: in std_logic;
		slave_in0_sig_data_V: in std_logic_vector(31 downto 0);
		slave_in0_sig_err: in std_logic;
		master_input_sig_stb: in std_logic;
		master_input_sig_we: in std_logic;
		slave_in1_sig_ack: in std_logic;
		slave_in1_sig_data_V: in std_logic_vector(31 downto 0);
		slave_in1_sig_err: in std_logic;
		master_output_sig_ack: out std_logic;
		master_output_sig_data_V: out std_logic_vector(31 downto 0);
		master_output_sig_err: out std_logic;
		slave_out0_sig_addr_V: out std_logic_vector(31 downto 0);
		slave_out0_sig_cyc: out std_logic;
		slave_out0_sig_data_V: out std_logic_vector(31 downto 0);
		slave_out0_sig_stb: out std_logic;
		slave_out0_sig_we: out std_logic;
		slave_out1_sig_addr_V: out std_logic_vector(31 downto 0);
		slave_out1_sig_cyc: out std_logic;
		slave_out1_sig_data_V: out std_logic_vector(31 downto 0);
		slave_out1_sig_stb: out std_logic;
		slave_out1_sig_we: out std_logic;
		slave_out2_sig_addr_V: out std_logic_vector(31 downto 0);
		slave_out2_sig_cyc: out std_logic;
		slave_out2_sig_data_V: out std_logic_vector(31 downto 0);
		slave_out2_sig_stb: out std_logic;
		slave_out2_sig_we: out std_logic;
		slave_out3_sig_addr_V: out std_logic_vector(31 downto 0);
		slave_out3_sig_cyc: out std_logic;
		slave_out3_sig_data_V: out std_logic_vector(31 downto 0);
		slave_out3_sig_stb: out std_logic;
		slave_out3_sig_we: out std_logic;
		from_master_addr_V: out std_logic_vector(31 downto 0);
		from_master_cyc: out std_logic;
		from_master_data_V: out std_logic_vector(31 downto 0);
		from_master_stb: out std_logic;
		from_master_we: out std_logic;
		section: out std_logic_vector(1 downto 0);
		nextsection: out std_logic_vector(1 downto 0);
		to_master_err: out std_logic;
		to_master_ack: out std_logic;
		slave_number_V: out std_logic_vector(31 downto 0);
		to_master_data_V: out std_logic_vector(31 downto 0);
		active_operation: in std_logic_vector(3 downto 0)
	);
	end component;

begin

	operations_inst: Interconnect_operations
	port map(
		ap_clk => clk,
		ap_rst => rst,
		master_input_sig_cyc => master_input_sig_cyc_in,
		master_input_sig_data_V => master_input_sig_data_in,
		slave_in2_sig_ack => slave_in2_sig_ack_in,
		slave_in2_sig_data_V => slave_in2_sig_data_in,
		slave_in2_sig_err => slave_in2_sig_err_in,
		slave_in3_sig_ack => slave_in3_sig_ack_in,
		slave_in3_sig_data_V => slave_in3_sig_data_in,
		slave_in3_sig_err => slave_in3_sig_err_in,
		master_input_sig_addr_V => master_input_sig_addr_in,
		slave_in0_sig_ack => slave_in0_sig_ack_in,
		slave_in0_sig_data_V => slave_in0_sig_data_in,
		slave_in0_sig_err => slave_in0_sig_err_in,
		master_input_sig_stb => master_input_sig_stb_in,
		master_input_sig_we => master_input_sig_we_in,
		slave_in1_sig_ack => slave_in1_sig_ack_in,
		slave_in1_sig_data_V => slave_in1_sig_data_in,
		slave_in1_sig_err => slave_in1_sig_err_in,
		master_output_sig_ack => master_output_sig_ack_out,
		master_output_sig_data_V => master_output_sig_data_out,
		master_output_sig_err => master_output_sig_err_out,
		slave_out0_sig_addr_V => slave_out0_sig_addr_out,
		slave_out0_sig_cyc => slave_out0_sig_cyc_out,
		slave_out0_sig_data_V => slave_out0_sig_data_out,
		slave_out0_sig_stb => slave_out0_sig_stb_out,
		slave_out0_sig_we => slave_out0_sig_we_out,
		slave_out1_sig_addr_V => slave_out1_sig_addr_out,
		slave_out1_sig_cyc => slave_out1_sig_cyc_out,
		slave_out1_sig_data_V => slave_out1_sig_data_out,
		slave_out1_sig_stb => slave_out1_sig_stb_out,
		slave_out1_sig_we => slave_out1_sig_we_out,
		slave_out2_sig_addr_V => slave_out2_sig_addr_out,
		slave_out2_sig_cyc => slave_out2_sig_cyc_out,
		slave_out2_sig_data_V => slave_out2_sig_data_out,
		slave_out2_sig_stb => slave_out2_sig_stb_out,
		slave_out2_sig_we => slave_out2_sig_we_out,
		slave_out3_sig_addr_V => slave_out3_sig_addr_out,
		slave_out3_sig_cyc => slave_out3_sig_cyc_out,
		slave_out3_sig_data_V => slave_out3_sig_data_out,
		slave_out3_sig_stb => slave_out3_sig_stb_out,
		slave_out3_sig_we => slave_out3_sig_we_out,
		from_master_addr_V => from_master.addr,
		from_master_cyc => from_master.cyc,
		from_master_data_V => from_master.data,
		from_master_stb => from_master.stb,
		from_master_we => from_master.we,
		section => section,
		nextsection => nextsection,
		to_master_err => to_master.err,
		to_master_ack => to_master.ack,
		slave_number_V => slave_number,
		to_master_data_V => to_master.data,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, master_input_sig.cyc, slave_in2_sig.ack, slave_in3_sig.ack, master_input_sig.addr, slave_in0_sig.ack, master_input_sig.stb, slave_in1_sig.ack, section, nextsection, slave_number)
	begin
		case active_state is
		when st_state_1 =>
			if (master_input_sig.cyc and master_input_sig.stb and not(bool_to_sl(section = START)) and not(bool_to_sl(section = TRANSMITTING)) and not(bool_to_sl(section = DONE)) and bool_to_sl(master_input_sig.addr >= x"00000000") and bool_to_sl(master_input_sig.addr <= x"00000007")) = '1' then 
				active_operation <= op_state_1_1;
				next_state <= st_state_2;
			elsif (master_input_sig.cyc and master_input_sig.stb and not(bool_to_sl(section = START)) and not(bool_to_sl(section = TRANSMITTING)) and not(bool_to_sl(section = DONE)) and bool_to_sl(master_input_sig.addr >= x"00000008") and bool_to_sl(master_input_sig.addr <= x"0000000f")) = '1' then 
				active_operation <= op_state_1_2;
				next_state <= st_state_2;
			elsif (master_input_sig.cyc and master_input_sig.stb and not(bool_to_sl(section = START)) and not(bool_to_sl(section = TRANSMITTING)) and not(bool_to_sl(section = DONE)) and bool_to_sl(master_input_sig.addr >= x"00000010") and bool_to_sl(master_input_sig.addr <= x"00000017")) = '1' then 
				active_operation <= op_state_1_3;
				next_state <= st_state_2;
			elsif (master_input_sig.cyc and master_input_sig.stb and not(bool_to_sl(section = START)) and not(bool_to_sl(section = TRANSMITTING)) and not(bool_to_sl(section = DONE)) and bool_to_sl(master_input_sig.addr >= x"00000018") and bool_to_sl(master_input_sig.addr <= x"0000001f")) = '1' then 
				active_operation <= op_state_1_4;
				next_state <= st_state_2;
			elsif (master_input_sig.cyc and master_input_sig.stb and not(bool_to_sl(section = START)) and not(bool_to_sl(section = TRANSMITTING)) and not(bool_to_sl(section = DONE)) and not((bool_to_sl(master_input_sig.addr >= x"00000000") and bool_to_sl(master_input_sig.addr <= x"00000007"))) and not((bool_to_sl(master_input_sig.addr >= x"00000008") and bool_to_sl(master_input_sig.addr <= x"0000000f"))) and not((bool_to_sl(master_input_sig.addr >= x"00000010") and bool_to_sl(master_input_sig.addr <= x"00000017"))) and not((bool_to_sl(master_input_sig.addr >= x"00000018") and bool_to_sl(master_input_sig.addr <= x"0000001f")))) = '1' then 
				active_operation <= op_state_1_5;
				next_state <= st_state_3;
			else
				active_operation <= op_state_1_6;
				next_state <= st_state_1;
			end if;
		when st_state_2 =>
			if (slave_in0_sig.ack and not(bool_to_sl(section = DONE)) and bool_to_sl(slave_number = x"00000000")) = '1' then 
				active_operation <= op_state_2_7;
				next_state <= st_state_3;
			elsif (not(slave_in0_sig.ack) and not(bool_to_sl(section = DONE)) and bool_to_sl(nextsection = TRANSMITTING) and bool_to_sl(slave_number = x"00000000")) = '1' then 
				active_operation <= op_state_2_8;
				next_state <= st_state_2;
			elsif (slave_in1_sig.ack and not(bool_to_sl(section = DONE)) and bool_to_sl(slave_number = x"00000001")) = '1' then 
				active_operation <= op_state_2_9;
				next_state <= st_state_3;
			elsif (not(slave_in1_sig.ack) and not(bool_to_sl(section = DONE)) and bool_to_sl(nextsection = TRANSMITTING) and bool_to_sl(slave_number = x"00000001")) = '1' then 
				active_operation <= op_state_2_10;
				next_state <= st_state_2;
			elsif (slave_in2_sig.ack and not(bool_to_sl(section = DONE)) and bool_to_sl(slave_number = x"00000002")) = '1' then 
				active_operation <= op_state_2_11;
				next_state <= st_state_3;
			elsif (not(slave_in2_sig.ack) and not(bool_to_sl(section = DONE)) and bool_to_sl(nextsection = TRANSMITTING) and bool_to_sl(slave_number = x"00000002")) = '1' then 
				active_operation <= op_state_2_12;
				next_state <= st_state_2;
			elsif (not(bool_to_sl(slave_number = x"00000000")) and not(bool_to_sl(slave_number = x"00000001")) and not(bool_to_sl(slave_number = x"00000002")) and slave_in3_sig.ack and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_state_2_13;
				next_state <= st_state_3;
			else
				active_operation <= op_state_2_14;
				next_state <= st_state_2;
			end if;
		when st_state_3 =>
			if (not(master_input_sig.cyc) and not(master_input_sig.stb)) = '1' then 
				active_operation <= op_state_3_15;
				next_state <= st_state_1;
			else
				active_operation <= op_state_3_16;
				next_state <= st_state_3;
			end if;
		end case;
	end process;


	-- Operation Module Outputs
	master_output_sig.ack <= master_output_sig_ack_out;
	master_output_sig.data <= master_output_sig_data_out;
	master_output_sig.err <= master_output_sig_err_out;
	slave_out0_sig.addr <= slave_out0_sig_addr_out;
	slave_out0_sig.cyc <= slave_out0_sig_cyc_out;
	slave_out0_sig.data <= slave_out0_sig_data_out;
	slave_out0_sig.stb <= slave_out0_sig_stb_out;
	slave_out0_sig.we <= slave_out0_sig_we_out;
	slave_out1_sig.addr <= slave_out1_sig_addr_out;
	slave_out1_sig.cyc <= slave_out1_sig_cyc_out;
	slave_out1_sig.data <= slave_out1_sig_data_out;
	slave_out1_sig.stb <= slave_out1_sig_stb_out;
	slave_out1_sig.we <= slave_out1_sig_we_out;
	slave_out2_sig.addr <= slave_out2_sig_addr_out;
	slave_out2_sig.cyc <= slave_out2_sig_cyc_out;
	slave_out2_sig.data <= slave_out2_sig_data_out;
	slave_out2_sig.stb <= slave_out2_sig_stb_out;
	slave_out2_sig.we <= slave_out2_sig_we_out;
	slave_out3_sig.addr <= slave_out3_sig_addr_out;
	slave_out3_sig.cyc <= slave_out3_sig_cyc_out;
	slave_out3_sig.data <= slave_out3_sig_data_out;
	slave_out3_sig.stb <= slave_out3_sig_stb_out;
	slave_out3_sig.we <= slave_out3_sig_we_out;

	-- Operation Module Inputs
	active_operation_in <= active_operation;
	master_input_sig_cyc_in <= master_input_sig.cyc;
	master_input_sig_data_in <= master_input_sig.data;
	slave_in2_sig_ack_in <= slave_in2_sig.ack;
	slave_in2_sig_data_in <= slave_in2_sig.data;
	slave_in2_sig_err_in <= slave_in2_sig.err;
	slave_in3_sig_ack_in <= slave_in3_sig.ack;
	slave_in3_sig_data_in <= slave_in3_sig.data;
	slave_in3_sig_err_in <= slave_in3_sig.err;
	master_input_sig_addr_in <= master_input_sig.addr;
	slave_in0_sig_ack_in <= slave_in0_sig.ack;
	slave_in0_sig_data_in <= slave_in0_sig.data;
	slave_in0_sig_err_in <= slave_in0_sig.err;
	master_input_sig_stb_in <= master_input_sig.stb;
	master_input_sig_we_in <= master_input_sig.we;
	slave_in1_sig_ack_in <= slave_in1_sig.ack;
	slave_in1_sig_data_in <= slave_in1_sig.data;
	slave_in1_sig_err_in <= slave_in1_sig.err;

	-- Control process
	process (clk, rst)
	begin
		if (rst = '1') then
			active_state <= st_state_1;
		elsif (clk = '1' and clk'event) then
			active_state <= next_state;
		end if;
	end process;

end Interconnect_arch;
