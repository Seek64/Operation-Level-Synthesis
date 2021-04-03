#include "ap_int.h"
#include "Bus_new_data_types.h"

void Bus_new_operations(
	bus_req_t master_in_sig,
	bus_resp_t slave_in0_sig,
	bus_resp_t slave_in1_sig,
	bus_resp_t slave_in2_sig,
	bus_resp_t slave_in3_sig,
	bus_req_t &req,
	bus_resp_t &resp,
	bool &master_in_notify,
	bool &master_out_notify,
	bool &slave_in0_notify,
	bool &slave_in1_notify,
	bool &slave_in2_notify,
	bool &slave_in3_notify,
	bool &slave_out0_notify,
	bool &slave_out1_notify,
	bool &slave_out2_notify,
	bool &slave_out3_notify,
	operation active_operation
)
{
	static bus_req_t req_reg = {0, 0, SINGLE_READ};
	static bus_resp_t resp_reg = {OK, (ap_int<32>)0};
	static bool master_in_notify_reg = true;
	static bool master_out_notify_reg = false;
	static bool slave_in0_notify_reg = false;
	static bool slave_in1_notify_reg = false;
	static bool slave_in2_notify_reg = false;
	static bool slave_in3_notify_reg = false;
	static bool slave_out0_notify_reg = false;
	static bool slave_out1_notify_reg = false;
	static bool slave_out2_notify_reg = false;
	static bool slave_out3_notify_reg = false;

	bus_req_t req_tmp = req_reg;
	bus_resp_t resp_tmp = resp_reg;

	req = req_reg;
	resp = resp_reg;
	master_in_notify = master_in_notify_reg;
	master_out_notify = master_out_notify_reg;
	slave_in0_notify = slave_in0_notify_reg;
	slave_in1_notify = slave_in1_notify_reg;
	slave_in2_notify = slave_in2_notify_reg;
	slave_in3_notify = slave_in3_notify_reg;
	slave_out0_notify = slave_out0_notify_reg;
	slave_out1_notify = slave_out1_notify_reg;
	slave_out2_notify = slave_out2_notify_reg;
	slave_out3_notify = slave_out3_notify_reg;

	switch (active_operation) {
	case master_in_1_1:
		req_reg.trans_type = master_in_sig.trans_type;
		req_reg.addr = master_in_sig.addr;
		req_reg.data = (ap_int<32>)0;
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = true;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case master_in_1_10:
		resp_reg.ack = resp_tmp.ack;
		resp_reg.data = (ap_int<32>)0;
		req_reg.trans_type = master_in_sig.trans_type;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case master_in_1_2:
		req_reg.trans_type = master_in_sig.trans_type;
		req_reg.addr = ((ap_int<32>)-8 + master_in_sig.addr);
		req_reg.data = (ap_int<32>)0;
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = true;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case master_in_1_3:
		req_reg.trans_type = master_in_sig.trans_type;
		req_reg.addr = ((ap_int<32>)-16 + master_in_sig.addr);
		req_reg.data = (ap_int<32>)0;
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = true;
		slave_out3_notify_reg = false;
		break;
	case master_in_1_4:
		req_reg.trans_type = master_in_sig.trans_type;
		req_reg.addr = ((ap_int<32>)-24 + master_in_sig.addr);
		req_reg.data = (ap_int<32>)0;
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = true;
		break;
	case master_in_1_5:
		resp_reg.ack = resp_tmp.ack;
		resp_reg.data = resp_tmp.data;
		req_reg.trans_type = master_in_sig.trans_type;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case master_in_1_6:
		req_reg.trans_type = master_in_sig.trans_type;
		req_reg.addr = master_in_sig.addr;
		req_reg.data = master_in_sig.data;
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = true;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case master_in_1_7:
		req_reg.trans_type = master_in_sig.trans_type;
		req_reg.addr = ((ap_int<32>)-8 + master_in_sig.addr);
		req_reg.data = master_in_sig.data;
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = true;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case master_in_1_8:
		req_reg.trans_type = master_in_sig.trans_type;
		req_reg.addr = ((ap_int<32>)-16 + master_in_sig.addr);
		req_reg.data = master_in_sig.data;
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = true;
		slave_out3_notify_reg = false;
		break;
	case master_in_1_9:
		req_reg.trans_type = master_in_sig.trans_type;
		req_reg.addr = ((ap_int<32>)-24 + master_in_sig.addr);
		req_reg.data = master_in_sig.data;
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = true;
		break;
	case master_out_4_14:
		master_in_notify_reg = true;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_in0_3_12:
		resp_reg.ack = slave_in0_sig.ack;
		resp_reg.data = (ap_int<32>)0;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_in0_3_13:
		resp_reg.ack = slave_in0_sig.ack;
		resp_reg.data = slave_in0_sig.data;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_in1_6_16:
		resp_reg.ack = slave_in1_sig.ack;
		resp_reg.data = (ap_int<32>)0;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_in1_6_17:
		resp_reg.ack = slave_in1_sig.ack;
		resp_reg.data = slave_in1_sig.data;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_in2_8_19:
		resp_reg.ack = slave_in2_sig.ack;
		resp_reg.data = (ap_int<32>)0;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_in2_8_20:
		resp_reg.ack = slave_in2_sig.ack;
		resp_reg.data = slave_in2_sig.data;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_in3_10_22:
		resp_reg.ack = slave_in3_sig.ack;
		resp_reg.data = (ap_int<32>)0;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_in3_10_23:
		resp_reg.ack = slave_in3_sig.ack;
		resp_reg.data = slave_in3_sig.data;
		master_in_notify_reg = false;
		master_out_notify_reg = true;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_out0_2_11:
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = true;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_out1_5_15:
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = true;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_out2_7_18:
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = true;
		slave_in3_notify_reg = false;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case slave_out3_9_21:
		master_in_notify_reg = false;
		master_out_notify_reg = false;
		slave_in0_notify_reg = false;
		slave_in1_notify_reg = false;
		slave_in2_notify_reg = false;
		slave_in3_notify_reg = true;
		slave_out0_notify_reg = false;
		slave_out1_notify_reg = false;
		slave_out2_notify_reg = false;
		slave_out3_notify_reg = false;
		break;
	case state_wait:
		break;
	}
}