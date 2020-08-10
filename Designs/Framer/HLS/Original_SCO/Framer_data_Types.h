#ifndef DATA_TYPES_H
#define DATA_TYPES_H

#include "ap_int.h"

// States
enum state {state_1, state_2, state_3, state_4};

// Operations
enum operation {state_1_1, state_1_10, state_1_3, state_1_5, state_1_7, state_2_11, state_2_13, state_2_15, state_2_17, state_2_19, state_2_21, state_2_24, state_3_25, state_3_27, state_3_29, state_3_31, state_3_33, state_3_35, state_3_38, state_4_39, state_4_41, state_4_43, state_4_45, state_4_47, state_4_49, state_4_52, state_wait};

// Enum Types
enum Phases {FIND_SYNC, INITIALISE, MISS, SEARCH, SYNC};


// Compound Types
struct marker_t {
	bool isMarker;
	ap_int<32> markerAlignment;
};


// Constants
const ap_int<32> FRM_PULSE_POS = 0;
const ap_int<32> WORDS_IN_FRAME = 64;

#endif //DATA_TYPES_H