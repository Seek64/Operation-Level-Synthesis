-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: IDLE_1;
	 at t: data_out_msg_data = resize(0,32);
	 at t: data_out_msg_valid = false;
	 at t: data_out_sig_valid = false;
	 at t: events_out_msg_error_src = resize(0,32);
	 at t: events_out_msg_ready = false;
	 at t: events_out_msg_timeout = false;
	 at t: first_stop_bit = false;
	 at t: parity = false;
	 at t: suspending_count = resize(0,32);
	 at t: timeout = true;
	 at t: wait_framing_break = false;
	 at t: events_out_notify = false;
	 at t: rxd_notify = true;
end property;


property GET_BIT_FIVE_7_23 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_FIVE_7;
	at t: rxd_sync;
prove:
	at t_end: GET_BIT_SIX_8;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,5,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_BIT_FOUR_6_22 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_FOUR_6;
	at t: rxd_sync;
prove:
	at t_end: GET_BIT_FIVE_7;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,4,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_BIT_ONE_3_19 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_ONE_3;
	at t: rxd_sync;
prove:
	at t_end: GET_BIT_TWO_4;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,1,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_BIT_SEVEN_9_25 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_SEVEN_9;
	at t: rxd_sync;
	at t: config_in_sig_parity;
prove:
	at t_end: GET_PARITY_BIT_10;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,7,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_BIT_SEVEN_9_26 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_SEVEN_9;
	at t: rxd_sync;
	at t: not(config_in_sig_parity);
prove:
	at t_end: GET_STOP_BIT_11;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,7,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = false;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_BIT_SIX_8_24 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_SIX_8;
	at t: rxd_sync;
prove:
	at t_end: GET_BIT_SEVEN_9;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,6,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_BIT_THREE_5_21 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_THREE_5;
	at t: rxd_sync;
prove:
	at t_end: GET_BIT_FOUR_6;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,3,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_BIT_TWO_4_20 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_TWO_4;
	at t: rxd_sync;
prove:
	at t_end: GET_BIT_THREE_5;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,2,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_BIT_ZERO_2_18 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_ZERO_2;
	at t: rxd_sync;
prove:
	at t_end: GET_BIT_ONE_3;
	at t_end: data_out_msg_data = update_data(data_out_msg_data_at_t,0,rxd_sig_at_t);
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_msg_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_PARITY_BIT_10_27 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_PARITY_BIT_10;
	at t: rxd_sync;
	at t: parity_not_correct(data_out_msg_data,config_in_sig_odd_parity,rxd_sig);
prove:
	at t_end: GET_STOP_BIT_11;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = ERROR_PARITY_MASK;
	at t_end: events_out_sig_ready = events_out_msg_ready_at_t;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = rxd_sig_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_PARITY_BIT_10_28 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_PARITY_BIT_10;
	at t: rxd_sync;
	at t: not(parity_not_correct(data_out_msg_data,config_in_sig_odd_parity,rxd_sig));
prove:
	at t_end: GET_STOP_BIT_11;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = rxd_sig_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_STOP_BIT_11_29 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_STOP_BIT_11;
	at t: rxd_sync;
	at t: not(rxd_sig);
	at t: config_in_sig_two_stop_bits;
prove:
	at t_end: GET_STOP_BIT_SECOND_12;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = ERROR_FRAMING_MASK;
	at t_end: events_out_sig_ready = events_out_msg_ready_at_t;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = rxd_sig_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_STOP_BIT_11_30 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_STOP_BIT_11;
	at t: rxd_sync;
	at t: not(rxd_sig);
	at t: not(config_in_sig_two_stop_bits);
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = true;
	at t_end: data_out_sig_valid = true;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = false;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = ERROR_FRAMING_MASK;
	at t_end: events_out_sig_ready = true;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = rxd_sig_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_STOP_BIT_11_31 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_STOP_BIT_11;
	at t: rxd_sync;
	at t: rxd_sig;
	at t: config_in_sig_two_stop_bits;
prove:
	at t_end: GET_STOP_BIT_SECOND_12;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = rxd_sig_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_STOP_BIT_11_32 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_STOP_BIT_11;
	at t: rxd_sync;
	at t: rxd_sig;
	at t: not(config_in_sig_two_stop_bits);
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = true;
	at t_end: data_out_sig_valid = true;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = false;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_sig_ready = true;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = rxd_sig_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_STOP_BIT_SECOND_12_33 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t;
assume:
	at t: GET_STOP_BIT_SECOND_12;
	at t: rxd_sync;
	at t: not(parity);
	at t: not(first_stop_bit);
	at t: not(rxd_sig);
	at t: (data_out_msg_data = resize(0,32));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = true;
	at t_end: data_out_sig_valid = true;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = false;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = ERROR_BREAK_MASK;
	at t_end: events_out_sig_ready = true;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = true;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_STOP_BIT_SECOND_12_34 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_STOP_BIT_SECOND_12;
	at t: rxd_sync;
	at t: not(((not(parity) and not(first_stop_bit)) and (data_out_msg_data = resize(0,32))));
	at t: not(rxd_sig);
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = true;
	at t_end: data_out_sig_valid = true;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = false;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = ERROR_FRAMING_MASK;
	at t_end: events_out_sig_ready = true;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property GET_STOP_BIT_SECOND_12_35 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_STOP_BIT_SECOND_12;
	at t: rxd_sync;
	at t: rxd_sig;
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = true;
	at t_end: data_out_sig_valid = true;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = false;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_sig_ready = true;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_10 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: data_out_sync_sig;
	at t: not(wait_framing_break);
	at t: not(rxd_sig);
prove:
	at t_end: GET_BIT_ZERO_2;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_11 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: data_out_sync_sig;
	at t: not((not(wait_framing_break) and not(rxd_sig)));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_14 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: not(data_out_sync_sig);
	at t: not(wait_framing_break);
	at t: not(rxd_sig);
	at t: data_out_msg_valid;
prove:
	at t_end: GET_BIT_ZERO_2;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = ERROR_OVERRUN_MASK;
	at t_end: events_out_sig_ready = events_out_msg_ready_at_t;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_15 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: not(data_out_sync_sig);
	at t: not(wait_framing_break);
	at t: not(rxd_sig);
	at t: not(data_out_msg_valid);
prove:
	at t_end: GET_BIT_ZERO_2;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_16 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: not(data_out_sync_sig);
	at t: not((not(wait_framing_break) and not(rxd_sig)));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = suspending_count_at_t;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_17 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	timeout_at_t = timeout@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: timeout;
	at t: not(control_active_in_sig);
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = 0;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = false;
	at t_end: parity = false;
	at t_end: suspending_count = 0;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: control_active_in_sig;
	at t: data_out_sync_sig;
	at t: not(wait_framing_break);
	at t: not(rxd_sig);
prove:
	at t_end: GET_BIT_ZERO_2;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = 0;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: control_active_in_sig;
	at t: data_out_sync_sig;
	at t: not((not(wait_framing_break) and not(rxd_sig)));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = 0;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_36 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: not(rxd_sync);
	at t: control_active_in_sig;
	at t: data_out_sync_sig;
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = 0;
	at t_end: timeout = false;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_39 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: not(rxd_sync);
	at t: control_active_in_sig;
	at t: not(data_out_sync_sig);
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = 0;
	at t_end: timeout = false;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_43 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: not(rxd_sync);
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: data_out_sync_sig;
	at t: (resize(39,32) <= (resize(1,32) + suspending_count)(31 downto 0));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = false;
	at t_end: events_out_sig_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_sig_ready = events_out_msg_ready_at_t;
	at t_end: events_out_sig_timeout = true;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = (1 + suspending_count_at_t)(31 downto 0);
	at t_end: timeout = true;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_44 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: not(rxd_sync);
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: data_out_sync_sig;
	at t: not((resize(39,32) <= (resize(1,32) + suspending_count)(31 downto 0)));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = (1 + suspending_count_at_t)(31 downto 0);
	at t_end: timeout = false;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_47 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: not(rxd_sync);
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: not(data_out_sync_sig);
	at t: (resize(39,32) <= (resize(1,32) + suspending_count)(31 downto 0));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = false;
	at t_end: events_out_sig_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_sig_ready = events_out_msg_ready_at_t;
	at t_end: events_out_sig_timeout = true;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = (1 + suspending_count_at_t)(31 downto 0);
	at t_end: timeout = true;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_48 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: not(rxd_sync);
	at t: not(timeout);
	at t: not(control_active_in_sig);
	at t: not(data_out_sync_sig);
	at t: not((resize(39,32) <= (resize(1,32) + suspending_count)(31 downto 0)));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = (1 + suspending_count_at_t)(31 downto 0);
	at t_end: timeout = false;
	at t_end: wait_framing_break = wait_framing_break_at_t;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: control_active_in_sig;
	at t: not(data_out_sync_sig);
	at t: not(wait_framing_break);
	at t: not(rxd_sig);
	at t: data_out_msg_valid;
prove:
	at t_end: GET_BIT_ZERO_2;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = 0;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: events_out_sig_error_src = ERROR_OVERRUN_MASK;
	at t_end: events_out_sig_ready = events_out_msg_ready_at_t;
	at t_end: events_out_sig_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = 0;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_52 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	timeout_at_t = timeout@t;
assume:
	at t: IDLE_1;
	at t: not(rxd_sync);
	at t: timeout;
	at t: not(control_active_in_sig);
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = 0;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = false;
	at t_end: parity = false;
	at t_end: suspending_count = 0;
	at t_end: timeout = timeout_at_t;
	at t_end: wait_framing_break = false;
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: control_active_in_sig;
	at t: not(data_out_sync_sig);
	at t: not(wait_framing_break);
	at t: not(rxd_sig);
	at t: not(data_out_msg_valid);
prove:
	at t_end: GET_BIT_ZERO_2;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = false;
	at t_end: data_out_sig_valid = false;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = 0;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property IDLE_1_7 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	rxd_sig_at_t = rxd_sig@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: IDLE_1;
	at t: rxd_sync;
	at t: control_active_in_sig;
	at t: not(data_out_sync_sig);
	at t: not((not(wait_framing_break) and not(rxd_sig)));
prove:
	at t_end: IDLE_1;
	at t_end: data_out_msg_data = data_out_msg_data_at_t;
	at t_end: data_out_msg_valid = data_out_msg_valid_at_t;
	at t_end: data_out_sig_valid = data_out_sig_valid_at_t;
	at t_end: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t_end: events_out_msg_ready = events_out_msg_ready_at_t;
	at t_end: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t_end: first_stop_bit = first_stop_bit_at_t;
	at t_end: parity = parity_at_t;
	at t_end: suspending_count = 0;
	at t_end: timeout = false;
	at t_end: wait_framing_break = (not(rxd_sig_at_t) and wait_framing_break_at_t);
	during[t+1, t_end]: events_out_notify = false;
	during[t+1, t_end-1]: rxd_notify = false;
	at t_end: rxd_notify = true;
end property;


property wait_GET_BIT_FIVE_7 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_FIVE_7;
	at t: not(rxd_sync);
prove:
	at t+1: GET_BIT_FIVE_7;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_BIT_FOUR_6 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_FOUR_6;
	at t: not(rxd_sync);
prove:
	at t+1: GET_BIT_FOUR_6;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_BIT_ONE_3 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_ONE_3;
	at t: not(rxd_sync);
prove:
	at t+1: GET_BIT_ONE_3;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_BIT_SEVEN_9 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_SEVEN_9;
	at t: not(rxd_sync);
prove:
	at t+1: GET_BIT_SEVEN_9;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_BIT_SIX_8 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_SIX_8;
	at t: not(rxd_sync);
prove:
	at t+1: GET_BIT_SIX_8;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_BIT_THREE_5 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_THREE_5;
	at t: not(rxd_sync);
prove:
	at t+1: GET_BIT_THREE_5;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_BIT_TWO_4 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_TWO_4;
	at t: not(rxd_sync);
prove:
	at t+1: GET_BIT_TWO_4;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_BIT_ZERO_2 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_BIT_ZERO_2;
	at t: not(rxd_sync);
prove:
	at t+1: GET_BIT_ZERO_2;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_PARITY_BIT_10 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_PARITY_BIT_10;
	at t: not(rxd_sync);
prove:
	at t+1: GET_PARITY_BIT_10;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_STOP_BIT_11 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_STOP_BIT_11;
	at t: not(rxd_sync);
prove:
	at t+1: GET_STOP_BIT_11;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


property wait_GET_STOP_BIT_SECOND_12 is
dependencies: no_reset;
freeze:
	data_out_msg_data_at_t = data_out_msg_data@t,
	data_out_msg_valid_at_t = data_out_msg_valid@t,
	data_out_sig_valid_at_t = data_out_sig_valid@t,
	events_out_msg_error_src_at_t = events_out_msg_error_src@t,
	events_out_msg_ready_at_t = events_out_msg_ready@t,
	events_out_msg_timeout_at_t = events_out_msg_timeout@t,
	first_stop_bit_at_t = first_stop_bit@t,
	parity_at_t = parity@t,
	suspending_count_at_t = suspending_count@t,
	timeout_at_t = timeout@t,
	wait_framing_break_at_t = wait_framing_break@t;
assume:
	at t: GET_STOP_BIT_SECOND_12;
	at t: not(rxd_sync);
prove:
	at t+1: GET_STOP_BIT_SECOND_12;
	at t+1: data_out_msg_data = data_out_msg_data_at_t;
	at t+1: data_out_msg_valid = data_out_msg_valid_at_t;
	at t+1: data_out_sig_valid = data_out_sig_valid_at_t;
	at t+1: events_out_msg_error_src = events_out_msg_error_src_at_t;
	at t+1: events_out_msg_ready = events_out_msg_ready_at_t;
	at t+1: events_out_msg_timeout = events_out_msg_timeout_at_t;
	at t+1: first_stop_bit = first_stop_bit_at_t;
	at t+1: parity = parity_at_t;
	at t+1: suspending_count = suspending_count_at_t;
	at t+1: timeout = timeout_at_t;
	at t+1: wait_framing_break = wait_framing_break_at_t;
	at t+1: events_out_notify = false;
	at t+1: rxd_notify = true;
end property;


