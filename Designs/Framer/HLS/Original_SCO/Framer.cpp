#include "ap_int.h"
#include "Framer_data_types.h"

void Framer_operations(
	marker_t data_word_sig,
	bool &oof_sig,
	bool &frame_pulse_sig,
	ap_int<32> &frm_cnt,
	Phases &nextphase,
	ap_int<32> &align,
	bool &frame_pulse_notify,
	operation active_operation
)
{
	static bool oof_sig_reg = true;
	static bool frame_pulse_sig_reg = false;
	static ap_int<32> frm_cnt_reg = (ap_int<32>)63;
	static Phases nextphase_reg = SEARCH;
	static ap_int<32> align_reg = (ap_int<32>)0;
	static bool frame_pulse_notify_reg = false;

	ap_int<32> frm_cnt_tmp = frm_cnt_reg;
	Phases nextphase_tmp = nextphase_reg;
	ap_int<32> align_tmp = align_reg;

	oof_sig = oof_sig_reg;
	frame_pulse_sig = frame_pulse_sig_reg;
	frm_cnt = frm_cnt_reg;
	nextphase = nextphase_reg;
	align = align_reg;
	frame_pulse_notify = frame_pulse_notify_reg;

	switch (active_operation) {
	case state_1_1:
		align_reg = data_word_sig.markerAlignment;
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (ap_int<32>)0;
		nextphase_reg = FIND_SYNC;
		frame_pulse_notify_reg = true;
		break;
	case state_1_10:
		frame_pulse_notify_reg = false;
		break;
	case state_1_3:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		frame_pulse_notify_reg = true;
		break;
	case state_1_5:
		align_reg = data_word_sig.markerAlignment;
		frm_cnt_reg = (ap_int<32>)0;
		nextphase_reg = FIND_SYNC;
		frame_pulse_notify_reg = false;
		break;
	case state_1_7:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		frame_pulse_notify_reg = false;
		break;
	case state_2_11:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SEARCH;
		frame_pulse_notify_reg = true;
		break;
	case state_2_13:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SYNC;
		oof_sig_reg = false;
		frame_pulse_notify_reg = true;
		break;
	case state_2_15:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		frame_pulse_notify_reg = true;
		break;
	case state_2_17:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SEARCH;
		frame_pulse_notify_reg = false;
		break;
	case state_2_19:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SYNC;
		oof_sig_reg = false;
		frame_pulse_notify_reg = false;
		break;
	case state_2_21:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		frame_pulse_notify_reg = false;
		break;
	case state_2_24:
		frame_pulse_notify_reg = false;
		break;
	case state_3_25:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = MISS;
		frame_pulse_notify_reg = true;
		break;
	case state_3_27:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SYNC;
		frame_pulse_notify_reg = true;
		break;
	case state_3_29:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		frame_pulse_notify_reg = true;
		break;
	case state_3_31:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = MISS;
		frame_pulse_notify_reg = false;
		break;
	case state_3_33:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SYNC;
		frame_pulse_notify_reg = false;
		break;
	case state_3_35:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		frame_pulse_notify_reg = false;
		break;
	case state_3_38:
		frame_pulse_notify_reg = false;
		break;
	case state_4_39:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SEARCH;
		oof_sig_reg = true;
		frame_pulse_notify_reg = true;
		break;
	case state_4_41:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SYNC;
		frame_pulse_notify_reg = true;
		break;
	case state_4_43:
		frame_pulse_sig_reg = true;
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		frame_pulse_notify_reg = true;
		break;
	case state_4_45:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SEARCH;
		oof_sig_reg = true;
		frame_pulse_notify_reg = false;
		break;
	case state_4_47:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		nextphase_reg = SYNC;
		frame_pulse_notify_reg = false;
		break;
	case state_4_49:
		frm_cnt_reg = (((ap_int<32>)1 + frm_cnt_tmp) % WORDS_IN_FRAME);
		frame_pulse_notify_reg = false;
		break;
	case state_4_52:
		frame_pulse_notify_reg = false;
		break;
	}
}