library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MasterAgent_operations;
use work.MasterAgent_types.all;

entity MasterAgent_module is
port(
	bus_to_agent_sig: in slave_signals;
	master_to_agent_sig: in bus_req_t;
	agent_to_master_sig: out bus_resp_t;
	agent_to_bus_sig: out master_signals;
	agent_to_master_notify: out std_logic;
	master_to_agent_notify: out std_logic;
	agent_to_master_sync: in std_logic;
	master_to_agent_sync: in std_logic;
	clk: in std_logic;
	rst: in std_logic
);
end MasterAgent_module;

architecture MasterAgent_arch of MasterAgent_module is

	-- Internal Registers
	signal agent_to_bus_req: bus_req_t;
	signal agent_to_bus_resp: bus_resp_t;
	signal section: Sections;
	signal nextsection: Sections;

	-- Operation Module Inputs
	signal master_to_agent_sig_addr_in: std_logic_vector(31 downto 0);
	signal bus_to_agent_sig_data_in: std_logic_vector(31 downto 0);
	signal master_to_agent_sig_data_in: std_logic_vector(31 downto 0);
	signal master_to_agent_sig_trans_type_in: std_logic_vector(0 downto 0);
	signal active_operation_in: std_logic_vector(3 downto 0);

	-- Module Outputs
	signal agent_to_bus_sig_addr_out: std_logic_vector(31 downto 0);
	signal agent_to_bus_sig_cyc_out: std_logic;
	signal agent_to_bus_sig_data_out: std_logic_vector(31 downto 0);
	signal agent_to_bus_sig_stb_out: std_logic;
	signal agent_to_bus_sig_we_out: std_logic;
	signal agent_to_master_notify_out: std_logic;
	signal master_to_agent_notify_out: std_logic;

	-- Monitor Signals
	signal next_state: MasterAgent_state_t;
	signal active_state: MasterAgent_state_t;
	signal wait_state: std_logic;
	signal active_operation: MasterAgent_operation_t;

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


	component MasterAgent_operations is
	port(
		ap_clk: in std_logic;
		ap_rst: in std_logic;
		master_to_agent_sig_addr_V: in std_logic_vector(31 downto 0);
		bus_to_agent_sig_data_V: in std_logic_vector(31 downto 0);
		master_to_agent_sig_data_V: in std_logic_vector(31 downto 0);
		master_to_agent_sig_trans_type: in std_logic_vector(0 downto 0);
		agent_to_bus_sig_addr_V: out std_logic_vector(31 downto 0);
		agent_to_bus_sig_cyc: out std_logic;
		agent_to_bus_sig_data_V: out std_logic_vector(31 downto 0);
		agent_to_bus_sig_stb: out std_logic;
		agent_to_bus_sig_we: out std_logic;
		agent_to_bus_req_trans_type: out std_logic_vector(0 downto 0);
		agent_to_bus_resp_ack: out std_logic_vector(1 downto 0);
		agent_to_bus_resp_data_V: out std_logic_vector(31 downto 0);
		section: out std_logic_vector(2 downto 0);
		nextsection: out std_logic_vector(2 downto 0);
		agent_to_master_notify: out std_logic;
		master_to_agent_notify: out std_logic;
		active_operation: in std_logic_vector(3 downto 0)
	);
	end component;

begin

	operations_inst: MasterAgent_operations
	port map(
		ap_clk => clk,
		ap_rst => rst,
		master_to_agent_sig_addr_V => master_to_agent_sig_addr_in,
		bus_to_agent_sig_data_V => bus_to_agent_sig_data_in,
		master_to_agent_sig_data_V => master_to_agent_sig_data_in,
		master_to_agent_sig_trans_type => master_to_agent_sig_trans_type_in,
		agent_to_bus_sig_addr_V => agent_to_bus_sig_addr_out,
		agent_to_bus_sig_cyc => agent_to_bus_sig_cyc_out,
		agent_to_bus_sig_data_V => agent_to_bus_sig_data_out,
		agent_to_bus_sig_stb => agent_to_bus_sig_stb_out,
		agent_to_bus_sig_we => agent_to_bus_sig_we_out,
		agent_to_bus_req_trans_type => agent_to_bus_req.trans_type,
		agent_to_bus_resp_ack => agent_to_bus_resp.ack,
		agent_to_bus_resp_data_V => agent_to_bus_resp.data,
		section => section,
		nextsection => nextsection,
		agent_to_master_notify => agent_to_master_notify_out,
		master_to_agent_notify => master_to_agent_notify_out,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, master_to_agent_sync, agent_to_master_sync, bus_to_agent_sig.ack, bus_to_agent_sig.err, master_to_agent_sig.trans_type, agent_to_bus_req.trans_type, section, nextsection)
	begin
		case active_state is
		when st_IDLE_1 =>
			if (master_to_agent_sync and bool_to_sl(master_to_agent_sig.trans_type = SINGLE_READ) and not(bool_to_sl(section = READ)) and not(bool_to_sl(section = WRITE)) and not(bool_to_sl(section = WAITING)) and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_IDLE_1_1;
				next_state <= st_WAITING_2;
			elsif (master_to_agent_sync and not(bool_to_sl(master_to_agent_sig.trans_type = SINGLE_READ)) and not(bool_to_sl(section = READ)) and not(bool_to_sl(section = WRITE)) and not(bool_to_sl(section = WAITING)) and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_IDLE_1_2;
				next_state <= st_WAITING_2;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_WAITING_2 =>
			if (bus_to_agent_sig.ack and bool_to_sl(agent_to_bus_req.trans_type = SINGLE_READ) and bus_to_agent_sig.err and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_WAITING_2_3;
				next_state <= st_DONE_3;
			elsif (bus_to_agent_sig.ack and bool_to_sl(agent_to_bus_req.trans_type = SINGLE_READ) and not(bus_to_agent_sig.err) and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_WAITING_2_4;
				next_state <= st_DONE_3;
			elsif (bus_to_agent_sig.ack and not(bool_to_sl(agent_to_bus_req.trans_type = SINGLE_READ)) and bus_to_agent_sig.err and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_WAITING_2_5;
				next_state <= st_DONE_3;
			elsif (bus_to_agent_sig.ack and not(bool_to_sl(agent_to_bus_req.trans_type = SINGLE_READ)) and not(bus_to_agent_sig.err) and not(bool_to_sl(section = DONE))) = '1' then 
				active_operation <= op_WAITING_2_6;
				next_state <= st_DONE_3;
			else
				active_operation <= op_WAITING_2_7;
				next_state <= st_WAITING_2;
			end if;
		when st_DONE_3 =>
			if (not(bus_to_agent_sig.ack)) = '1' then 
				active_operation <= op_DONE_3_8;
				next_state <= st_state_4;
			else
				active_operation <= op_DONE_3_9;
				next_state <= st_DONE_3;
			end if;
		when st_state_4 =>
			if (agent_to_master_sync) = '1' then 
				active_operation <= op_state_4_10;
				next_state <= st_IDLE_1;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		end case;
	end process;


	-- Operation Module Outputs
	agent_to_bus_sig.addr <= agent_to_bus_sig_addr_out;
	agent_to_bus_sig.cyc <= agent_to_bus_sig_cyc_out;
	agent_to_bus_sig.data <= agent_to_bus_sig_data_out;
	agent_to_bus_sig.stb <= agent_to_bus_sig_stb_out;
	agent_to_bus_sig.we <= agent_to_bus_sig_we_out;

	-- Output Register to Output Mapping
	agent_to_master_sig <= agent_to_bus_resp;

	-- Notify Signals
	agent_to_master_notify <= agent_to_master_notify_out;
	master_to_agent_notify <= master_to_agent_notify_out;

	-- Operation Module Inputs
	active_operation_in <= active_operation;
	master_to_agent_sig_addr_in <= master_to_agent_sig.addr;
	bus_to_agent_sig_data_in <= bus_to_agent_sig.data;
	master_to_agent_sig_data_in <= master_to_agent_sig.data;
	master_to_agent_sig_trans_type_in <= master_to_agent_sig.trans_type;

	-- Control process
	process (clk, rst)
	begin
		if (rst = '1') then
			active_state <= st_IDLE_1;
		elsif (clk = '1' and clk'event) then
			active_state <= next_state;
		end if;
	end process;

end MasterAgent_arch;
