#ifndef DATA_TYPES_H
#define DATA_TYPES_H

#include "ap_int.h"

// States
enum state {master_in_1, slave_out0_2, slave_in0_3, master_out_4, slave_out1_5, slave_in1_6, slave_out2_7, slave_in2_8, slave_out3_9, slave_in3_10};

// Operations
enum operation {master_in_1_1, master_in_1_10, master_in_1_2, master_in_1_3, master_in_1_4, master_in_1_5, master_in_1_6, master_in_1_7, master_in_1_8, master_in_1_9, master_out_4_14, slave_in0_3_12, slave_in0_3_13, slave_in1_6_16, slave_in1_6_17, slave_in2_8_19, slave_in2_8_20, slave_in3_10_22, slave_in3_10_23, slave_out0_2_11, slave_out1_5_15, slave_out2_7_18, slave_out3_9_21, state_wait};

// Enum Types
enum trans_t {SINGLE_READ, SINGLE_WRITE};

enum ack_t {ERR, OK, RTY};

// Compound Types
struct bus_req_t {
	ap_int<32> addr;
	ap_int<32> data;
	trans_t trans_type;
};

struct bus_resp_t {
	ack_t ack;
	ap_int<32> data;
};


#endif //DATA_TYPES_H