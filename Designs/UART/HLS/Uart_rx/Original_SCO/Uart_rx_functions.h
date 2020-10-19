#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include "ap_int.h"
#include "Uart_rx_data_types.h"

bool parity_not_correct(ap_uint<32> data, bool odd_parity, bool parity_bit);
ap_uint<32> update_data(ap_uint<32> data, ap_uint<32> data_count, bool rx_bit);


bool parity_not_correct(ap_uint<32> data, bool odd_parity, bool parity_bit) {
		return(((odd_parity != ((((((((data.range(0, 0) ^ data.range(1, 1)) ^ data.range(2, 2)) ^ data.range(3, 3)) ^ data.range(4, 4)) ^ data.range(5, 5)) ^ data.range(6, 6)) ^ data.range(7, 7)) == 1)) != parity_bit));
}

ap_uint<32> update_data(ap_uint<32> data, ap_uint<32> data_count, bool rx_bit) {
	if ((rx_bit)) {
		return((data | (static_cast<unsigned>(1) << static_cast<unsigned>(data_count))));
	} else {
		return((data & (~((static_cast<unsigned>(1) << static_cast<unsigned>(data_count))))));
	} 
}

#endif //FUNCTIONS_H