#ifndef DATA_TYPES_H
#define DATA_TYPES_H

#include "ap_int.h"

// States
enum state {state_1, state_2, state_3};

// Operations
enum operation {state_1_1, state_1_2, state_1_3, state_1_4, state_1_5, state_1_6, state_2_10, state_2_11, state_2_12, state_2_13, state_2_14, state_2_7, state_2_8, state_2_9, state_3_15, state_3_16};

// Enum Types
enum Sections {DONE, IDLE, START, TRANSMITTING};

// Compound Types
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