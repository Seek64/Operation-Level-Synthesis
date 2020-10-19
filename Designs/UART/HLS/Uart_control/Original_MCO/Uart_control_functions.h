#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include "ap_int.h"
#include "Uart_control_data_types.h"

ap_uint<32> CONFIG_MASK(ap_uint<32> frame_config);
ap_uint<32> ENABLE_MASK(ap_uint<32> enable);
bool ENABLE_SET(ap_uint<32> enable);
ap_uint<32> ERROR_MASK(ap_uint<32> error_src);
bool HWFC(ap_uint<32> stop_bit);
bool ODD_PARITY(ap_uint<32> odd_parity);
bool PARITY(ap_uint<32> parity);
bool STOP(ap_uint<32> stop_bit);
bool TASK_MASK(ap_uint<32> task);


ap_uint<32> CONFIG_MASK(ap_uint<32> frame_config) {
return (frame_config & 287);
}

ap_uint<32> ENABLE_MASK(ap_uint<32> enable) {
return (enable & 1);
}

bool ENABLE_SET(ap_uint<32> enable) {
return ((enable & 1) != 0);
}

ap_uint<32> ERROR_MASK(ap_uint<32> error_src) {
return (error_src & 15);
}

bool HWFC(ap_uint<32> stop_bit) {
return ((stop_bit & CONFIG_HWFC_MASK) != 0);
}

bool ODD_PARITY(ap_uint<32> odd_parity) {
return ((odd_parity & 256) != 0);
}

bool PARITY(ap_uint<32> parity) {
return ((parity & 14) != 0);
}

bool STOP(ap_uint<32> stop_bit) {
return ((stop_bit & CONFIG_STOP_MASK) != 0);
}

bool TASK_MASK(ap_uint<32> task) {
return ((task & 1) != 0);
}

#endif //FUNCTIONS_H