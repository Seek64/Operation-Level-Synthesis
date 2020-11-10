library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.SlaveAgent_operations;
use work.SlaveAgent_types.all;

entity SlaveAgent_module is
port(
	slave_to_agent_sig: in bus_resp_t;
	bus_to_agent_sig: in master_signals;
	agent_to_bus_sig: out slave_signals;
	agent_to_slave_sig: out bus_req_t;
	agent_to_slave_notify: out std_logic;
	slave_to_agent_notify: out std_logic;
	agent_to_slave_sync: in std_logic;
	slave_to_agent_sync: in std_logic;
	rst: in std_logic;
	clk: in std_logic
);
end SlaveAgent_module;

architecture SlaveAgent_arch of SlaveAgent_module is

	-- Internal Registers
	signal section: Sections;
	signal nextsection: Sections;
	signal slave_to_agent_resp: bus_resp_t;

	-- Operation Module Inputs
	signal slave_to_agent_sig_ack_in: std_logic_vector(1 downto 0);
	signal slave_to_agent_sig_data_in: std_logic_vector(31 downto 0);
	signal bus_to_agent_sig_addr_in: std_logic_vector(31 downto 0);
	signal bus_to_agent_sig_data_in: std_logic_vector(31 downto 0);
	signal active_operation_in: std_logic_vector(3 downto 0);

	-- Module Outputs
	signal agent_to_slave_sig_addr_out: std_logic_vector(31 downto 0);
	signal agent_to_slave_sig_data_out: std_logic_vector(31 downto 0);
	signal agent_to_slave_sig_trans_type_out: std_logic_vector(0 downto 0);
	signal agent_to_bus_sig_ack_out: std_logic;
	signal agent_to_bus_sig_data_out: std_logic_vector(31 downto 0);
	signal agent_to_bus_sig_err_out: std_logic;
	signal agent_to_slave_notify_out: std_logic;
	signal slave_to_agent_notify_out: std_logic;

	-- Monitor Signals
	signal next_state: SlaveAgent_state_t;
	signal active_state: SlaveAgent_state_t;
	signal wait_state: std_logic;
	signal active_operation: SlaveAgent_operation_t;

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


	component SlaveAgent_operations is
	port(
		ap_rst: in std_logic;
		ap_clk: in std_logic;
		slave_to_agent_sig_ack: in std_logic_vector(1 downto 0);
		slave_to_agent_sig_data_V: in std_logic_vector(31 downto 0);
		bus_to_agent_sig_addr_V: in std_logic_vector(31 downto 0);
		bus_to_agent_sig_data_V: in std_logic_vector(31 downto 0);
		agent_to_slave_sig_addr_V: out std_logic_vector(31 downto 0);
		agent_to_slave_sig_data_V: out std_logic_vector(31 downto 0);
		agent_to_slave_sig_trans_type: out std_logic_vector(0 downto 0);
		agent_to_bus_sig_ack: out std_logic;
		agent_to_bus_sig_data_V: out std_logic_vector(31 downto 0);
		agent_to_bus_sig_err: out std_logic;
		section: out std_logic_vector(1 downto 0);
		nextsection: out std_logic_vector(1 downto 0);
		slave_to_agent_resp_data_V: out std_logic_vector(31 downto 0);
		slave_to_agent_resp_ack: out std_logic_vector(1 downto 0);
		agent_to_slave_notify: out std_logic;
		slave_to_agent_notify: out std_logic;
		active_operation: in std_logic_vector(3 downto 0)
	);
	end component;

begin

	operations_inst: SlaveAgent_operations
	port map(
		ap_rst => rst,
		ap_clk => clk,
		slave_to_agent_sig_ack => slave_to_agent_sig_ack_in,
		slave_to_agent_sig_data_V => slave_to_agent_sig_data_in,
		bus_to_agent_sig_addr_V => bus_to_agent_sig_addr_in,
		bus_to_agent_sig_data_V => bus_to_agent_sig_data_in,
		agent_to_slave_sig_addr_V => agent_to_slave_sig_addr_out,
		agent_to_slave_sig_data_V => agent_to_slave_sig_data_out,
		agent_to_slave_sig_trans_type => agent_to_slave_sig_trans_type_out,
		agent_to_bus_sig_ack => agent_to_bus_sig_ack_out,
		agent_to_bus_sig_data_V => agent_to_bus_sig_data_out,
		agent_to_bus_sig_err => agent_to_bus_sig_err_out,
		section => section,
		nextsection => nextsection,
		slave_to_agent_resp_data_V => slave_to_agent_resp.data,
		slave_to_agent_resp_ack => slave_to_agent_resp.ack,
		agent_to_slave_notify => agent_to_slave_notify_out,
		slave_to_agent_notify => slave_to_agent_notify_out,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, slave_to_agent_sync, agent_to_slave_sync, bus_to_agent_sig.cyc, bus_to_agent_sig.stb, bus_to_agent_sig.we, section, nextsection)
	begin
		case active_state is
		when st_IDLE_1 =>
			if (bus_to_agent_sig.cyc and bus_to_agent_sig.stb and not(bus_to_agent_sig.we) and not(bool_to_sl(section = READ)) and not(bool_to_sl(section = WRITE)) and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_IDLE_1_1;
				next_state <= st_state_2;
			elsif (bus_to_agent_sig.cyc and bus_to_agent_sig.stb and bus_to_agent_sig.we and not(bool_to_sl(section = READ)) and not(bool_to_sl(section = WRITE)) and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_IDLE_1_2;
				next_state <= st_state_4;
			else
				active_operation <= op_IDLE_1_3;
				next_state <= st_IDLE_1;
			end if;
		when st_state_2 =>
			if (agent_to_slave_sync) = '1' then 
				active_operation <= op_state_2_4;
				next_state <= st_state_3;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_state_3 =>
			if (slave_to_agent_sync and not(bool_to_sl(section = WRITE)) and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_state_3_5;
				next_state <= st_DONE_6;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_state_4 =>
			if (agent_to_slave_sync) = '1' then 
				active_operation <= op_state_4_6;
				next_state <= st_state_5;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_state_5 =>
			if (slave_to_agent_sync and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_state_5_7;
				next_state <= st_DONE_6;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_DONE_6 =>
			if (not(bus_to_agent_sig.cyc) and not(bus_to_agent_sig.stb)) = '1' then 
				active_operation <= op_DONE_6_8;
				next_state <= st_IDLE_1;
			elsif (not((not(bus_to_agent_sig.cyc) and not(bus_to_agent_sig.stb))) and not(bus_to_agent_sig.we) and bool_to_sl(nextsection = DONE)) = '1' then 
				active_operation <= op_DONE_6_9;
				next_state <= st_DONE_6;
			else
				active_operation <= op_DONE_6_10;
				next_state <= st_DONE_6;
			end if;
		end case;
	end process;


	-- Operation Module Outputs
	agent_to_slave_sig.addr <= agent_to_slave_sig_addr_out;
	agent_to_slave_sig.data <= agent_to_slave_sig_data_out;
	agent_to_slave_sig.trans_type <= agent_to_slave_sig_trans_type_out;
	agent_to_bus_sig.ack <= agent_to_bus_sig_ack_out;
	agent_to_bus_sig.data <= agent_to_bus_sig_data_out;
	agent_to_bus_sig.err <= agent_to_bus_sig_err_out;

	-- Notify Signals
	agent_to_slave_notify <= agent_to_slave_notify_out;
	slave_to_agent_notify <= slave_to_agent_notify_out;

	-- Operation Module Inputs
	active_operation_in <= active_operation;
	slave_to_agent_sig_ack_in <= slave_to_agent_sig.ack;
	slave_to_agent_sig_data_in <= slave_to_agent_sig.data;
	bus_to_agent_sig_addr_in <= bus_to_agent_sig.addr;
	bus_to_agent_sig_data_in <= bus_to_agent_sig.data;

	-- Control process
	process (clk, rst)
	begin
		if (rst = '1') then
			active_state <= st_IDLE_1;
		elsif (clk = '1' and clk'event) then
			active_state <= next_state;
		end if;
	end process;

end SlaveAgent_arch;
