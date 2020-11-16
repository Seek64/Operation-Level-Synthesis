-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
--macro agent_to_slave_sync : boolean := true end macro;
--macro slave_to_agent_sync : boolean := true end macro;
--macro agent_to_slave_notify : boolean := true end  macro;
--macro slave_to_agent_notify : boolean := true end  macro;


-- DP SIGNALS --
macro agent_to_bus_sig_ack  : boolean := agent_to_bus.ack;  end macro;
macro agent_to_bus_sig_data : signed  := agent_to_bus.data; end macro;
macro agent_to_bus_sig_err  : boolean := agent_to_bus.err;  end macro;

macro agent_to_slave_sig            : bus_req_t := agent_to_slave;            end macro;
macro agent_to_slave_sig_addr       : signed    := agent_to_slave.addr;       end macro;
macro agent_to_slave_sig_data       : signed    := agent_to_slave.data;       end macro;
macro agent_to_slave_sig_trans_type : trans_t   := agent_to_slave.trans_type; end macro;

macro bus_to_agent_sig_addr : signed  := bus_to_agent.addr; end macro;
macro bus_to_agent_sig_cyc  : boolean := bus_to_agent.cyc;  end macro;
macro bus_to_agent_sig_data : signed  := bus_to_agent.data; end macro;
macro bus_to_agent_sig_stb  : boolean := bus_to_agent.stb;  end macro;
macro bus_to_agent_sig_we   : boolean := bus_to_agent.we;   end macro;

macro slave_to_agent_sig_ack  : ack_t  := slave_to_agent.ack; end macro;
macro slave_to_agent_sig_data : signed := slave_to_agent.data;  end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro nextsection : SlaveAgent_SECTIONS := section; end macro;
--macro section : Sections := IDLE end macro;

macro slave_to_agent_resp_ack  : ack_t  := slave_to_agent_resp_signal.ack;  end macro;
macro slave_to_agent_resp_data : signed := slave_to_agent_resp_signal.data; end macro;


-- STATES --
macro IDLE_1 : boolean :=
    section = IDLE;
end macro;

macro state_2 : boolean :=
    section = READ and
    agent_to_slave_notify = true and
    slave_to_agent_notify = false;
end macro;

macro state_3 : boolean :=
    section = READ and
    agent_to_slave_notify = false and
    slave_to_agent_notify = true;
end macro;

macro state_4 : boolean :=
    section = WRITE and
    agent_to_slave_notify = true and
    slave_to_agent_notify = false;
end macro;

macro state_5 : boolean :=
    section = WRITE and
    agent_to_slave_notify = false and
    slave_to_agent_notify = true;
end macro;

macro DONE_6 : boolean :=
     section = DONE and is_done = false;
end macro;
