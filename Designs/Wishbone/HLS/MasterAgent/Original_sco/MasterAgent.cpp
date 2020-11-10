#include "ap_int.h"
#include "MasterAgent_data_types.h"

void MasterAgent_operations(
	slave_signals bus_to_agent_sig,
	bus_req_t master_to_agent_sig,
	master_signals &agent_to_bus_sig,
	bus_req_t &agent_to_bus_req,
	bus_resp_t &agent_to_bus_resp,
	Sections &section,
	Sections &nextsection,
	bool &agent_to_master_notify,
	bool &master_to_agent_notify,
	operation active_operation
)
{
	static master_signals agent_to_bus_sig_reg = {(ap_int<32>)0, false, (ap_int<32>)0, false, false};
	static bus_req_t agent_to_bus_req_reg = {0, 0, SINGLE_READ};
	static bus_resp_t agent_to_bus_resp_reg = {OK, (ap_int<32>)0};
	static Sections section_reg = IDLE;
	static Sections nextsection_reg = IDLE;
	static bool agent_to_master_notify_reg = false;
	static bool master_to_agent_notify_reg = true;

	bus_req_t agent_to_bus_req_tmp = agent_to_bus_req_reg;
	bus_resp_t agent_to_bus_resp_tmp = agent_to_bus_resp_reg;
	Sections section_tmp = section_reg;
	Sections nextsection_tmp = nextsection_reg;

	agent_to_bus_sig = agent_to_bus_sig_reg;
	agent_to_bus_req = agent_to_bus_req_reg;
	agent_to_bus_resp = agent_to_bus_resp_reg;
	section = section_reg;
	nextsection = nextsection_reg;
	agent_to_master_notify = agent_to_master_notify_reg;
	master_to_agent_notify = master_to_agent_notify_reg;

	switch (active_operation) {
	case DONE_3_8:
		agent_to_bus_resp_reg.ack = agent_to_bus_resp_tmp.ack;
		agent_to_bus_resp_reg.data = agent_to_bus_resp_tmp.data;
		agent_to_master_notify_reg = true;
		master_to_agent_notify_reg = false;
		break;
	case DONE_3_9:
		section_reg = nextsection_tmp;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = false;
		break;
	case IDLE_1_1:
		agent_to_bus_req_reg.trans_type = master_to_agent_sig.trans_type;
		agent_to_bus_sig_reg.addr = master_to_agent_sig.addr;
		agent_to_bus_sig_reg.cyc = true;
		agent_to_bus_sig_reg.data = (ap_int<32>)0;
		agent_to_bus_sig_reg.stb = true;
		agent_to_bus_sig_reg.we = false;
		nextsection_reg = WAITING;
		section_reg = WAITING;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = false;
		break;
	case IDLE_1_2:
		agent_to_bus_req_reg.trans_type = master_to_agent_sig.trans_type;
		agent_to_bus_sig_reg.addr = master_to_agent_sig.addr;
		agent_to_bus_sig_reg.cyc = true;
		agent_to_bus_sig_reg.data = master_to_agent_sig.data;
		agent_to_bus_sig_reg.stb = true;
		agent_to_bus_sig_reg.we = true;
		nextsection_reg = WAITING;
		section_reg = WAITING;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = false;
		break;
	case WAITING_2_3:
		agent_to_bus_resp_reg.ack = ERR;
		agent_to_bus_resp_reg.data = bus_to_agent_sig.data;
		agent_to_bus_sig_reg.addr = (ap_int<32>)0;
		agent_to_bus_sig_reg.cyc = false;
		agent_to_bus_sig_reg.data = (ap_int<32>)0;
		agent_to_bus_sig_reg.stb = false;
		agent_to_bus_sig_reg.we = false;
		nextsection_reg = DONE;
		section_reg = DONE;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = false;
		break;
	case WAITING_2_4:
		agent_to_bus_resp_reg.ack = OK;
		agent_to_bus_resp_reg.data = bus_to_agent_sig.data;
		agent_to_bus_sig_reg.addr = (ap_int<32>)0;
		agent_to_bus_sig_reg.cyc = false;
		agent_to_bus_sig_reg.data = (ap_int<32>)0;
		agent_to_bus_sig_reg.stb = false;
		agent_to_bus_sig_reg.we = false;
		nextsection_reg = DONE;
		section_reg = DONE;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = false;
		break;
	case WAITING_2_5:
		agent_to_bus_resp_reg.ack = ERR;
		agent_to_bus_sig_reg.addr = (ap_int<32>)0;
		agent_to_bus_sig_reg.cyc = false;
		agent_to_bus_sig_reg.data = (ap_int<32>)0;
		agent_to_bus_sig_reg.stb = false;
		agent_to_bus_sig_reg.we = false;
		nextsection_reg = DONE;
		section_reg = DONE;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = false;
		break;
	case WAITING_2_6:
		agent_to_bus_resp_reg.ack = OK;
		agent_to_bus_sig_reg.addr = (ap_int<32>)0;
		agent_to_bus_sig_reg.cyc = false;
		agent_to_bus_sig_reg.data = (ap_int<32>)0;
		agent_to_bus_sig_reg.stb = false;
		agent_to_bus_sig_reg.we = false;
		nextsection_reg = DONE;
		section_reg = DONE;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = false;
		break;
	case WAITING_2_7:
		section_reg = nextsection_tmp;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = false;
		break;
	case state_4_10:
		nextsection_reg = IDLE;
		section_reg = IDLE;
		agent_to_master_notify_reg = false;
		master_to_agent_notify_reg = true;
		break;
	case state_wait:
		break;
	}
}