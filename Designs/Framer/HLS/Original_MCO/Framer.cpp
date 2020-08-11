#include "ap_int.h"
#include "Framer_functions.h"
#include "Framer_data_Types.h"

void Framer_operations(
	marker_t data_word_sig,
	bool &oof_sig,
	bool &frame_pulse_sig,
	ap_int<32> in_frm_cnt,
	ap_int<32> &out_align,
	ap_int<32> &out_frm_cnt,
	Phases &out_nextphase,
	bool &frame_pulse_notify,
	operation active_operation
)
{
	switch (active_operation) {
	case state_1_1:
		out_align = data_word_sig.markerAlignment;
		frame_pulse_sig = true;
		out_frm_cnt = 0;
		out_nextphase = FIND_SYNC;
		frame_pulse_notify = true;
		break;
	case state_1_10:
		frame_pulse_notify = false;
		break;
	case state_1_3:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		frame_pulse_notify = true;
		break;
	case state_1_5:
		out_align = data_word_sig.markerAlignment;
		out_frm_cnt = 0;
		out_nextphase = FIND_SYNC;
		frame_pulse_notify = false;
		break;
	case state_1_7:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		frame_pulse_notify = false;
		break;
	case state_2_11:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SEARCH;
		frame_pulse_notify = true;
		break;
	case state_2_13:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SYNC;
		oof_sig = false;
		frame_pulse_notify = true;
		break;
	case state_2_15:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		frame_pulse_notify = true;
		break;
	case state_2_17:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SEARCH;
		frame_pulse_notify = false;
		break;
	case state_2_19:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SYNC;
		oof_sig = false;
		frame_pulse_notify = false;
		break;
	case state_2_21:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		frame_pulse_notify = false;
		break;
	case state_2_24:
		frame_pulse_notify = false;
		break;
	case state_3_25:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = MISS;
		frame_pulse_notify = true;
		break;
	case state_3_27:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SYNC;
		frame_pulse_notify = true;
		break;
	case state_3_29:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		frame_pulse_notify = true;
		break;
	case state_3_31:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = MISS;
		frame_pulse_notify = false;
		break;
	case state_3_33:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SYNC;
		frame_pulse_notify = false;
		break;
	case state_3_35:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		frame_pulse_notify = false;
		break;
	case state_3_38:
		frame_pulse_notify = false;
		break;
	case state_4_39:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SEARCH;
		oof_sig = true;
		frame_pulse_notify = true;
		break;
	case state_4_41:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SYNC;
		frame_pulse_notify = true;
		break;
	case state_4_43:
		frame_pulse_sig = true;
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		frame_pulse_notify = true;
		break;
	case state_4_45:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SEARCH;
		oof_sig = true;
		frame_pulse_notify = false;
		break;
	case state_4_47:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		out_nextphase = SYNC;
		frame_pulse_notify = false;
		break;
	case state_4_49:
		out_frm_cnt = ((1 + in_frm_cnt) % WORDS_IN_FRAME);
		frame_pulse_notify = false;
		break;
	case state_4_52:
		frame_pulse_notify = false;
		break;
	}
}