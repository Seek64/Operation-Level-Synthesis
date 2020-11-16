-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro agent_to_master_sync : boolean := end macro;
-- macro master_to_agent_sync : boolean := end macro;
-- macro agent_to_master_notify : boolean := end macro;
-- macro master_to_agent_notify : boolean := end macro;


-- DP SIGNALS --
-- macro agent_to_bus_sig : master_signals := agent_to_bus_sig end macro;
macro agent_to_bus_sig_addr : integer := agent_to_bus.addr; end macro;
macro agent_to_bus_sig_cyc  : boolean := agent_to_bus.cyc;  end macro;
macro agent_to_bus_sig_data : integer := agent_to_bus.data; end macro;
macro agent_to_bus_sig_stb  : boolean := agent_to_bus.stb;  end macro;
macro agent_to_bus_sig_we   : boolean := agent_to_bus.we;   end macro;

macro agent_to_master_sig      : bus_resp_t := agent_to_master;      end macro;
macro agent_to_master_sig_ack  : ack_t      := agent_to_master.ack;  end macro;
macro agent_to_master_sig_data : integer    := agent_to_master.data; end macro;

-- macro bus_to_agent_sig : slave_signals := bus_to_agent_sig end macro;
macro bus_to_agent_sig_ack  : boolean := bus_to_agent.ack;  end macro;
macro bus_to_agent_sig_data : integer := bus_to_agent.data; end macro;
macro bus_to_agent_sig_err  : boolean := bus_to_agent.err;  end macro;

-- macro master_to_agent_sig : bus_req_t := master_to_agent_sig end macro;
macro master_to_agent_sig_addr       : integer := master_to_agent.addr;       end macro;
macro master_to_agent_sig_data       : integer := master_to_agent.data;       end macro;
macro master_to_agent_sig_trans_type : trans_t := master_to_agent.trans_type; end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro agent_to_bus_req_trans_type : trans_t := agent_to_bus_req_signal.trans_type; end macro;
macro agent_to_bus_resp_ack       : ack_t   := agent_to_bus_resp_signal.ack;       end macro;
macro agent_to_bus_resp_data      : integer := agent_to_bus_resp_signal.data;      end macro;

macro nextsection : MasterAgent_SECTIONS := section; end macro;
-- macro section : Sections := section end macro;


-- STATES --
macro IDLE_1    : boolean := section = IDLE;                        end macro;
macro WAITING_2 : boolean := section = WAITING and wait_signal = 0; end macro;
macro DONE_3    : boolean := section = DONE and wait_signal = 1;    end macro;
macro state_4   : boolean := section = DONE and wait_signal = 0;    end macro;
