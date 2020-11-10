#include "ap_int.h"
#include "Interconnect_data_types.h"

void Interconnect_operations(
	slave_signals slave_in3_sig,
	slave_signals slave_in0_sig,
	master_signals master_input_sig,
	slave_signals slave_in1_sig,
	slave_signals slave_in2_sig,
	slave_signals &master_output_sig,
	master_signals &slave_out0_sig,
	master_signals &slave_out1_sig,
	master_signals &slave_out2_sig,
	master_signals &slave_out3_sig,
	master_signals &from_master,
	Sections &section,
	Sections &nextsection,
	ap_int<32> &slave_number,
	slave_signals &to_master,
	operation active_operation
)
{
	static slave_signals master_output_sig_reg = {false, (ap_int<32>)0, false};
	static master_signals slave_out0_sig_reg = {(ap_int<32>)0, false, (ap_int<32>)0, false, false};
	static master_signals slave_out1_sig_reg = {(ap_int<32>)0, false, (ap_int<32>)0, false, false};
	static master_signals slave_out2_sig_reg = {(ap_int<32>)0, false, (ap_int<32>)0, false, false};
	static master_signals slave_out3_sig_reg = {(ap_int<32>)0, false, (ap_int<32>)0, false, false};
	static master_signals from_master_reg = {(ap_int<32>)0, false, (ap_int<32>)0, false, false};
	static Sections section_reg = IDLE;
	static Sections nextsection_reg = IDLE;
	static ap_int<32> slave_number_reg = (ap_int<32>)0;
	static slave_signals to_master_reg = {false, (ap_int<32>)0, false};

	master_signals from_master_tmp = from_master_reg;
	Sections section_tmp = section_reg;
	Sections nextsection_tmp = nextsection_reg;
	ap_int<32> slave_number_tmp = slave_number_reg;
	slave_signals to_master_tmp = to_master_reg;

	master_output_sig = master_output_sig_reg;
	slave_out0_sig = slave_out0_sig_reg;
	slave_out1_sig = slave_out1_sig_reg;
	slave_out2_sig = slave_out2_sig_reg;
	slave_out3_sig = slave_out3_sig_reg;
	from_master = from_master_reg;
	section = section_reg;
	nextsection = nextsection_reg;
	slave_number = slave_number_reg;
	to_master = to_master_reg;

	switch (active_operation) {
	case state_1_1:
		from_master_reg.addr = (ap_int<32>)0;
		from_master_reg.cyc = false;
		from_master_reg.data = (ap_int<32>)0;
		from_master_reg.stb = false;
		from_master_reg.we = false;
		nextsection_reg = TRANSMITTING;
		section_reg = TRANSMITTING;
		slave_number_reg = (ap_int<32>)0;
		slave_out0_sig_reg.addr = master_input_sig.addr;
		slave_out0_sig_reg.cyc = master_input_sig.cyc;
		slave_out0_sig_reg.data = master_input_sig.data;
		slave_out0_sig_reg.stb = master_input_sig.stb;
		slave_out0_sig_reg.we = master_input_sig.we;
		break;
	case state_1_2:
		from_master_reg.addr = (ap_int<32>)0;
		from_master_reg.cyc = false;
		from_master_reg.data = (ap_int<32>)0;
		from_master_reg.stb = false;
		from_master_reg.we = false;
		nextsection_reg = TRANSMITTING;
		section_reg = TRANSMITTING;
		slave_number_reg = (ap_int<32>)1;
		slave_out1_sig_reg.addr = ((ap_int<32>)-8 + master_input_sig.addr);
		slave_out1_sig_reg.cyc = master_input_sig.cyc;
		slave_out1_sig_reg.data = master_input_sig.data;
		slave_out1_sig_reg.stb = master_input_sig.stb;
		slave_out1_sig_reg.we = master_input_sig.we;
		break;
	case state_1_3:
		from_master_reg.addr = (ap_int<32>)0;
		from_master_reg.cyc = false;
		from_master_reg.data = (ap_int<32>)0;
		from_master_reg.stb = false;
		from_master_reg.we = false;
		nextsection_reg = TRANSMITTING;
		section_reg = TRANSMITTING;
		slave_number_reg = (ap_int<32>)2;
		slave_out2_sig_reg.addr = ((ap_int<32>)-16 + master_input_sig.addr);
		slave_out2_sig_reg.cyc = master_input_sig.cyc;
		slave_out2_sig_reg.data = master_input_sig.data;
		slave_out2_sig_reg.stb = master_input_sig.stb;
		slave_out2_sig_reg.we = master_input_sig.we;
		break;
	case state_1_4:
		from_master_reg.addr = (ap_int<32>)0;
		from_master_reg.cyc = false;
		from_master_reg.data = (ap_int<32>)0;
		from_master_reg.stb = false;
		from_master_reg.we = false;
		nextsection_reg = TRANSMITTING;
		section_reg = TRANSMITTING;
		slave_number_reg = (ap_int<32>)3;
		slave_out3_sig_reg.addr = ((ap_int<32>)-24 + master_input_sig.addr);
		slave_out3_sig_reg.cyc = master_input_sig.cyc;
		slave_out3_sig_reg.data = master_input_sig.data;
		slave_out3_sig_reg.stb = master_input_sig.stb;
		slave_out3_sig_reg.we = master_input_sig.we;
		break;
	case state_1_5:
		from_master_reg.addr = master_input_sig.addr;
		from_master_reg.cyc = master_input_sig.cyc;
		from_master_reg.data = master_input_sig.data;
		from_master_reg.stb = master_input_sig.stb;
		from_master_reg.we = master_input_sig.we;
		master_output_sig_reg.ack = true;
		master_output_sig_reg.data = (ap_int<32>)0;
		master_output_sig_reg.err = false;
		nextsection_reg = DONE;
		section_reg = DONE;
		to_master_reg.ack = true;
		to_master_reg.data = (ap_int<32>)0;
		to_master_reg.err = false;
		break;
	case state_1_6:
		from_master_reg.addr = master_input_sig.addr;
		from_master_reg.cyc = master_input_sig.cyc;
		from_master_reg.data = master_input_sig.data;
		from_master_reg.stb = master_input_sig.stb;
		from_master_reg.we = master_input_sig.we;
		section_reg = nextsection_tmp;
		break;
	case state_2_10:
		from_master_reg.addr = (ap_int<32>)0;
		from_master_reg.cyc = false;
		from_master_reg.data = (ap_int<32>)0;
		from_master_reg.stb = false;
		from_master_reg.we = false;
		section_reg = nextsection_tmp;
		slave_number_reg = (ap_int<32>)1;
		to_master_reg.ack = slave_in1_sig.ack;
		to_master_reg.data = slave_in1_sig.data;
		to_master_reg.err = slave_in1_sig.err;
		break;
	case state_2_11:
		master_output_sig_reg.ack = slave_in2_sig.ack;
		master_output_sig_reg.data = slave_in2_sig.data;
		master_output_sig_reg.err = slave_in2_sig.err;
		nextsection_reg = DONE;
		section_reg = DONE;
		slave_number_reg = (ap_int<32>)2;
		slave_out2_sig_reg.addr = from_master_tmp.addr;
		slave_out2_sig_reg.cyc = from_master_tmp.cyc;
		slave_out2_sig_reg.data = from_master_tmp.data;
		slave_out2_sig_reg.stb = from_master_tmp.stb;
		slave_out2_sig_reg.we = from_master_tmp.we;
		to_master_reg.ack = slave_in2_sig.ack;
		to_master_reg.data = slave_in2_sig.data;
		to_master_reg.err = slave_in2_sig.err;
		break;
	case state_2_12:
		from_master_reg.addr = (ap_int<32>)0;
		from_master_reg.cyc = false;
		from_master_reg.data = (ap_int<32>)0;
		from_master_reg.stb = false;
		from_master_reg.we = false;
		section_reg = nextsection_tmp;
		slave_number_reg = (ap_int<32>)2;
		to_master_reg.ack = slave_in2_sig.ack;
		to_master_reg.data = slave_in2_sig.data;
		to_master_reg.err = slave_in2_sig.err;
		break;
	case state_2_13:
		master_output_sig_reg.ack = slave_in3_sig.ack;
		master_output_sig_reg.data = slave_in3_sig.data;
		master_output_sig_reg.err = slave_in3_sig.err;
		nextsection_reg = DONE;
		section_reg = DONE;
		slave_number_reg = (ap_int<32>)3;
		slave_out3_sig_reg.addr = from_master_tmp.addr;
		slave_out3_sig_reg.cyc = from_master_tmp.cyc;
		slave_out3_sig_reg.data = from_master_tmp.data;
		slave_out3_sig_reg.stb = from_master_tmp.stb;
		slave_out3_sig_reg.we = from_master_tmp.we;
		to_master_reg.ack = slave_in3_sig.ack;
		to_master_reg.data = slave_in3_sig.data;
		to_master_reg.err = slave_in3_sig.err;
		break;
	case state_2_14:
		from_master_reg.addr = (ap_int<32>)0;
		from_master_reg.cyc = false;
		from_master_reg.data = (ap_int<32>)0;
		from_master_reg.stb = false;
		from_master_reg.we = false;
		section_reg = nextsection_tmp;
		slave_number_reg = (ap_int<32>)3;
		to_master_reg.ack = slave_in3_sig.ack;
		to_master_reg.data = slave_in3_sig.data;
		to_master_reg.err = slave_in3_sig.err;
		break;
	case state_2_7:
		master_output_sig_reg.ack = slave_in0_sig.ack;
		master_output_sig_reg.data = slave_in0_sig.data;
		master_output_sig_reg.err = slave_in0_sig.err;
		nextsection_reg = DONE;
		section_reg = DONE;
		slave_number_reg = (ap_int<32>)0;
		slave_out0_sig_reg.addr = from_master_tmp.addr;
		slave_out0_sig_reg.cyc = from_master_tmp.cyc;
		slave_out0_sig_reg.data = from_master_tmp.data;
		slave_out0_sig_reg.stb = from_master_tmp.stb;
		slave_out0_sig_reg.we = from_master_tmp.we;
		to_master_reg.ack = slave_in0_sig.ack;
		to_master_reg.data = slave_in0_sig.data;
		to_master_reg.err = slave_in0_sig.err;
		break;
	case state_2_8:
		from_master_reg.addr = (ap_int<32>)0;
		from_master_reg.cyc = false;
		from_master_reg.data = (ap_int<32>)0;
		from_master_reg.stb = false;
		from_master_reg.we = false;
		section_reg = nextsection_tmp;
		slave_number_reg = (ap_int<32>)0;
		to_master_reg.ack = slave_in0_sig.ack;
		to_master_reg.data = slave_in0_sig.data;
		to_master_reg.err = slave_in0_sig.err;
		break;
	case state_2_9:
		master_output_sig_reg.ack = slave_in1_sig.ack;
		master_output_sig_reg.data = slave_in1_sig.data;
		master_output_sig_reg.err = slave_in1_sig.err;
		nextsection_reg = DONE;
		section_reg = DONE;
		slave_number_reg = (ap_int<32>)1;
		slave_out1_sig_reg.addr = from_master_tmp.addr;
		slave_out1_sig_reg.cyc = from_master_tmp.cyc;
		slave_out1_sig_reg.data = from_master_tmp.data;
		slave_out1_sig_reg.stb = from_master_tmp.stb;
		slave_out1_sig_reg.we = from_master_tmp.we;
		to_master_reg.ack = slave_in1_sig.ack;
		to_master_reg.data = slave_in1_sig.data;
		to_master_reg.err = slave_in1_sig.err;
		break;
	case state_3_15:
		from_master_reg.addr = master_input_sig.addr;
		from_master_reg.cyc = master_input_sig.cyc;
		from_master_reg.data = master_input_sig.data;
		from_master_reg.stb = master_input_sig.stb;
		from_master_reg.we = master_input_sig.we;
		master_output_sig_reg.ack = false;
		master_output_sig_reg.data = (ap_int<32>)0;
		master_output_sig_reg.err = false;
		nextsection_reg = IDLE;
		section_reg = IDLE;
		to_master_reg.ack = false;
		to_master_reg.data = (ap_int<32>)0;
		to_master_reg.err = false;
		break;
	case state_3_16:
		from_master_reg.addr = master_input_sig.addr;
		from_master_reg.cyc = master_input_sig.cyc;
		from_master_reg.data = master_input_sig.data;
		from_master_reg.stb = master_input_sig.stb;
		from_master_reg.we = master_input_sig.we;
		master_output_sig_reg.ack = to_master_tmp.ack;
		master_output_sig_reg.data = to_master_tmp.data;
		master_output_sig_reg.err = to_master_tmp.err;
		section_reg = nextsection_tmp;
		break;
	}
}