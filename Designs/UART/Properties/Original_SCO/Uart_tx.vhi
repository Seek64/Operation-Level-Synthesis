-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: IDLE_1;
	 at t: data = resize(0,32);
	 at t: txd_bit = true;
	 at t: data_in_notify_notify = false;
	 at t: events_out_notify = false;
	 at t: txd_notify = false;
end property;


property DATA_NOTIFY_2_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: DATA_NOTIFY_2;
prove:
	at t_end: TRANSMITTING_START_3;
	at t_end: data = data_at_t;
	at t_end: txd_bit = false;
	at t_end: txd_sig = false;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property IDLE_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_in_sig_data_at_t = data_in_sig_data@t,
	txd_bit_at_t = txd_bit@t;
assume:
	at t: IDLE_1;
	at t: data_in_sig_valid;
	at t: control_in_sig_active;
	at t: not(control_in_sig_cts);
prove:
	at t_end: DATA_NOTIFY_2;
	at t_end: data = data_in_sig_data_at_t;
	at t_end: data_in_notify_sig = true;
	at t_end: txd_bit = txd_bit_at_t;
	during[t+1, t_end-1]: data_in_notify_notify = false;
	at t_end: data_in_notify_notify = true;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end]: txd_notify = false;
end property;


property IDLE_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
assume:
	at t: IDLE_1;
	at t: not(control_in_sig_active);
prove:
	at t_end: IDLE_1;
	at t_end: data = 0;
	at t_end: txd_bit = true;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end]: txd_notify = false;
end property;


property IDLE_1_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t;
assume:
	at t: IDLE_1;
	at t: not((data_in_sig_valid and not(control_in_sig_cts)));
	at t: control_in_sig_active;
prove:
	at t_end: IDLE_1;
	at t_end: data = data_at_t;
	at t_end: txd_bit = txd_bit_at_t;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end]: txd_notify = false;
end property;


property STOP_NOTIFY_15_19 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t;
assume:
	at t: STOP_NOTIFY_15;
prove:
	at t_end: IDLE_1;
	at t_end: data = data_at_t;
	at t_end: txd_bit = txd_bit_at_t;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end]: txd_notify = false;
end property;


property TRANSMITTING_DATA_FIVE_9_11 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_FIVE_9;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_DATA_SIX_10;
	at t_end: data = data_at_t;
	at t_end: txd_bit = get_data_bit(data_at_t,6);
	at t_end: txd_sig = get_data_bit(data_at_t,6);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_DATA_FOUR_8_10 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_FOUR_8;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_DATA_FIVE_9;
	at t_end: data = data_at_t;
	at t_end: txd_bit = get_data_bit(data_at_t,5);
	at t_end: txd_sig = get_data_bit(data_at_t,5);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_DATA_ONE_5_7 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_ONE_5;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_DATA_TWO_6;
	at t_end: data = data_at_t;
	at t_end: txd_bit = get_data_bit(data_at_t,2);
	at t_end: txd_sig = get_data_bit(data_at_t,2);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_DATA_SEVEN_11_13 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	config_in_sig_odd_parity_at_t = config_in_sig_odd_parity@t,
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_SEVEN_11;
	at t: txd_sync;
	at t: config_in_sig_parity;
prove:
	at t_end: TRANSMITTING_PARITY_12;
	at t_end: data = data_at_t;
	at t_end: txd_bit = (config_in_sig_odd_parity_at_t)?not(get_even_parity(data_at_t)):get_even_parity(data_at_t);
	at t_end: txd_sig = (config_in_sig_odd_parity_at_t)?not(get_even_parity(data_at_t)):get_even_parity(data_at_t);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_DATA_SEVEN_11_14 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_SEVEN_11;
	at t: txd_sync;
	at t: not(config_in_sig_parity);
prove:
	at t_end: TRANSMITTING_STOP_FIRST_13;
	at t_end: data = data_at_t;
	at t_end: txd_bit = true;
	at t_end: txd_sig = true;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_DATA_SIX_10_12 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_SIX_10;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_DATA_SEVEN_11;
	at t_end: data = data_at_t;
	at t_end: txd_bit = get_data_bit(data_at_t,7);
	at t_end: txd_sig = get_data_bit(data_at_t,7);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_DATA_THREE_7_9 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_THREE_7;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_DATA_FOUR_8;
	at t_end: data = data_at_t;
	at t_end: txd_bit = get_data_bit(data_at_t,4);
	at t_end: txd_sig = get_data_bit(data_at_t,4);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_DATA_TWO_6_8 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_TWO_6;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_DATA_THREE_7;
	at t_end: data = data_at_t;
	at t_end: txd_bit = get_data_bit(data_at_t,3);
	at t_end: txd_sig = get_data_bit(data_at_t,3);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_DATA_ZERO_4_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_DATA_ZERO_4;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_DATA_ONE_5;
	at t_end: data = data_at_t;
	at t_end: txd_bit = get_data_bit(data_at_t,1);
	at t_end: txd_sig = get_data_bit(data_at_t,1);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_PARITY_12_15 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_PARITY_12;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_STOP_FIRST_13;
	at t_end: data = data_at_t;
	at t_end: txd_bit = true;
	at t_end: txd_sig = true;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_START_3_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t;
assume:
	at t: TRANSMITTING_START_3;
	at t: txd_sync;
prove:
	at t_end: TRANSMITTING_DATA_ZERO_4;
	at t_end: data = data_at_t;
	at t_end: txd_bit = get_data_bit(data_at_t,0);
	at t_end: txd_sig = get_data_bit(data_at_t,0);
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_STOP_FIRST_13_16 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t;
assume:
	at t: TRANSMITTING_STOP_FIRST_13;
	at t: txd_sync;
	at t: config_in_sig_two_stop_bits;
prove:
	at t_end: TRANSMITTING_STOP_SECOND_14;
	at t_end: data = data_at_t;
	at t_end: txd_bit = txd_bit_at_t;
	at t_end: txd_sig = txd_bit_at_t;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: txd_notify = false;
	at t_end: txd_notify = true;
end property;


property TRANSMITTING_STOP_FIRST_13_17 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t;
assume:
	at t: TRANSMITTING_STOP_FIRST_13;
	at t: txd_sync;
	at t: not(config_in_sig_two_stop_bits);
prove:
	at t_end: STOP_NOTIFY_15;
	at t_end: data = data_at_t;
	at t_end: events_out_sig_done = true;
	at t_end: txd_bit = txd_bit_at_t;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end]: txd_notify = false;
end property;


property TRANSMITTING_STOP_SECOND_14_18 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t;
assume:
	at t: TRANSMITTING_STOP_SECOND_14;
	at t: txd_sync;
prove:
	at t_end: STOP_NOTIFY_15;
	at t_end: data = data_at_t;
	at t_end: events_out_sig_done = true;
	at t_end: txd_bit = txd_bit_at_t;
	during[t+1, t_end]: data_in_notify_notify = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end]: txd_notify = false;
end property;


property wait_TRANSMITTING_DATA_FIVE_9 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_DATA_FIVE_9;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_DATA_FIVE_9;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_DATA_FOUR_8 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_DATA_FOUR_8;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_DATA_FOUR_8;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_DATA_ONE_5 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_DATA_ONE_5;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_DATA_ONE_5;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_DATA_SEVEN_11 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_DATA_SEVEN_11;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_DATA_SEVEN_11;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_DATA_SIX_10 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_DATA_SIX_10;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_DATA_SIX_10;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_DATA_THREE_7 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_DATA_THREE_7;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_DATA_THREE_7;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_DATA_TWO_6 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_DATA_TWO_6;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_DATA_TWO_6;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_DATA_ZERO_4 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_DATA_ZERO_4;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_DATA_ZERO_4;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_PARITY_12 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_PARITY_12;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_PARITY_12;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_START_3 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_START_3;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_START_3;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_STOP_FIRST_13 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_STOP_FIRST_13;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_STOP_FIRST_13;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


property wait_TRANSMITTING_STOP_SECOND_14 is
dependencies: no_reset;
freeze:
	data_at_t = data@t,
	txd_bit_at_t = txd_bit@t,
	txd_sig_at_t = txd_sig@t;
assume:
	at t: TRANSMITTING_STOP_SECOND_14;
	at t: not(txd_sync);
prove:
	at t+1: TRANSMITTING_STOP_SECOND_14;
	at t+1: data = data_at_t;
	at t+1: txd_bit = txd_bit_at_t;
	at t+1: txd_sig = txd_sig_at_t;
	at t+1: data_in_notify_notify = false;
	at t+1: events_out_notify = false;
	at t+1: txd_notify = true;
end property;


