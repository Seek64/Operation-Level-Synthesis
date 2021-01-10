-- OPERATIONS --
/*property reset is
assume:
	 reset_sequence;
prove:
	 at t: active_operation = 0;
--	 at t: x_notify = 1;
--	 at t: active_state = st_x_1;		-------------------------
	 at t: return_port = 0;
end property;*/

property z_sig_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+0;
freeze:
	x_sig_at_t = x_sig@t;
assume:
	at t: active_operation = 0;
	at t: start_port = 1;	
--	during[t, t_end]: reset = 1;
--	at t_end: done_port = 1;

prove:
	at t_end: return_port (31 downto 0) = (x_sig_at_t + x_sig_at_t) (31 downto 0);
	at t_end: done_port = 1;
end property;

property z_sig_wait is
dependencies: no_reset;
for timepoints:
	t_end = t+0;
freeze:
	x_sig_at_t = x_sig@t;
assume:
	at t: active_operation /= 0;
--	at t: start_port = 1;	
--	during[t, t_end]: reset = 1;
--	at t_end: done_port = 1;

prove:
	at t_end: return_port = 0;
--	at t_end: done_port = 1;
end property;