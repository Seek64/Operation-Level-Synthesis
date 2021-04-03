--macro x_sync_i : boolean := x_sync_i end macro;
--macro z_sync_i : boolean := z_sync_i end macro;

--macro x_notify_o : unsigned := x_notify_o end macro;
--macro z_notify_o : unsigned := z_notify_o end macro;

--macro x_i : std_logic_vector := x_i end macro;
--macro z_o : std_logic_vector := z_o end macro;

-- CONSTRAINTS --
constraint no_reset := rst_i = '1'; end constraint;

-- STATES --
macro x_1 : boolean := (state_r = st_x_1) and (wait_r = '1') end macro;	
macro z_2 : boolean := (state_r = st_z_2) and (wait_r = '1') end macro;

macro active_op : unsigned := operation_r end macro;



