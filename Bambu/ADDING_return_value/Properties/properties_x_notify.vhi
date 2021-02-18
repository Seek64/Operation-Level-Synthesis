-- OPERATIONS --
/*property reset is
assume:
	 reset_sequence;
prove:
	 at t: x_1;
	-- at t: xx = resize(0,32);
	-- at t: x_notify = 1;
	 at t: active_state = st_x_1;
--	 at t: y_notify = 0;
	 at t: active_state /= st_y_2;
--	 at t: z_notify = 0;
	 at t: active_state /= st_z_3;
end property;*/

property x_notify_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+0;
--freeze:
--	x_sig_at_t = x_sig@t;
assume:
	at t: active_operation = 0;
	at t: start_port = 1;	
--	during[t, t_end]: reset = 1;
--	at t_end: done_port = 1;

prove:
	at t_end: return_port = false;
	at t_end: done_port = 1;
end property;

property x_notify_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+0;
--freeze:
--	x_sig_at_t = x_sig@t;
assume:
	at t: active_operation = 1;
	at t: start_port = 1;	
--	during[t, t_end]: reset = 1;
--	at t_end: done_port = 1;

prove:
	at t_end: return_port = true;
	at t_end: done_port = 1;
end property;

property x_notify_wait is
dependencies: no_reset;
for timepoints:
	t_end = t+0;
--freeze:
--	x_sig_at_t = x_sig@t;
assume:
	at t: active_operation = 3;
--	at t: start_port = 1;	
--	during[t, t_end]: reset = 1;
--	at t_end: done_port = 1;

prove:
	at t_end: return_port = 1;
--	at t_end: done_port = 1;
end property;