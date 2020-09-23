#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include "ap_int.h"
#include "Uart_tx_data_types.h"

bool get_data_bit(ap_uint<32> data, ap_uint<32> data_count);
bool get_even_parity(ap_uint<32> data);


bool get_data_bit(ap_uint<32> data, ap_uint<32> data_count) {
		return(((data & (static_cast<unsigned>(1) << static_cast<unsigned>(data_count))) != 0));
}

bool get_even_parity(ap_uint<32> data) {
		return(((((((((data.range(0, 0) ^ data.range(1, 1)) ^ data.range(2, 2)) ^ data.range(3, 3)) ^ data.range(4, 4)) ^ data.range(5, 5)) ^ data.range(6, 6)) ^ data.range(7, 7)) == 1));
}

#endif //FUNCTIONS_H