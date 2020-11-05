#ifndef DATA_TYPES_H
#define DATA_TYPES_H

#include "ap_int.h"

// States
enum state {IDLE_1};

// Operations
enum operation {IDLE_1_1, IDLE_1_10, IDLE_1_11, IDLE_1_12, IDLE_1_13, IDLE_1_14, IDLE_1_15, IDLE_1_17, IDLE_1_18, IDLE_1_19, IDLE_1_2, IDLE_1_20, IDLE_1_21, IDLE_1_22, IDLE_1_23, IDLE_1_25, IDLE_1_26, IDLE_1_27, IDLE_1_28, IDLE_1_29, IDLE_1_3, IDLE_1_30, IDLE_1_31, IDLE_1_33, IDLE_1_34, IDLE_1_35, IDLE_1_36, IDLE_1_37, IDLE_1_38, IDLE_1_39, IDLE_1_4, IDLE_1_40, IDLE_1_41, IDLE_1_42, IDLE_1_43, IDLE_1_44, IDLE_1_45, IDLE_1_46, IDLE_1_47, IDLE_1_48, IDLE_1_49, IDLE_1_5, IDLE_1_50, IDLE_1_51, IDLE_1_52, IDLE_1_53, IDLE_1_54, IDLE_1_55, IDLE_1_56, IDLE_1_57, IDLE_1_58, IDLE_1_59, IDLE_1_6, IDLE_1_60, IDLE_1_61, IDLE_1_62, IDLE_1_63, IDLE_1_64, IDLE_1_7, IDLE_1_9};

// Enum Types
enum trans_t {READ, WRITE};

// Compound Types
struct bus_req_t {
	ap_uint<32> addr;
	ap_uint<32> data;
	trans_t trans_type;
};

struct tasks_t {
	bool start_rx;
	bool start_tx;
	bool stop_rx;
	bool stop_tx;
};

struct tx_events_t {
	bool done;
};

struct config_t {
	bool odd_parity;
	bool parity;
	bool two_stop_bits;
};

struct rx_events_t {
	ap_uint<32> error_src;
	bool ready;
	bool timeout;
};

struct events_t {
	bool cts;
	bool error;
	bool ncts;
	bool rx_timeout;
	bool rxd_ready;
	bool txd_ready;
};

struct bus_resp_t {
	ap_uint<32> data;
	bool valid;
};

struct tx_control_t {
	bool active;
	bool cts;
};

// Constants
const ap_uint<32> ADDR_TASKS_START_RX = 0;
const ap_uint<32> ADDR_TASKS_STOP_RX = 4;
const ap_uint<32> ADDR_TASKS_START_TX = 8;
const ap_uint<32> ADDR_TASKS_STOP_TX = 12;
const ap_uint<32> ADDR_ERROR_SRC = 1152;
const ap_uint<32> ADDR_ENABLE = 1280;
const ap_uint<32> ADDR_CONFIG = 1388;
const ap_uint<32> CONFIG_STOP_MASK = 16;
const ap_uint<32> CONFIG_HWFC_MASK = 1;

#endif //DATA_TYPES_H