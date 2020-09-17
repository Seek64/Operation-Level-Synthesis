#include "ap_int.h"
#include "Uart_rx_functions.h"
#include "Uart_rx_data_Types.h"

void Uart_rx_operations(
	bool rxd_sig,
	rx_events_t &events_out_sig,
	bool &out_parity,
	rx_events_t &out_events_out_msg,
	bool &out_timeout,
	bool &out_wait_framing_break,
	data_t &out_data_out_msg,
	ap_uint<32> &out_suspending_count,
	bool &out_first_stop_bit,
	bool &events_out_notify,
	bool &rxd_notify,
	operation active_operation
)
{
	static rx_events_t events_out_sig_reg = {0, false, false};
	static bool parity_reg = false;
	static rx_events_t events_out_msg_reg = {0, false, false};
	static bool timeout_reg = true;
	static bool wait_framing_break_reg = false;
	static data_t data_out_msg_reg = {0, false};
	static ap_uint<32> suspending_count_reg = 0;
	static bool first_stop_bit_reg = false;
	static bool events_out_notify_reg = false;
	static bool rxd_notify_reg = true;

	bool parity_tmp = parity_reg;
	rx_events_t events_out_msg_tmp = events_out_msg_reg;
	bool timeout_tmp = timeout_reg;
	bool wait_framing_break_tmp = wait_framing_break_reg;
	data_t data_out_msg_tmp = data_out_msg_reg;
	ap_uint<32> suspending_count_tmp = suspending_count_reg;
	bool first_stop_bit_tmp = first_stop_bit_reg;

	events_out_sig = events_out_sig_reg;
	out_parity = parity_reg;
	out_events_out_msg = events_out_msg_reg;
	out_timeout = timeout_reg;
	out_wait_framing_break = wait_framing_break_reg;
	out_data_out_msg = data_out_msg_reg;
	out_suspending_count = suspending_count_reg;
	out_first_stop_bit = first_stop_bit_reg;
	events_out_notify = events_out_notify_reg;
	rxd_notify = rxd_notify_reg;

	switch (active_operation) {
	case GET_BIT_FIVE_7_23:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 5, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_BIT_FOUR_6_22:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 4, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_BIT_ONE_3_19:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 1, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_BIT_SEVEN_9_25:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 7, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_BIT_SEVEN_9_26:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 7, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		parity_reg = false;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_BIT_SIX_8_24:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 6, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_BIT_THREE_5_21:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 3, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_BIT_TWO_4_20:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 2, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_BIT_ZERO_2_18:
		data_out_msg_reg.data = update_data(data_out_msg_tmp.data, 0, rxd_sig);
		data_out_msg_reg.valid = data_out_msg_tmp.valid;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_PARITY_BIT_10_27:
		events_out_msg_reg.error_src = 0;
		events_out_sig_reg.error_src = ERROR_PARITY_MASK;
		events_out_sig_reg.ready = events_out_msg_tmp.ready;
		events_out_sig_reg.timeout = events_out_msg_tmp.timeout;
		parity_reg = rxd_sig;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case GET_PARITY_BIT_10_28:
		parity_reg = rxd_sig;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case GET_STOP_BIT_11_29:
		events_out_msg_reg.error_src = 0;
		events_out_sig_reg.error_src = ERROR_FRAMING_MASK;
		events_out_sig_reg.ready = events_out_msg_tmp.ready;
		events_out_sig_reg.timeout = events_out_msg_tmp.timeout;
		first_stop_bit_reg = rxd_sig;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case GET_STOP_BIT_11_30:
		data_out_msg_reg.valid = true;
		events_out_msg_reg.error_src = 0;
		events_out_msg_reg.ready = false;
		events_out_sig_reg.error_src = ERROR_FRAMING_MASK;
		events_out_sig_reg.ready = true;
		events_out_sig_reg.timeout = events_out_msg_tmp.timeout;
		first_stop_bit_reg = rxd_sig;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case GET_STOP_BIT_SECOND_12_31:
		data_out_msg_reg.valid = true;
		events_out_msg_reg.error_src = 0;
		events_out_msg_reg.ready = false;
		events_out_sig_reg.error_src = ERROR_BREAK_MASK;
		events_out_sig_reg.ready = true;
		events_out_sig_reg.timeout = events_out_msg_tmp.timeout;
		wait_framing_break_reg = true;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case GET_STOP_BIT_SECOND_12_32:
		data_out_msg_reg.valid = true;
		events_out_msg_reg.error_src = 0;
		events_out_msg_reg.ready = false;
		events_out_sig_reg.error_src = ERROR_FRAMING_MASK;
		events_out_sig_reg.ready = true;
		events_out_sig_reg.timeout = events_out_msg_tmp.timeout;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case IDLE_1_10:
		data_out_msg_reg.valid = false;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_11:
		data_out_msg_reg.valid = false;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_14:
		data_out_msg_reg.valid = false;
		events_out_msg_reg.error_src = 0;
		events_out_sig_reg.error_src = ERROR_OVERRUN_MASK;
		events_out_sig_reg.ready = events_out_msg_tmp.ready;
		events_out_sig_reg.timeout = events_out_msg_tmp.timeout;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case IDLE_1_15:
		data_out_msg_reg.valid = false;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_16:
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_17:
		data_out_msg_reg.data = 0;
		data_out_msg_reg.valid = false;
		first_stop_bit_reg = false;
		parity_reg = false;
		suspending_count_reg = 0;
		wait_framing_break_reg = false;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_2:
		data_out_msg_reg.valid = false;
		suspending_count_reg = 0;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_3:
		data_out_msg_reg.valid = false;
		suspending_count_reg = 0;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_33:
		data_out_msg_reg.valid = false;
		suspending_count_reg = 0;
		timeout_reg = false;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_36:
		suspending_count_reg = 0;
		timeout_reg = false;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_40:
		data_out_msg_reg.valid = false;
		events_out_msg_reg.timeout = false;
		events_out_sig_reg.error_src = events_out_msg_tmp.error_src;
		events_out_sig_reg.ready = events_out_msg_tmp.ready;
		events_out_sig_reg.timeout = true;
		suspending_count_reg = (1 + suspending_count_tmp);
		timeout_reg = true;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case IDLE_1_41:
		data_out_msg_reg.valid = false;
		suspending_count_reg = (1 + suspending_count_tmp);
		timeout_reg = false;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_44:
		events_out_msg_reg.timeout = false;
		events_out_sig_reg.error_src = events_out_msg_tmp.error_src;
		events_out_sig_reg.ready = events_out_msg_tmp.ready;
		events_out_sig_reg.timeout = true;
		suspending_count_reg = (1 + suspending_count_tmp);
		timeout_reg = true;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case IDLE_1_45:
		suspending_count_reg = (1 + suspending_count_tmp);
		timeout_reg = false;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_49:
		data_out_msg_reg.data = 0;
		data_out_msg_reg.valid = false;
		first_stop_bit_reg = false;
		parity_reg = false;
		suspending_count_reg = 0;
		wait_framing_break_reg = false;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_5:
		data_out_msg_reg.valid = false;
		events_out_msg_reg.error_src = 0;
		events_out_sig_reg.error_src = ERROR_OVERRUN_MASK;
		events_out_sig_reg.ready = events_out_msg_tmp.ready;
		events_out_sig_reg.timeout = events_out_msg_tmp.timeout;
		suspending_count_reg = 0;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = true;
		rxd_notify_reg = true;
		break;
	case IDLE_1_6:
		data_out_msg_reg.valid = false;
		suspending_count_reg = 0;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case IDLE_1_7:
		suspending_count_reg = 0;
		timeout_reg = false;
		wait_framing_break_reg = (!(rxd_sig)) && wait_framing_break_tmp;
		events_out_notify_reg = false;
		rxd_notify_reg = true;
		break;
	case state_wait:
		events_out_notify_reg = false;
		break;
	}
}