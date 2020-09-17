#ifndef DATA_TYPES_H
#define DATA_TYPES_H

#include "ap_int.h"

// States
enum state {IDLE_1, GET_BIT_ZERO_2, GET_BIT_ONE_3, GET_BIT_TWO_4, GET_BIT_THREE_5, GET_BIT_FOUR_6, GET_BIT_FIVE_7, GET_BIT_SIX_8, GET_BIT_SEVEN_9, GET_PARITY_BIT_10, GET_STOP_BIT_11, GET_STOP_BIT_SECOND_12};

// Operations
enum operation {GET_BIT_FIVE_7_23, GET_BIT_FOUR_6_22, GET_BIT_ONE_3_19, GET_BIT_SEVEN_9_25, GET_BIT_SEVEN_9_26, GET_BIT_SIX_8_24, GET_BIT_THREE_5_21, GET_BIT_TWO_4_20, GET_BIT_ZERO_2_18, GET_PARITY_BIT_10_27, GET_PARITY_BIT_10_28, GET_STOP_BIT_11_29, GET_STOP_BIT_11_30, GET_STOP_BIT_SECOND_12_31, GET_STOP_BIT_SECOND_12_32, IDLE_1_10, IDLE_1_11, IDLE_1_14, IDLE_1_15, IDLE_1_16, IDLE_1_17, IDLE_1_2, IDLE_1_3, IDLE_1_33, IDLE_1_36, IDLE_1_40, IDLE_1_41, IDLE_1_44, IDLE_1_45, IDLE_1_49, IDLE_1_5, IDLE_1_6, IDLE_1_7, state_wait};

// Enum Types

// Compound Types
struct config_t {
	bool odd_parity;
	bool parity;
	bool two_stop_bits;
};

struct data_t {
	ap_uint<32> data;
	bool valid;
};

struct rx_events_t {
	ap_uint<32> error_src;
	bool ready;
	bool timeout;
};


// Constants
const ap_uint<32> ERROR_OVERRUN_MASK = 1;
const ap_uint<32> ERROR_PARITY_MASK = 2;
const ap_uint<32> ERROR_FRAMING_MASK = 4;
const ap_uint<32> ERROR_BREAK_MASK = 8;

#endif //DATA_TYPES_H