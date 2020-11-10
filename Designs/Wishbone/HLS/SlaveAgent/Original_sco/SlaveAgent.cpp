#include "ap_int.h"
#include "SlaveAgent_data_types.h"

void SlaveAgent_operations(
	bus_resp_t slave_to_agent_sig,
	master_signals bus_to_agent_sig,
	slave_signals &agent_to_bus_sig,
	bus_req_t &agent_to_slave_sig,
	Sections &section,
	Sections &nextsection,
	bus_resp_t &slave_to_agent_resp,
	bool &agent_to_slave_notify,
	bool &slave_to_agent_notify,
	operation active_operation
)
{
	static slave_signals agent_to_bus_sig_reg = {false, (ap_int<32>)0, false};
	static bus_req_t agent_to_slave_sig_reg = {0, 0, SINGLE_READ};
	static Sections section_reg = IDLE;
	static Sections nextsection_reg = IDLE;
	static bus_resp_t slave_to_agent_resp_reg = {OK, (ap_int<32>)0};
	static bool agent_to_slave_notify_reg = false;
	static bool slave_to_agent_notify_reg = false;

	Sections section_tmp = section_reg;
	Sections nextsection_tmp = nextsection_reg;
	bus_resp_t slave_to_agent_resp_tmp = slave_to_agent_resp_reg;

	agent_to_bus_sig = agent_to_bus_sig_reg;
	agent_to_slave_sig = agent_to_slave_sig_reg;
	section = section_reg;
	nextsection = nextsection_reg;
	slave_to_agent_resp = slave_to_agent_resp_reg;
	agent_to_slave_notify = agent_to_slave_notify_reg;
	slave_to_agent_notify = slave_to_agent_notify_reg;

	switch (active_operation) {
	case DONE_6_10:
		agent_to_bus_sig_reg.ack = true;
		agent_to_bus_sig_reg.data = (ap_int<32>)0;
		agent_to_bus_sig_reg.err = (!((slave_to_agent_resp_tmp.ack == OK)));
		section_reg = nextsection_tmp;
		agent_to_slave_notify_reg = false;
		slave_to_agent_notify_reg = false;
		break;
	case DONE_6_8:
		agent_to_bus_sig_reg.ack = false;
		agent_to_bus_sig_reg.data = (ap_int<32>)0;
		agent_to_bus_sig_reg.err = false;
		nextsection_reg = IDLE;
		section_reg = IDLE;
		agent_to_slave_notify_reg = false;
		slave_to_agent_notify_reg = false;
		break;
	case DONE_6_9:
		agent_to_bus_sig_reg.ack = true;
		agent_to_bus_sig_reg.data = slave_to_agent_resp_tmp.data;
		agent_to_bus_sig_reg.err = (!((slave_to_agent_resp_tmp.ack == OK)));
		section_reg = nextsection_tmp;
		agent_to_slave_notify_reg = false;
		slave_to_agent_notify_reg = false;
		break;
	case IDLE_1_1:
		agent_to_slave_sig_reg.addr = bus_to_agent_sig.addr;
		agent_to_slave_sig_reg.data = (ap_int<32>)0;
		agent_to_slave_sig_reg.trans_type = SINGLE_READ;
		nextsection_reg = READ;
		section_reg = READ;
		agent_to_slave_notify_reg = true;
		slave_to_agent_notify_reg = false;
		break;
	case IDLE_1_2:
		agent_to_slave_sig_reg.addr = bus_to_agent_sig.addr;
		agent_to_slave_sig_reg.data = bus_to_agent_sig.data;
		agent_to_slave_sig_reg.trans_type = SINGLE_WRITE;
		nextsection_reg = WRITE;
		section_reg = WRITE;
		agent_to_slave_notify_reg = true;
		slave_to_agent_notify_reg = false;
		break;
	case IDLE_1_3:
		section_reg = nextsection_tmp;
		agent_to_slave_notify_reg = false;
		slave_to_agent_notify_reg = false;
		break;
	case state_2_4:
		agent_to_slave_notify_reg = false;
		slave_to_agent_notify_reg = true;
		break;
	case state_3_5:
		nextsection_reg = DONE;
		section_reg = DONE;
		slave_to_agent_resp_reg.ack = slave_to_agent_sig.ack;
		slave_to_agent_resp_reg.data = slave_to_agent_sig.data;
		agent_to_slave_notify_reg = false;
		slave_to_agent_notify_reg = false;
		break;
	case state_4_6:
		agent_to_slave_notify_reg = false;
		slave_to_agent_notify_reg = true;
		break;
	case state_5_7:
		nextsection_reg = DONE;
		section_reg = DONE;
		slave_to_agent_resp_reg.ack = slave_to_agent_sig.ack;
		slave_to_agent_resp_reg.data = (ap_int<32>)0;
		agent_to_slave_notify_reg = false;
		slave_to_agent_notify_reg = false;
		break;
	case state_wait:
		break;
	}
}