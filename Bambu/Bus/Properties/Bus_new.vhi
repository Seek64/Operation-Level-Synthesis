-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: master_in_1;
	 at t: req_trans_type = SINGLE_READ;
	 at t: resp_ack = OK;
	 at t: resp_data = resize(0,32);
	 at t: master_in_notify = true;
	 at t: master_out_notify = false;
	 at t: slave_in0_notify = false;
	 at t: slave_in1_notify = false;
	 at t: slave_in2_notify = false;
	 at t: slave_in3_notify = false;
	 at t: slave_out0_notify = false;
	 at t: slave_out1_notify = false;
	 at t: slave_out2_notify = false;
	 at t: slave_out3_notify = false;
end property;


property master_in_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: (master_in_sig_addr >= resize(0,32));
	at t: (master_in_sig_addr <= resize(7,32));
prove:
	at t_end: slave_out0_2;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out0_sig_addr = master_in_sig_addr_at_t;
	at t_end: slave_out0_sig_data = 0;
	at t_end: slave_out0_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end-1]: slave_out0_notify = false;
	at t_end: slave_out0_notify = true;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property master_in_1_10 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: not(((master_in_sig_addr >= resize(0,32)) and (master_in_sig_addr <= resize(7,32))));
	at t: not(((master_in_sig_addr >= resize(8,32)) and (master_in_sig_addr <= resize(15,32))));
	at t: not(((master_in_sig_addr >= resize(16,32)) and (master_in_sig_addr <= resize(23,32))));
	at t: not(((master_in_sig_addr >= resize(24,32)) and (master_in_sig_addr <= resize(31,32))));
	at t: (SINGLE_WRITE = master_in_sig_trans_type);
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = resp_ack_at_t;
	at t_end: master_out_sig_data = 0;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property master_in_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: (master_in_sig_addr >= resize(8,32));
	at t: (master_in_sig_addr <= resize(15,32));
prove:
	at t_end: slave_out1_5;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out1_sig_addr = (-8 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out1_sig_data = 0;
	at t_end: slave_out1_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end-1]: slave_out1_notify = false;
	at t_end: slave_out1_notify = true;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property master_in_1_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: (master_in_sig_addr >= resize(16,32));
	at t: (master_in_sig_addr <= resize(23,32));
prove:
	at t_end: slave_out2_7;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out2_sig_addr = (-16 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out2_sig_data = 0;
	at t_end: slave_out2_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end-1]: slave_out2_notify = false;
	at t_end: slave_out2_notify = true;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property master_in_1_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: (master_in_sig_addr >= resize(24,32));
	at t: (master_in_sig_addr <= resize(31,32));
prove:
	at t_end: slave_out3_9;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out3_sig_addr = (-24 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out3_sig_data = 0;
	at t_end: slave_out3_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end-1]: slave_out3_notify = false;
	at t_end: slave_out3_notify = true;
end property;


property master_in_1_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: (SINGLE_READ = master_in_sig_trans_type);
	at t: not(((master_in_sig_addr >= resize(0,32)) and (master_in_sig_addr <= resize(7,32))));
	at t: not(((master_in_sig_addr >= resize(8,32)) and (master_in_sig_addr <= resize(15,32))));
	at t: not(((master_in_sig_addr >= resize(16,32)) and (master_in_sig_addr <= resize(23,32))));
	at t: not(((master_in_sig_addr >= resize(24,32)) and (master_in_sig_addr <= resize(31,32))));
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = resp_ack_at_t;
	at t_end: master_out_sig_data = resp_data_at_t;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property master_in_1_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: not((SINGLE_READ = master_in_sig_trans_type));
	at t: (master_in_sig_addr >= resize(0,32));
	at t: (master_in_sig_addr <= resize(7,32));
prove:
	at t_end: slave_out0_2;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out0_sig_addr = master_in_sig_addr_at_t;
	at t_end: slave_out0_sig_data = master_in_sig_data_at_t;
	at t_end: slave_out0_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end-1]: slave_out0_notify = false;
	at t_end: slave_out0_notify = true;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property master_in_1_7 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: not((SINGLE_READ = master_in_sig_trans_type));
	at t: (master_in_sig_addr >= resize(8,32));
	at t: (master_in_sig_addr <= resize(15,32));
prove:
	at t_end: slave_out1_5;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out1_sig_addr = (-8 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out1_sig_data = master_in_sig_data_at_t;
	at t_end: slave_out1_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end-1]: slave_out1_notify = false;
	at t_end: slave_out1_notify = true;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property master_in_1_8 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: not((SINGLE_READ = master_in_sig_trans_type));
	at t: (master_in_sig_addr >= resize(16,32));
	at t: (master_in_sig_addr <= resize(23,32));
prove:
	at t_end: slave_out2_7;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out2_sig_addr = (-16 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out2_sig_data = master_in_sig_data_at_t;
	at t_end: slave_out2_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end-1]: slave_out2_notify = false;
	at t_end: slave_out2_notify = true;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property master_in_1_9 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	master_in_sig_addr_at_t = master_in_sig_addr@t,
	master_in_sig_data_at_t = master_in_sig_data@t,
	master_in_sig_trans_type_at_t = master_in_sig_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: master_in_sync;
	at t: not((SINGLE_READ = master_in_sig_trans_type));
	at t: (master_in_sig_addr >= resize(24,32));
	at t: (master_in_sig_addr <= resize(31,32));
prove:
	at t_end: slave_out3_9;
--	at t_end: req_trans_type = master_in_sig_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	at t_end: slave_out3_sig_addr = (-24 + master_in_sig_addr_at_t)(31 downto 0);
	at t_end: slave_out3_sig_data = master_in_sig_data_at_t;
	at t_end: slave_out3_sig_trans_type = master_in_sig_trans_type_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end-1]: slave_out3_notify = false;
	at t_end: slave_out3_notify = true;
end property;


property master_out_4_14 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_out_4;
	at t: master_out_sync;
prove:
	at t_end: master_in_1;
--	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end-1]: master_in_notify = false;
	at t_end: master_in_notify = true;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_in0_3_12 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	slave_in0_sig_ack_at_t = slave_in0_sig_ack@t;
assume:
	at t: slave_in0_3;
	at t: slave_in0_sync;
	at t: (SINGLE_WRITE = req_trans_type);
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = slave_in0_sig_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in0_sig_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_in0_3_13 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	slave_in0_sig_ack_at_t = slave_in0_sig_ack@t,
	slave_in0_sig_data_at_t = slave_in0_sig_data@t;
assume:
	at t: slave_in0_3;
	at t: slave_in0_sync;
	at t: not((SINGLE_WRITE = req_trans_type));
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = slave_in0_sig_ack_at_t;
	at t_end: master_out_sig_data = slave_in0_sig_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in0_sig_ack_at_t;
	at t_end: resp_data = slave_in0_sig_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_in1_6_16 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	slave_in1_sig_ack_at_t = slave_in1_sig_ack@t;
assume:
	at t: slave_in1_6;
	at t: slave_in1_sync;
	at t: (SINGLE_WRITE = req_trans_type);
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = slave_in1_sig_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in1_sig_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_in1_6_17 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	slave_in1_sig_ack_at_t = slave_in1_sig_ack@t,
	slave_in1_sig_data_at_t = slave_in1_sig_data@t;
assume:
	at t: slave_in1_6;
	at t: slave_in1_sync;
	at t: not((SINGLE_WRITE = req_trans_type));
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = slave_in1_sig_ack_at_t;
	at t_end: master_out_sig_data = slave_in1_sig_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in1_sig_ack_at_t;
	at t_end: resp_data = slave_in1_sig_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_in2_8_19 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	slave_in2_sig_ack_at_t = slave_in2_sig_ack@t;
assume:
	at t: slave_in2_8;
	at t: slave_in2_sync;
	at t: (SINGLE_WRITE = req_trans_type);
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = slave_in2_sig_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in2_sig_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_in2_8_20 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	slave_in2_sig_ack_at_t = slave_in2_sig_ack@t,
	slave_in2_sig_data_at_t = slave_in2_sig_data@t;
assume:
	at t: slave_in2_8;
	at t: slave_in2_sync;
	at t: not((SINGLE_WRITE = req_trans_type));
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = slave_in2_sig_ack_at_t;
	at t_end: master_out_sig_data = slave_in2_sig_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in2_sig_ack_at_t;
	at t_end: resp_data = slave_in2_sig_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_in3_10_22 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	slave_in3_sig_ack_at_t = slave_in3_sig_ack@t;
assume:
	at t: slave_in3_10;
	at t: slave_in3_sync;
	at t: (SINGLE_WRITE = req_trans_type);
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = slave_in3_sig_ack_at_t;
	at t_end: master_out_sig_data = 0;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in3_sig_ack_at_t;
	at t_end: resp_data = 0;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_in3_10_23 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	slave_in3_sig_ack_at_t = slave_in3_sig_ack@t,
	slave_in3_sig_data_at_t = slave_in3_sig_data@t;
assume:
	at t: slave_in3_10;
	at t: slave_in3_sync;
	at t: not((SINGLE_WRITE = req_trans_type));
prove:
	at t_end: master_out_4;
	at t_end: master_out_sig_ack = slave_in3_sig_ack_at_t;
	at t_end: master_out_sig_data = slave_in3_sig_data_at_t;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = slave_in3_sig_ack_at_t;
	at t_end: resp_data = slave_in3_sig_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end-1]: master_out_notify = false;
	at t_end: master_out_notify = true;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_out0_2_11 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: slave_out0_2;
	at t: slave_out0_sync;
prove:
	at t_end: slave_in0_3;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end-1]: slave_in0_notify = false;
	at t_end: slave_in0_notify = true;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_out1_5_15 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: slave_out1_5;
	at t: slave_out1_sync;
prove:
	at t_end: slave_in1_6;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end-1]: slave_in1_notify = false;
	at t_end: slave_in1_notify = true;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_out2_7_18 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: slave_out2_7;
	at t: slave_out2_sync;
prove:
	at t_end: slave_in2_8;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end-1]: slave_in2_notify = false;
	at t_end: slave_in2_notify = true;
	during[t+1, t_end]: slave_in3_notify = false;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property slave_out3_9_21 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: slave_out3_9;
	at t: slave_out3_sync;
prove:
	at t_end: slave_in3_10;
	at t_end: req_trans_type = req_trans_type_at_t;
	at t_end: resp_ack = resp_ack_at_t;
	at t_end: resp_data = resp_data_at_t;
	during[t+1, t_end]: master_in_notify = false;
	during[t+1, t_end]: master_out_notify = false;
	during[t+1, t_end]: slave_in0_notify = false;
	during[t+1, t_end]: slave_in1_notify = false;
	during[t+1, t_end]: slave_in2_notify = false;
	during[t+1, t_end-1]: slave_in3_notify = false;
	at t_end: slave_in3_notify = true;
	during[t+1, t_end]: slave_out0_notify = false;
	during[t+1, t_end]: slave_out1_notify = false;
	during[t+1, t_end]: slave_out2_notify = false;
	during[t+1, t_end]: slave_out3_notify = false;
end property;


property wait_master_in_1 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_in_1;
	at t: not(master_in_sync);
prove:
	at t+1: master_in_1;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = true;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_master_out_4 is
dependencies: no_reset;
freeze:
	master_out_sig_at_t = master_out_sig@t,
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: master_out_4;
	at t: not(master_out_sync);
prove:
	at t+1: master_out_4;
	at t+1: master_out_sig = master_out_sig_at_t;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = true;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_slave_in0_3 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: slave_in0_3;
	at t: not(slave_in0_sync);
prove:
	at t+1: slave_in0_3;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = true;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_slave_in1_6 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: slave_in1_6;
	at t: not(slave_in1_sync);
prove:
	at t+1: slave_in1_6;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = true;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_slave_in2_8 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: slave_in2_8;
	at t: not(slave_in2_sync);
prove:
	at t+1: slave_in2_8;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = true;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_slave_in3_10 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t;
assume:
	at t: slave_in3_10;
	at t: not(slave_in3_sync);
prove:
	at t+1: slave_in3_10;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = true;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_slave_out0_2 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t,
	slave_out0_sig_at_t = slave_out0_sig@t;
assume:
	at t: slave_out0_2;
	at t: not(slave_out0_sync);
prove:
	at t+1: slave_out0_2;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: slave_out0_sig = slave_out0_sig_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = true;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_slave_out1_5 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t,
	slave_out1_sig_at_t = slave_out1_sig@t;
assume:
	at t: slave_out1_5;
	at t: not(slave_out1_sync);
prove:
	at t+1: slave_out1_5;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: slave_out1_sig = slave_out1_sig_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = true;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = false;
end property;


property wait_slave_out2_7 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t,
	slave_out2_sig_at_t = slave_out2_sig@t;
assume:
	at t: slave_out2_7;
	at t: not(slave_out2_sync);
prove:
	at t+1: slave_out2_7;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: slave_out2_sig = slave_out2_sig_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = true;
	at t+1: slave_out3_notify = false;
end property;


property wait_slave_out3_9 is
dependencies: no_reset;
freeze:
	req_trans_type_at_t = req_trans_type@t,
	resp_ack_at_t = resp_ack@t,
	resp_data_at_t = resp_data@t,
	slave_out3_sig_at_t = slave_out3_sig@t;
assume:
	at t: slave_out3_9;
	at t: not(slave_out3_sync);
prove:
	at t+1: slave_out3_9;
	at t+1: req_trans_type = req_trans_type_at_t;
	at t+1: resp_ack = resp_ack_at_t;
	at t+1: resp_data = resp_data_at_t;
	at t+1: slave_out3_sig = slave_out3_sig_at_t;
	at t+1: master_in_notify = false;
	at t+1: master_out_notify = false;
	at t+1: slave_in0_notify = false;
	at t+1: slave_in1_notify = false;
	at t+1: slave_in2_notify = false;
	at t+1: slave_in3_notify = false;
	at t+1: slave_out0_notify = false;
	at t+1: slave_out1_notify = false;
	at t+1: slave_out2_notify = false;
	at t+1: slave_out3_notify = true;
end property;

