#include "ap_int.h"
#include "Uart_tx_functions.h"
#include "Uart_tx_data_Types.h"

void Uart_tx_operations(
	config_t config_in_sig,
	data_t data_in_sig,
	bool &data_in_notify_sig,
	tx_events_t &events_out_sig,
	bool &out_txd_bit,
	ap_uint<32> &out_data,
	bool &data_in_notify_notify,
	bool &events_out_notify,
	bool &txd_notify,
	operation active_operation
)
{
	static bool data_in_notify_sig_reg = false;
	static tx_events_t events_out_sig_reg = {false};
	static bool txd_bit_reg = true;
	static ap_uint<32> data_reg = 0;
	static bool data_in_notify_notify_reg = false;
	static bool events_out_notify_reg = false;
	static bool txd_notify_reg = false;

	bool txd_bit_tmp = txd_bit_reg;
	ap_uint<32> data_tmp = data_reg;

	data_in_notify_sig = data_in_notify_sig_reg;
	events_out_sig = events_out_sig_reg;
	out_txd_bit = txd_bit_reg;
	out_data = data_reg;
	data_in_notify_notify = data_in_notify_notify_reg;
	events_out_notify = events_out_notify_reg;
	txd_notify = txd_notify_reg;

	switch (active_operation) {
	case DATA_NOTIFY_2_4:
		txd_bit_reg = false;
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case IDLE_1_1:
		data_reg = data_in_sig.data;
		data_in_notify_sig_reg = true;
		data_in_notify_notify_reg = true;
		events_out_notify_reg = false;
		txd_notify_reg = false;
		break;
	case IDLE_1_2:
		data_reg = 0;
		txd_bit_reg = true;
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = false;
		break;
	case IDLE_1_3:
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = false;
		break;
	case STOP_NOTIFY_15_19:
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = false;
		break;
	case TRANSMITTING_DATA_FIVE_9_11:
		txd_bit_reg = get_data_bit(data_tmp, 6);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_DATA_FOUR_8_10:
		txd_bit_reg = get_data_bit(data_tmp, 5);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_DATA_ONE_5_7:
		txd_bit_reg = get_data_bit(data_tmp, 2);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_DATA_SEVEN_11_13:
		txd_bit_reg = (config_in_sig.odd_parity)?(!(get_even_parity(data_tmp))):get_even_parity(data_tmp);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_DATA_SEVEN_11_14:
		txd_bit_reg = true;
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_DATA_SIX_10_12:
		txd_bit_reg = get_data_bit(data_tmp, 7);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_DATA_THREE_7_9:
		txd_bit_reg = get_data_bit(data_tmp, 4);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_DATA_TWO_6_8:
		txd_bit_reg = get_data_bit(data_tmp, 3);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_DATA_ZERO_4_6:
		txd_bit_reg = get_data_bit(data_tmp, 1);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_PARITY_12_15:
		txd_bit_reg = true;
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_START_3_5:
		txd_bit_reg = get_data_bit(data_tmp, 0);
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_STOP_FIRST_13_16:
		txd_bit_reg = txd_bit_tmp;
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		txd_notify_reg = true;
		break;
	case TRANSMITTING_STOP_FIRST_13_17:
		events_out_sig_reg.done = true;
		data_in_notify_notify_reg = false;
		events_out_notify_reg = true;
		txd_notify_reg = false;
		break;
	case TRANSMITTING_STOP_SECOND_14_18:
		events_out_sig_reg.done = true;
		data_in_notify_notify_reg = false;
		events_out_notify_reg = true;
		txd_notify_reg = false;
		break;
	case state_wait:
		data_in_notify_notify_reg = false;
		events_out_notify_reg = false;
		break;
	}
}