-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: IDLE_1;
	 at t: agent_to_bus_req_trans_type = SINGLE_READ;
	 at t: agent_to_bus_resp_ack = OK;
	 at t: agent_to_bus_resp_data = resize(0,32);
	 at t: agent_to_bus_sig_addr = resize(0,32);
	 at t: agent_to_bus_sig_cyc = false;
	 at t: agent_to_bus_sig_data = resize(0,32);
	 at t: agent_to_bus_sig_stb = false;
	 at t: agent_to_bus_sig_we = false;
	 at t: nextsection = IDLE;
	 at t: section = IDLE;
	 at t: agent_to_master_notify = false;
	 at t: master_to_agent_notify = true;
end property;


property DONE_3_8 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	agent_to_bus_resp_ack_at_t = agent_to_bus_resp_ack@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t,
	agent_to_bus_sig_addr_at_t = agent_to_bus_sig_addr@t,
	agent_to_bus_sig_cyc_at_t = agent_to_bus_sig_cyc@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_stb_at_t = agent_to_bus_sig_stb@t,
	agent_to_bus_sig_we_at_t = agent_to_bus_sig_we@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t;
assume:
	at t: DONE_3;
	at t: not(bus_to_agent_sig_ack);
prove:
	at t_end: state_4;
	at t_end: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = agent_to_bus_resp_ack_at_t;
	at t_end: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t_end: agent_to_bus_sig_addr = agent_to_bus_sig_addr_at_t;
	at t_end: agent_to_bus_sig_cyc = agent_to_bus_sig_cyc_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_stb = agent_to_bus_sig_stb_at_t;
	at t_end: agent_to_bus_sig_we = agent_to_bus_sig_we_at_t;
	at t_end: agent_to_master_sig_ack = agent_to_bus_resp_ack_at_t;
	at t_end: agent_to_master_sig_data = agent_to_bus_resp_data_at_t;
	at t_end: nextsection = nextsection_at_t;
	at t_end: section = section_at_t;
	during[t+1, t_end-1]: agent_to_master_notify = false;
	at t_end: agent_to_master_notify = true;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property DONE_3_9 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	agent_to_bus_resp_ack_at_t = agent_to_bus_resp_ack@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t,
	agent_to_bus_sig_addr_at_t = agent_to_bus_sig_addr@t,
	agent_to_bus_sig_cyc_at_t = agent_to_bus_sig_cyc@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_stb_at_t = agent_to_bus_sig_stb@t,
	agent_to_bus_sig_we_at_t = agent_to_bus_sig_we@t,
	nextsection_at_t = nextsection@t;
assume:
	at t: DONE_3;
	at t: bus_to_agent_sig_ack;
	at t: (nextsection = DONE);
prove:
	at t_end: DONE_3;
	at t_end: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = agent_to_bus_resp_ack_at_t;
	at t_end: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t_end: agent_to_bus_sig_addr = agent_to_bus_sig_addr_at_t;
	at t_end: agent_to_bus_sig_cyc = agent_to_bus_sig_cyc_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_stb = agent_to_bus_sig_stb_at_t;
	at t_end: agent_to_bus_sig_we = agent_to_bus_sig_we_at_t;
	at t_end: nextsection = nextsection_at_t;
	at t_end: section = nextsection_at_t;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property IDLE_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	agent_to_bus_resp_ack_at_t = agent_to_bus_resp_ack@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t,
	master_to_agent_sig_addr_at_t = master_to_agent_sig_addr@t,
	master_to_agent_sig_trans_type_at_t = master_to_agent_sig_trans_type@t;
assume:
	at t: IDLE_1;
	at t: master_to_agent_sync;
	at t: (master_to_agent_sig_trans_type = SINGLE_READ);
	at t: not((section = READ));
	at t: not((section = WRITE));
	at t: not((section = WAITING));
	at t: not((section = DONE));
prove:
	at t_end: WAITING_2;
	at t_end: agent_to_bus_req_trans_type = master_to_agent_sig_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = agent_to_bus_resp_ack_at_t;
	at t_end: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t_end: agent_to_bus_sig_addr = master_to_agent_sig_addr_at_t;
	at t_end: agent_to_bus_sig_cyc = true;
	at t_end: agent_to_bus_sig_data = 0;
	at t_end: agent_to_bus_sig_stb = true;
	at t_end: agent_to_bus_sig_we = false;
	at t_end: nextsection = WAITING;
	at t_end: section = WAITING;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property IDLE_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	agent_to_bus_resp_ack_at_t = agent_to_bus_resp_ack@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t,
	master_to_agent_sig_addr_at_t = master_to_agent_sig_addr@t,
	master_to_agent_sig_data_at_t = master_to_agent_sig_data@t,
	master_to_agent_sig_trans_type_at_t = master_to_agent_sig_trans_type@t;
assume:
	at t: IDLE_1;
	at t: master_to_agent_sync;
	at t: not((master_to_agent_sig_trans_type = SINGLE_READ));
	at t: not((section = READ));
	at t: not((section = WRITE));
	at t: not((section = WAITING));
	at t: not((section = DONE));
prove:
	at t_end: WAITING_2;
	at t_end: agent_to_bus_req_trans_type = master_to_agent_sig_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = agent_to_bus_resp_ack_at_t;
	at t_end: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t_end: agent_to_bus_sig_addr = master_to_agent_sig_addr_at_t;
	at t_end: agent_to_bus_sig_cyc = true;
	at t_end: agent_to_bus_sig_data = master_to_agent_sig_data_at_t;
	at t_end: agent_to_bus_sig_stb = true;
	at t_end: agent_to_bus_sig_we = true;
	at t_end: nextsection = WAITING;
	at t_end: section = WAITING;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property WAITING_2_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	bus_to_agent_sig_data_at_t = bus_to_agent_sig_data@t;
assume:
	at t: WAITING_2;
	at t: bus_to_agent_sig_ack;
	at t: (agent_to_bus_req_trans_type = SINGLE_READ);
	at t: bus_to_agent_sig_err;
	at t: not((section = DONE));
prove:
	at t_end: DONE_3;
	at t_end: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = ERR;
	at t_end: agent_to_bus_resp_data = bus_to_agent_sig_data_at_t;
	at t_end: agent_to_bus_sig_addr = 0;
	at t_end: agent_to_bus_sig_cyc = false;
	at t_end: agent_to_bus_sig_data = 0;
	at t_end: agent_to_bus_sig_stb = false;
	at t_end: agent_to_bus_sig_we = false;
	at t_end: nextsection = DONE;
	at t_end: section = DONE;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property WAITING_2_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	bus_to_agent_sig_data_at_t = bus_to_agent_sig_data@t;
assume:
	at t: WAITING_2;
	at t: bus_to_agent_sig_ack;
	at t: (agent_to_bus_req_trans_type = SINGLE_READ);
	at t: not(bus_to_agent_sig_err);
	at t: not((section = DONE));
prove:
	at t_end: DONE_3;
	at t_end: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = OK;
	at t_end: agent_to_bus_resp_data = bus_to_agent_sig_data_at_t;
	at t_end: agent_to_bus_sig_addr = 0;
	at t_end: agent_to_bus_sig_cyc = false;
	at t_end: agent_to_bus_sig_data = 0;
	at t_end: agent_to_bus_sig_stb = false;
	at t_end: agent_to_bus_sig_we = false;
	at t_end: nextsection = DONE;
	at t_end: section = DONE;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property WAITING_2_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t;
assume:
	at t: WAITING_2;
	at t: bus_to_agent_sig_ack;
	at t: not((agent_to_bus_req_trans_type = SINGLE_READ));
	at t: bus_to_agent_sig_err;
	at t: not((section = DONE));
prove:
	at t_end: DONE_3;
	at t_end: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = ERR;
	at t_end: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t_end: agent_to_bus_sig_addr = 0;
	at t_end: agent_to_bus_sig_cyc = false;
	at t_end: agent_to_bus_sig_data = 0;
	at t_end: agent_to_bus_sig_stb = false;
	at t_end: agent_to_bus_sig_we = false;
	at t_end: nextsection = DONE;
	at t_end: section = DONE;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property WAITING_2_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t;
assume:
	at t: WAITING_2;
	at t: bus_to_agent_sig_ack;
	at t: not((agent_to_bus_req_trans_type = SINGLE_READ));
	at t: not(bus_to_agent_sig_err);
	at t: not((section = DONE));
prove:
	at t_end: DONE_3;
	at t_end: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = OK;
	at t_end: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t_end: agent_to_bus_sig_addr = 0;
	at t_end: agent_to_bus_sig_cyc = false;
	at t_end: agent_to_bus_sig_data = 0;
	at t_end: agent_to_bus_sig_stb = false;
	at t_end: agent_to_bus_sig_we = false;
	at t_end: nextsection = DONE;
	at t_end: section = DONE;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property WAITING_2_7 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	agent_to_bus_resp_ack_at_t = agent_to_bus_resp_ack@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t,
	agent_to_bus_sig_addr_at_t = agent_to_bus_sig_addr@t,
	agent_to_bus_sig_cyc_at_t = agent_to_bus_sig_cyc@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_stb_at_t = agent_to_bus_sig_stb@t,
	agent_to_bus_sig_we_at_t = agent_to_bus_sig_we@t,
	nextsection_at_t = nextsection@t;
assume:
	at t: WAITING_2;
	at t: not(bus_to_agent_sig_ack);
	at t: not((section = DONE));
	at t: (nextsection = WAITING);
prove:
	at t_end: WAITING_2;
	at t_end: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = agent_to_bus_resp_ack_at_t;
	at t_end: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t_end: agent_to_bus_sig_addr = agent_to_bus_sig_addr_at_t;
	at t_end: agent_to_bus_sig_cyc = agent_to_bus_sig_cyc_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_stb = agent_to_bus_sig_stb_at_t;
	at t_end: agent_to_bus_sig_we = agent_to_bus_sig_we_at_t;
	at t_end: nextsection = nextsection_at_t;
	at t_end: section = nextsection_at_t;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end]: master_to_agent_notify = false;
end property;


property state_4_10 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	agent_to_bus_resp_ack_at_t = agent_to_bus_resp_ack@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t,
	agent_to_bus_sig_addr_at_t = agent_to_bus_sig_addr@t,
	agent_to_bus_sig_cyc_at_t = agent_to_bus_sig_cyc@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_stb_at_t = agent_to_bus_sig_stb@t,
	agent_to_bus_sig_we_at_t = agent_to_bus_sig_we@t;
assume:
	at t: state_4;
	at t: agent_to_master_sync;
prove:
	at t_end: IDLE_1;
	at t_end: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t_end: agent_to_bus_resp_ack = agent_to_bus_resp_ack_at_t;
	at t_end: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t_end: agent_to_bus_sig_addr = agent_to_bus_sig_addr_at_t;
	at t_end: agent_to_bus_sig_cyc = agent_to_bus_sig_cyc_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_stb = agent_to_bus_sig_stb_at_t;
	at t_end: agent_to_bus_sig_we = agent_to_bus_sig_we_at_t;
	at t_end: nextsection = IDLE;
	at t_end: section = IDLE;
	during[t+1, t_end]: agent_to_master_notify = false;
	during[t+1, t_end-1]: master_to_agent_notify = false;
	at t_end: master_to_agent_notify = true;
end property;


property wait_IDLE_1 is
dependencies: no_reset;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	agent_to_bus_resp_ack_at_t = agent_to_bus_resp_ack@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t,
	agent_to_bus_sig_addr_at_t = agent_to_bus_sig_addr@t,
	agent_to_bus_sig_cyc_at_t = agent_to_bus_sig_cyc@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_stb_at_t = agent_to_bus_sig_stb@t,
	agent_to_bus_sig_we_at_t = agent_to_bus_sig_we@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t;
assume:
	at t: IDLE_1;
	at t: not(master_to_agent_sync);
prove:
	at t+1: IDLE_1;
	at t+1: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t+1: agent_to_bus_resp_ack = agent_to_bus_resp_ack_at_t;
	at t+1: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t+1: agent_to_bus_sig_addr = agent_to_bus_sig_addr_at_t;
	at t+1: agent_to_bus_sig_cyc = agent_to_bus_sig_cyc_at_t;
	at t+1: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t+1: agent_to_bus_sig_stb = agent_to_bus_sig_stb_at_t;
	at t+1: agent_to_bus_sig_we = agent_to_bus_sig_we_at_t;
	at t+1: nextsection = nextsection_at_t;
	at t+1: section = section_at_t;
	at t+1: agent_to_master_notify = false;
	at t+1: master_to_agent_notify = true;
end property;


property wait_state_4 is
dependencies: no_reset;
freeze:
	agent_to_bus_req_trans_type_at_t = agent_to_bus_req_trans_type@t,
	agent_to_bus_resp_ack_at_t = agent_to_bus_resp_ack@t,
	agent_to_bus_resp_data_at_t = agent_to_bus_resp_data@t,
	agent_to_bus_sig_addr_at_t = agent_to_bus_sig_addr@t,
	agent_to_bus_sig_cyc_at_t = agent_to_bus_sig_cyc@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_stb_at_t = agent_to_bus_sig_stb@t,
	agent_to_bus_sig_we_at_t = agent_to_bus_sig_we@t,
	agent_to_master_sig_at_t = agent_to_master_sig@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t;
assume:
	at t: state_4;
	at t: not(agent_to_master_sync);
prove:
	at t+1: state_4;
	at t+1: agent_to_bus_req_trans_type = agent_to_bus_req_trans_type_at_t;
	at t+1: agent_to_bus_resp_ack = agent_to_bus_resp_ack_at_t;
	at t+1: agent_to_bus_resp_data = agent_to_bus_resp_data_at_t;
	at t+1: agent_to_bus_sig_addr = agent_to_bus_sig_addr_at_t;
	at t+1: agent_to_bus_sig_cyc = agent_to_bus_sig_cyc_at_t;
	at t+1: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t+1: agent_to_bus_sig_stb = agent_to_bus_sig_stb_at_t;
	at t+1: agent_to_bus_sig_we = agent_to_bus_sig_we_at_t;
	at t+1: agent_to_master_sig = agent_to_master_sig_at_t;
	at t+1: nextsection = nextsection_at_t;
	at t+1: section = section_at_t;
	at t+1: agent_to_master_notify = true;
	at t+1: master_to_agent_notify = false;
end property;
