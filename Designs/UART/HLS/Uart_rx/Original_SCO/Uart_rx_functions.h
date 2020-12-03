#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include "ap_int.h"
#include "Uart_rx_data_types.h"

bool parity_not_correct(ap_uint<32> data, bool odd_parity, bool parity_bit);
ap_uint<32> update_data(ap_uint<32> data, ap_uint<32> data_count, bool rx_bit);


bool parity_not_correct(ap_uint<32> data, bool odd_parity, bool parity_bit) {
return ((odd_parity != (((((((((data & 1) ^ ((data >> 1) & 1)) ^ ((data >> 2) & 1)) ^ ((data >> 3) & 1)) ^ ((data >> 4) & 1)) ^ ((data >> 5) & 1)) ^ ((data >> 6) & 1)) ^ ((data >> 7) & 1)) == 1)) != parity_bit);
}

ap_uint<32> update_data(ap_uint<32> data, ap_uint<32> data_count, bool rx_bit) {
	if (rx_bit) {
return (data | (1 << data_count));
	} else {
return (data & (~((1 << data_count))));
	} 
}

#endif //FUNCTIONS_H