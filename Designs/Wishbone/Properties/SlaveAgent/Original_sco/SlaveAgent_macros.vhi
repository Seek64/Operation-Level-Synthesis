-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro agent_to_slave_sync : boolean := end macro;
-- macro slave_to_agent_sync : boolean := end macro;
-- macro agent_to_slave_notify : boolean := end macro;
-- macro slave_to_agent_notify : boolean := end macro;


-- DP SIGNALS --
-- macro agent_to_bus_sig : slave_signals := agent_to_bus_sig end macro;
macro agent_to_bus_sig_ack : boolean := agent_to_bus_sig.ack end macro;
macro agent_to_bus_sig_data : std_logic_vector := agent_to_bus_sig.data end macro;
macro agent_to_bus_sig_err : boolean := agent_to_bus_sig.err end macro;
-- macro agent_to_slave_sig : bus_req_t := agent_to_slave_sig end macro;
macro agent_to_slave_sig_addr : std_logic_vector := agent_to_slave_sig.addr end macro;
macro agent_to_slave_sig_data : std_logic_vector := agent_to_slave_sig.data end macro;
macro agent_to_slave_sig_trans_type : trans_t := agent_to_slave_sig.trans_type end macro;
-- macro bus_to_agent_sig : master_signals := bus_to_agent_sig end macro;
macro bus_to_agent_sig_addr : std_logic_vector := bus_to_agent_sig.addr end macro;
macro bus_to_agent_sig_cyc : boolean := bus_to_agent_sig.cyc end macro;
macro bus_to_agent_sig_data : std_logic_vector := bus_to_agent_sig.data end macro;
macro bus_to_agent_sig_stb : boolean := bus_to_agent_sig.stb end macro;
macro bus_to_agent_sig_we : boolean := bus_to_agent_sig.we end macro;
-- macro slave_to_agent_sig : bus_resp_t := slave_to_agent_sig end macro;
macro slave_to_agent_sig_ack : ack_t := slave_to_agent_sig.ack end macro;
macro slave_to_agent_sig_data : std_logic_vector := slave_to_agent_sig.data end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
-- macro nextsection : Sections := nextsection end macro;
-- macro section : Sections := section end macro;
macro slave_to_agent_resp_ack : ack_t := slave_to_agent_resp.ack end macro;
macro slave_to_agent_resp_data : std_logic_vector := slave_to_agent_resp.data end macro;


-- STATES --
macro IDLE_1 : boolean := active_state = st_IDLE_1 end macro;
macro state_2 : boolean := active_state = st_state_2 end macro;
macro state_3 : boolean := active_state = st_state_3 end macro;
macro state_4 : boolean := active_state = st_state_4 end macro;
macro state_5 : boolean := active_state = st_state_5 end macro;
macro DONE_6 : boolean := active_state = st_DONE_6 end macro;


