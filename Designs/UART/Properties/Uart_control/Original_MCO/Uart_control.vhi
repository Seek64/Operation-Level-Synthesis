-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: IDLE_1;
	 at t: bus_out_sig_data = resize(0,32);
	 at t: bus_out_sig_valid = false;
	 at t: enable = resize(0,32);
	 at t: error_src = resize(0,32);
	 at t: frame_config = resize(0,32);
	 at t: rts_internal = false;
	 at t: rts_out_sig = false;
	 at t: rx_active_out_msg = false;
	 at t: rx_active_out_sig = false;
	 at t: rx_config_out_sig_odd_parity = false;
	 at t: rx_config_out_sig_parity = false;
	 at t: rx_config_out_sig_two_stop_bits = false;
	 at t: tx_config_out_sig_odd_parity = false;
	 at t: tx_config_out_sig_parity = false;
	 at t: tx_config_out_sig_two_stop_bits = false;
	 at t: tx_control_out_msg_active = false;
	 at t: tx_control_out_msg_cts = true;
	 at t: tx_control_out_sig_active = false;
	 at t: tx_control_out_sig_cts = true;
	 at t: events_out_notify = false;
end property;


property IDLE_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t) or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_10 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_11 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t) or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_12 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
	at t: HWFC(frame_config);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_13 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t) or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_14 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_15 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t) or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_17 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = (error_src_at_t or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_18 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_19 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = (error_src_at_t or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_20 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
	at t: HWFC(frame_config);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_21 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = (error_src_at_t or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_22 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_23 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = (error_src_at_t or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_25 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = (error_src_at_t or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_26 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_27 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = (error_src_at_t or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_28 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
	at t: HWFC(frame_config);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_29 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = (error_src_at_t or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t) or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_30 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_31 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = (error_src_at_t or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_33 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_34 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_35 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_36 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
	at t: not((ENABLE_SET(enable) and HWFC(frame_config)));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_37 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_38 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_39 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
	at t: HWFC(frame_config);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_40 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_41 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_42 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_43 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_44 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
	at t: not((ENABLE_SET(enable) and HWFC(frame_config)));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_45 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_46 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_47 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_48 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_49 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t) or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_50 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_51 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_52 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
	at t: not((ENABLE_SET(enable) and HWFC(frame_config)));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_53 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_54 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_55 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_56 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_rx_at_t or (rx_active_out_msg_at_t and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (tasks_in_sig_start_tx_at_t or (tx_control_out_msg_active_at_t and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_57 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_58 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_59 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = false;
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = false;
	at t_end: events_out_sig_rxd_ready = false;
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_60 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
	at t: not((ENABLE_SET(enable) and HWFC(frame_config)));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_61 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_62 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: tx_events_in_sync;
	at t: not(rx_events_in_sync);
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_63 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: not(ENABLE_SET(enable));
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_64 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: not(bus_in_sync);
	at t: not(tasks_in_sync);
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: not(rx_events_in_sync);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = 0;
	at t_end: bus_out_sig_valid = false;
	at t_end: enable = enable_at_t;
	at t_end: error_src = error_src_at_t;
	at t_end: frame_config = frame_config_at_t;
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and rx_active_out_msg_at_t);
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: rx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_parity = PARITY(frame_config_at_t);
	at t_end: tx_config_out_sig_two_stop_bits = STOP(frame_config_at_t);
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and tx_control_out_msg_active_at_t);
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end]: events_out_notify = false;
end property;


property IDLE_1_7 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tasks_in_sig_start_rx_at_t = tasks_in_sig_start_rx@t,
	tasks_in_sig_start_tx_at_t = tasks_in_sig_start_tx@t,
	tasks_in_sig_stop_rx_at_t = tasks_in_sig_stop_rx@t,
	tasks_in_sig_stop_tx_at_t = tasks_in_sig_stop_tx@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: tasks_in_sync;
	at t: not(cts_in_sync);
	at t: not(tx_events_in_sync);
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t) or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = false;
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = false;
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = false;
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_rx_at_t) or ((rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_rx_at_t))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and (((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or tasks_in_sig_start_tx_at_t) or ((tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t)))) and not(tasks_in_sig_stop_tx_at_t))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


property IDLE_1_9 is
dependencies: no_reset;
for timepoints:
	t_end = t+t_min..t_max waits_for done_sig = '1';
freeze:
	bus_in_sig_addr_at_t = bus_in_sig_addr@t,
	bus_in_sig_data_at_t = bus_in_sig_data@t,
	bus_in_sig_trans_type_at_t = bus_in_sig_trans_type@t,
	cts_in_sig_at_t = cts_in_sig@t,
	enable_at_t = enable@t,
	error_src_at_t = error_src@t,
	frame_config_at_t = frame_config@t,
	rts_internal_at_t = rts_internal@t,
	rx_active_out_msg_at_t = rx_active_out_msg@t,
	rx_events_in_sig_error_src_at_t = rx_events_in_sig_error_src@t,
	rx_events_in_sig_ready_at_t = rx_events_in_sig_ready@t,
	rx_events_in_sig_timeout_at_t = rx_events_in_sig_timeout@t,
	tx_control_out_msg_active_at_t = tx_control_out_msg_active@t,
	tx_events_in_sig_done_at_t = tx_events_in_sig_done@t;
assume:
	at t: IDLE_1;
	at t: bus_in_sync;
	at t: not(tasks_in_sync);
	at t: cts_in_sync;
	at t: tx_events_in_sync;
	at t: rx_events_in_sync;
	at t: ENABLE_SET(enable);
prove:
	at t_end: IDLE_1;
	at t_end: bus_out_sig_data = (((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?frame_config_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?enable_at_t:(((bus_in_sig_trans_type_at_t = READ) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?error_src_at_t:0)));
	at t_end: bus_out_sig_valid = true;
	at t_end: enable = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ENABLE))?ENABLE_MASK(bus_in_sig_data_at_t):enable_at_t);
	at t_end: error_src = ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_ERROR_SRC))?ERROR_MASK((not(bus_in_sig_data_at_t) and error_src_at_t)):error_src_at_t) or rx_events_in_sig_error_src_at_t);
	at t_end: events_out_sig_cts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and not(cts_in_sig_at_t));
	at t_end: events_out_sig_error = (ENABLE_SET(enable_at_t) and not((rx_events_in_sig_error_src_at_t = 0)));
	at t_end: events_out_sig_ncts = ((ENABLE_SET(enable_at_t) and HWFC(frame_config_at_t)) and cts_in_sig_at_t);
	at t_end: events_out_sig_rx_timeout = (ENABLE_SET(enable_at_t) and rx_events_in_sig_timeout_at_t);
	at t_end: events_out_sig_rxd_ready = (ENABLE_SET(enable_at_t) and rx_events_in_sig_ready_at_t);
	at t_end: events_out_sig_txd_ready = (ENABLE_SET(enable_at_t) and tx_events_in_sig_done_at_t);
	at t_end: frame_config = (((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t);
	at t_end: rts_internal = rts_internal_at_t;
	at t_end: rts_out_sig = rts_internal_at_t;
	at t_end: rx_active_out_msg = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_active_out_sig = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_RX)) and TASK_MASK(bus_in_sig_data_at_t)) or (rx_active_out_msg_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_RX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: rx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: rx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_odd_parity = ODD_PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_parity = PARITY((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_config_out_sig_two_stop_bits = STOP((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_CONFIG))?CONFIG_MASK(bus_in_sig_data_at_t):frame_config_at_t));
	at t_end: tx_control_out_msg_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_msg_cts = false;
	at t_end: tx_control_out_sig_active = (ENABLE_SET(enable_at_t) and ((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_START_TX)) and TASK_MASK(bus_in_sig_data_at_t)) or (tx_control_out_msg_active_at_t and not((((bus_in_sig_trans_type_at_t = WRITE) and (bus_in_sig_addr_at_t = ADDR_TASKS_STOP_TX)) and TASK_MASK(bus_in_sig_data_at_t))))));
	at t_end: tx_control_out_sig_cts = false;
	during[t+1, t_end-1]: events_out_notify = false;
	at t_end: events_out_notify = true;
end property;


