-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: IDLE_1;
	 at t: agent_to_bus_sig_ack = false;
	 at t: agent_to_bus_sig_data = resize(0,32);
	 at t: agent_to_bus_sig_err = false;
	 at t: nextsection = IDLE;
	 at t: section = IDLE;
	 at t: slave_to_agent_resp_ack = OK;
	 at t: slave_to_agent_resp_data = resize(0,32);
	 at t: agent_to_slave_notify = false;
	 at t: slave_to_agent_notify = false;
end property;


property DONE_6_10 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	nextsection_at_t = nextsection@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: DONE_6;
	at t: not((not(bus_to_agent_sig_cyc) and not(bus_to_agent_sig_stb)));
	at t: bus_to_agent_sig_we;
	at t: (nextsection = DONE);
prove:
	at t_end: DONE_6;
	at t_end: agent_to_bus_sig_ack = true;
	at t_end: agent_to_bus_sig_data = 0;
	at t_end: agent_to_bus_sig_err = not((slave_to_agent_resp_ack_at_t = OK));
	at t_end: nextsection = nextsection_at_t;
	at t_end: section = nextsection_at_t;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	during[t+1, t_end]: agent_to_slave_notify = false;
	during[t+1, t_end]: slave_to_agent_notify = false;
end property;


property DONE_6_8 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: DONE_6;
	at t: not(bus_to_agent_sig_cyc);
	at t: not(bus_to_agent_sig_stb);
prove:
	at t_end: IDLE_1;
	at t_end: agent_to_bus_sig_ack = false;
	at t_end: agent_to_bus_sig_data = 0;
	at t_end: agent_to_bus_sig_err = false;
	at t_end: nextsection = IDLE;
	at t_end: section = IDLE;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	during[t+1, t_end]: agent_to_slave_notify = false;
	during[t+1, t_end]: slave_to_agent_notify = false;
end property;


property DONE_6_9 is
dependencies: no_reset;
for timepoints:
	t_end = t+2;
freeze:
	nextsection_at_t = nextsection@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: DONE_6;
	at t: not((not(bus_to_agent_sig_cyc) and not(bus_to_agent_sig_stb)));
	at t: not(bus_to_agent_sig_we);
	at t: (nextsection = DONE);
prove:
	at t_end: DONE_6;
	at t_end: agent_to_bus_sig_ack = true;
	at t_end: agent_to_bus_sig_data = slave_to_agent_resp_data_at_t;
	at t_end: agent_to_bus_sig_err = not((slave_to_agent_resp_ack_at_t = OK));
	at t_end: nextsection = nextsection_at_t;
	at t_end: section = nextsection_at_t;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	during[t+1, t_end]: agent_to_slave_notify = false;
	during[t+1, t_end]: slave_to_agent_notify = false;
end property;


property IDLE_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	bus_to_agent_sig_addr_at_t = bus_to_agent_sig_addr@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: IDLE_1;
	at t: bus_to_agent_sig_cyc;
	at t: bus_to_agent_sig_stb;
	at t: not(bus_to_agent_sig_we);
	at t: not((section = READ));
	at t: not((section = WRITE));
	at t: not((section = DONE));
prove:
	at t_end: state_2;
	at t_end: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t_end: agent_to_slave_sig_addr = bus_to_agent_sig_addr_at_t;
	at t_end: agent_to_slave_sig_data = 0;
	at t_end: agent_to_slave_sig_trans_type = SINGLE_READ;
	at t_end: nextsection = READ;
	at t_end: section = READ;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	during[t+1, t_end-1]: agent_to_slave_notify = false;
	at t_end: agent_to_slave_notify = true;
	during[t+1, t_end]: slave_to_agent_notify = false;
end property;


property IDLE_1_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	bus_to_agent_sig_addr_at_t = bus_to_agent_sig_addr@t,
	bus_to_agent_sig_data_at_t = bus_to_agent_sig_data@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: IDLE_1;
	at t: bus_to_agent_sig_cyc;
	at t: bus_to_agent_sig_stb;
	at t: bus_to_agent_sig_we;
	at t: not((section = READ));
	at t: not((section = WRITE));
	at t: not((section = DONE));
prove:
	at t_end: state_4;
	at t_end: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t_end: agent_to_slave_sig_addr = bus_to_agent_sig_addr_at_t;
	at t_end: agent_to_slave_sig_data = bus_to_agent_sig_data_at_t;
	at t_end: agent_to_slave_sig_trans_type = SINGLE_WRITE;
	at t_end: nextsection = WRITE;
	at t_end: section = WRITE;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	during[t+1, t_end-1]: agent_to_slave_notify = false;
	at t_end: agent_to_slave_notify = true;
	during[t+1, t_end]: slave_to_agent_notify = false;
end property;


property IDLE_1_3 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	nextsection_at_t = nextsection@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: IDLE_1;
	at t: not((bus_to_agent_sig_cyc and bus_to_agent_sig_stb));
	at t: not((section = READ));
	at t: not((section = WRITE));
	at t: not((section = DONE));
	at t: (nextsection = IDLE);
prove:
	at t_end: IDLE_1;
	at t_end: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t_end: nextsection = nextsection_at_t;
	at t_end: section = nextsection_at_t;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	during[t+1, t_end]: agent_to_slave_notify = false;
	during[t+1, t_end]: slave_to_agent_notify = false;
end property;


property state_2_4 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: state_2;
	at t: agent_to_slave_sync;
prove:
	at t_end: state_3;
	at t_end: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t_end: nextsection = nextsection_at_t;
	at t_end: section = section_at_t;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	during[t+1, t_end]: agent_to_slave_notify = false;
	during[t+1, t_end-1]: slave_to_agent_notify = false;
	at t_end: slave_to_agent_notify = true;
end property;


property state_3_5 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	slave_to_agent_sig_ack_at_t = slave_to_agent_sig_ack@t,
	slave_to_agent_sig_data_at_t = slave_to_agent_sig_data@t;
assume:
	at t: state_3;
	at t: slave_to_agent_sync;
	at t: not((section = WRITE));
	at t: not((section = DONE));
prove:
	at t_end: DONE_6;
	at t_end: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t_end: nextsection = DONE;
	at t_end: section = DONE;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_sig_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_sig_data_at_t;
	during[t+1, t_end]: agent_to_slave_notify = false;
	during[t+1, t_end]: slave_to_agent_notify = false;
end property;


property state_4_6 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: state_4;
	at t: agent_to_slave_sync;
prove:
	at t_end: state_5;
	at t_end: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t_end: nextsection = nextsection_at_t;
	at t_end: section = section_at_t;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t_end: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	during[t+1, t_end]: agent_to_slave_notify = false;
	during[t+1, t_end-1]: slave_to_agent_notify = false;
	at t_end: slave_to_agent_notify = true;
end property;


property state_5_7 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	slave_to_agent_sig_ack_at_t = slave_to_agent_sig_ack@t;
assume:
	at t: state_5;
	at t: slave_to_agent_sync;
	at t: not((section = DONE));
prove:
	at t_end: DONE_6;
	at t_end: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t_end: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t_end: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t_end: nextsection = DONE;
	at t_end: section = DONE;
	at t_end: slave_to_agent_resp_ack = slave_to_agent_sig_ack_at_t;
	at t_end: slave_to_agent_resp_data = 0;
	during[t+1, t_end]: agent_to_slave_notify = false;
	during[t+1, t_end]: slave_to_agent_notify = false;
end property;


property wait_state_2 is
dependencies: no_reset;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	agent_to_slave_sig_at_t = agent_to_slave_sig@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: state_2;
	at t: not(agent_to_slave_sync);
prove:
	at t+1: state_2;
	at t+1: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t+1: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t+1: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t+1: agent_to_slave_sig = agent_to_slave_sig_at_t;
	at t+1: nextsection = nextsection_at_t;
	at t+1: section = section_at_t;
	at t+1: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t+1: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	at t+1: agent_to_slave_notify = true;
	at t+1: slave_to_agent_notify = false;
end property;


property wait_state_3 is
dependencies: no_reset;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: state_3;
	at t: not(slave_to_agent_sync);
prove:
	at t+1: state_3;
	at t+1: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t+1: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t+1: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t+1: nextsection = nextsection_at_t;
	at t+1: section = section_at_t;
	at t+1: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t+1: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	at t+1: agent_to_slave_notify = false;
	at t+1: slave_to_agent_notify = true;
end property;


property wait_state_4 is
dependencies: no_reset;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	agent_to_slave_sig_at_t = agent_to_slave_sig@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: state_4;
	at t: not(agent_to_slave_sync);
prove:
	at t+1: state_4;
	at t+1: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t+1: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t+1: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t+1: agent_to_slave_sig = agent_to_slave_sig_at_t;
	at t+1: nextsection = nextsection_at_t;
	at t+1: section = section_at_t;
	at t+1: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t+1: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	at t+1: agent_to_slave_notify = true;
	at t+1: slave_to_agent_notify = false;
end property;


property wait_state_5 is
dependencies: no_reset;
freeze:
	agent_to_bus_sig_ack_at_t = agent_to_bus_sig_ack@t,
	agent_to_bus_sig_data_at_t = agent_to_bus_sig_data@t,
	agent_to_bus_sig_err_at_t = agent_to_bus_sig_err@t,
	nextsection_at_t = nextsection@t,
	section_at_t = section@t,
	slave_to_agent_resp_ack_at_t = slave_to_agent_resp_ack@t,
	slave_to_agent_resp_data_at_t = slave_to_agent_resp_data@t;
assume:
	at t: state_5;
	at t: not(slave_to_agent_sync);
prove:
	at t+1: state_5;
	at t+1: agent_to_bus_sig_ack = agent_to_bus_sig_ack_at_t;
	at t+1: agent_to_bus_sig_data = agent_to_bus_sig_data_at_t;
	at t+1: agent_to_bus_sig_err = agent_to_bus_sig_err_at_t;
	at t+1: nextsection = nextsection_at_t;
	at t+1: section = section_at_t;
	at t+1: slave_to_agent_resp_ack = slave_to_agent_resp_ack_at_t;
	at t+1: slave_to_agent_resp_data = slave_to_agent_resp_data_at_t;
	at t+1: agent_to_slave_notify = false;
	at t+1: slave_to_agent_notify = true;
end property;
