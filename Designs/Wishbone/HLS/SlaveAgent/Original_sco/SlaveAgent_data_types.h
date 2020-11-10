#ifndef DATA_TYPES_H
#define DATA_TYPES_H

#include "ap_int.h"

// States
enum state {IDLE_1, state_2, state_3, state_4, state_5, DONE_6};

// Operations
enum operation {DONE_6_10, DONE_6_8, DONE_6_9, IDLE_1_1, IDLE_1_2, IDLE_1_3, state_2_4, state_3_5, state_4_6, state_5_7, state_wait};

// Enum Types
enum trans_t {SINGLE_READ, SINGLE_WRITE};

enum Sections {DONE, IDLE, READ, WRITE};

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

struct slave_signals {
	bool ack;
	ap_int<32> data;
	bool err;
};

struct master_signals {
	ap_int<32> addr;
	bool cyc;
	ap_int<32> data;
	bool stb;
	bool we;
};


#endif //DATA_TYPES_H