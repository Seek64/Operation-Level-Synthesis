-- OPERATIONS --
property reset is
assume:
	 reset_sequence;
prove:
        --at t: state_r = st_x_1;
        --at t: operation_r = op_state_wait;
        --at t: start_r = '0';
        --at t: wait_r = '1';

	at t: x_1;
	at t: x_notify_o = true;
	at t: state_r = st_x_1;		
	at t: z_notify_o = false;

end property;


property wait_x_1 is
dependencies: no_reset;
assume:
	at t: x_1;
	at t: not(x_sync_i);
prove:
        --at t+1: state_r = st_x_1;
        --at t+1: operation_r = op_state_wait;
        --at t+1: start_r = '0';
        --at t+1: wait_r = '1';

	at t+1: x_1;			
	at t+1: x_notify_o = true;
	at t+1: z_notify_o = false;
end property;


property wait_z_2 is
dependencies: no_reset;
freeze:
	z_o_at_t = z_o@t;
assume:
	at t: z_2;
	at t: not(z_sync_i);
prove:
        --at t+1: state_r = st_z_2;
        --at t+1: operation_r = op_state_wait;
        --at t+1: start_r = '0';
        --at t+1: wait_r = '1';

	at t+1: z_2;			
	at t+1: z_o = z_o_at_t;	
	at t+1: x_notify_o = false;	
	at t+1: z_notify_o = true;	

end property;

property x_1_1 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;		
freeze:
	x_i_at_t = x_i@t;
assume:
	at t: x_1;
	at t: x_sync_i;

prove:
        --at t+3: state_r = st_z_2;
        --at t+1: operation_r = op_x_1_1;
        --at t+1: start_r = '1';
        --at t+2: start_r = '0';
        --at t+3: start_r = '0';
        --at t+1: wait_r = '0';
        --at t+2: wait_r = '0';
        --at t+3: wait_r = '1';

	at t_end: z_2;		
	at t_end: z_o = (2 * x_i_at_t)(31 downto 0);
	during[t+1, t_end]: x_notify_o = 0;
	during[t+1, t_end-1]: z_notify_o = 0;
	at t_end: z_notify_o = 1;
end property;

property z_2_2 is
dependencies: no_reset;
for timepoints:
	t_end = t+3;		
assume:
	at t: z_2;
	at t: z_sync_i;

prove:
        --at t+3: state_r = st_x_1;
        --at t+1: operation_r = op_z_2_2;
        --at t+1: start_r = '1';
        --at t+2: start_r = '0';
        --at t+3: start_r = '0';
        --at t+1: wait_r = '0';
        --at t+2: wait_r = '0';
        --at t+3: wait_r = '1';

	at t_end: x_1;		
	during[t+1, t_end-1]: x_notify_o = false;
	at t_end: x_notify_o = true;
	during[t+1, t_end]: z_notify_o = false;
end property;