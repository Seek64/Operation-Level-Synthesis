#ifndef DATA_TYPES_H
#define DATA_TYPES_H

#include "ap_int.h"

// States
enum state {IDLE_1, WAITING_2, DONE_3, state_4};

// Operations
enum operation {DONE_3_8, DONE_3_9, IDLE_1_1, IDLE_1_2, WAITING_2_3, WAITING_2_4, WAITING_2_5, WAITING_2_6, WAITING_2_7, state_4_10, state_wait};

// Enum Types
enum trans_t {SINGLE_READ, SINGLE_WRITE};

enum ack_t {ERR, OK, RTY};

enum Sections {DONE, IDLE, READ, WAITING, WRITE};

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

struct master_signals {
	ap_int<32> addr;
	bool cyc;
	ap_int<32> data;
	bool stb;
	bool we;
};

struct slave_signals {
	bool ack;
	ap_int<32> data;
	bool err;
};


#endif //DATA_TYPES_H