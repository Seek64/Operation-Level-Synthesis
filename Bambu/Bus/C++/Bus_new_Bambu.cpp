#include "ap_int.h"
#include "Bus_new_data_types.h"

void Bus_new_operations(
//	bus_req_t master_in_sig,
//	bus_resp_t slave_in0_sig,
//	bus_resp_t slave_in1_sig,
//	bus_resp_t slave_in2_sig,
//	bus_resp_t slave_in3_sig,
	
	int      master_in_sig_addr,  
	int      master_in_sig_data,	
	trans_t  master_in_sig_trans_type, 

	ack_t    slave_in0_sig_ack,
	int      slave_in0_sig_data,
	ack_t    slave_in1_sig_ack,
	int      slave_in1_sig_data,
	ack_t    slave_in2_sig_ack,
	int      slave_in2_sig_data,
	ack_t    slave_in3_sig_ack,
	int      slave_in3_sig_data,	
	
	
	
//	bus_req_t  &req,
//	bus_resp_t &resp,

	int      &req_addr,					// try a small example with enumeration
	int      &req_data,					// or try the whole program with * as Adding.cpp
	bool	 &req_trans_type,			// try this as a bool
	
	ack_t    &resp_ack,					// try this as an int
	int      &resp_data,		
	
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
	   master_in_notify = true;
	   master_out_notify = false;
	   slave_in0_notify = false;
	   slave_in1_notify = false;
	   slave_in2_notify = false;
	   slave_in3_notify = false;
	   slave_out0_notify = false;
	   slave_out1_notify = false;
	   slave_out2_notify = false;
	   slave_out3_notify = false;

//	bus_req_t req_tmp = {0, 0, SINGLE_READ};
	
	int      req_tmp_addr = 0;
	int      req_tmp_data = 0;
	trans_t  req_tmp_trans_type = SINGLE_READ;

//	bus_resp_t resp_tmp = {OK, 0};
	
	ack_t    resp_tmp_ack = OK;
	int      resp_tmp_data = 0;

	req_addr =  req_tmp_addr;
	req_data =  req_tmp_data;
	req_trans_type = req_tmp_trans_type;
	
	resp_ack = resp_tmp_ack;
	resp_data =  resp_tmp_data;

	switch (active_operation) {
	case master_in_1_1:
		req_trans_type = master_in_sig_trans_type;
		 req_addr =  master_in_sig_addr;
		 req_data = 0;
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = true;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case master_in_1_10:
		resp_ack = resp_tmp_ack;
		 resp_data = 0;
		req_trans_type = master_in_sig_trans_type;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case master_in_1_2:
		req_trans_type = master_in_sig_trans_type;
		 req_addr = (-8 +  master_in_sig_addr);
		 req_data = 0;
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = true;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case master_in_1_3:
		req_trans_type = master_in_sig_trans_type;
		 req_addr = (-16 +  master_in_sig_addr);
		 req_data = 0;
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = true;
		 slave_out3_notify = false;
		break;
	case master_in_1_4:
		req_trans_type = master_in_sig_trans_type;
		 req_addr = (-24 +  master_in_sig_addr);
		 req_data = 0;
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = true;
		break;
	case master_in_1_5:
		resp_ack = resp_tmp_ack;
		 resp_data =  resp_tmp_data;
		req_trans_type = master_in_sig_trans_type;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case master_in_1_6:
		req_trans_type = master_in_sig_trans_type;
		 req_addr =  master_in_sig_addr;
		 req_data =  master_in_sig_data;
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = true;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case master_in_1_7:
		req_trans_type = master_in_sig_trans_type;
		 req_addr = (-8 +  master_in_sig_addr);
		 req_data =  master_in_sig_data;
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = true;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case master_in_1_8:
		req_trans_type = master_in_sig_trans_type;
		 req_addr = (-16 +  master_in_sig_addr);
		 req_data =  master_in_sig_data;
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = true;
		 slave_out3_notify = false;
		break;
	case master_in_1_9:
		req_trans_type = master_in_sig_trans_type;
		 req_addr = (-24 +  master_in_sig_addr);
		 req_data =  master_in_sig_data;
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = true;
		break;
	case master_out_4_14:
		 master_in_notify = true;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_in0_3_12:
		resp_ack = slave_in0_sig_ack;
		 resp_data = 0;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_in0_3_13:
		resp_ack = slave_in0_sig_ack;
		 resp_data =  slave_in0_sig_data;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_in1_6_16:
		resp_ack = slave_in1_sig_ack;
		 resp_data = 0;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_in1_6_17:
		resp_ack = slave_in1_sig_ack;
		 resp_data =  slave_in1_sig_data;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_in2_8_19:
		resp_ack = slave_in2_sig_ack;
		 resp_data = 0;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_in2_8_20:
		resp_ack = slave_in2_sig_ack;
		 resp_data =  slave_in2_sig_data;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_in3_10_22:
		resp_ack = slave_in3_sig_ack;
		 resp_data = 0;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_in3_10_23:
		resp_ack = slave_in3_sig_ack;
		 resp_data =  slave_in3_sig_data;
		 master_in_notify = false;
		 master_out_notify = true;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_out0_2_11:
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = true;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_out1_5_15:
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = true;
		 slave_in2_notify = false;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_out2_7_18:
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = true;
		 slave_in3_notify = false;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case slave_out3_9_21:
		 master_in_notify = false;
		 master_out_notify = false;
		 slave_in0_notify = false;
		 slave_in1_notify = false;
		 slave_in2_notify = false;
		 slave_in3_notify = true;
		 slave_out0_notify = false;
		 slave_out1_notify = false;
		 slave_out2_notify = false;
		 slave_out3_notify = false;
		break;
	case state_wait:
		break;
	}
}