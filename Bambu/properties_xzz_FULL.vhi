-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
	 at t: x_1;
	 at t: x_notify_w = true;
	 at t: active_state = st_x_1;		
	 at t: z_notify_w = false;

end property;


property wait_x_1 is
dependencies: no_reset;
assume:
	at t: x_1;
	at t: not(x_sync);
prove:
	at t+1: x_1;			
	at t+1: x_notify_w = true;
	at t+1: z_notify_w = false;
end property;


property wait_z_2 is
dependencies: no_reset;
freeze:
	z_sig_at_t = z_sig_w@t;
assume:
	at t: z_2;
	at t: not(z_sync);
prove:
	at t+1: z_2;			
	at t+1: z_sig_w = z_sig_at_t;	
	at t+1: x_notify_w = false;	
	at t+1: z_notify_w = true;	

end property;

property x_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;		
freeze:
	x_sig_at_t = x_sig@t;
assume:
	at t: x_1;
	at t: x_sync;
prove:
	at t+1: z_2;		
	at t_end: z_sig_w = (2 * x_sig_at_t)(31 downto 0);
	during[t+1, t_end]: x_notify_w = 0;
	during[t+1, t_end-1]: z_notify_w = 0;
	at t_end: z_notify_w = 1;
end property;

property z_2_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+1;		
assume:
	at t: z_2;
	at t: z_sync;
prove:
	at t+1: x_1;		
	during[t+1, t_end-1]: x_notify_w = false;
	at t_end: x_notify_w = true;
	during[t+1, t_end]: z_notify_w = false;
end property;