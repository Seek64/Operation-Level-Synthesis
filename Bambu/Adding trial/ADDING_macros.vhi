-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro x_sync : boolean := end macro;
-- macro z_sync : boolean := end macro;


/* macro x_notify_default : boolean := true end macro;
 macro z_notify_default : boolean := false end macro;

 --macro x_notify_p : boolean := x_notify_w end macro;
 --macro z_notify_p : boolean := z_notify_w end macro;


macro x_notify_p : boolean :=
if (rst) then
 x_notify_default;
elsif (not (rst))then
not (x_notify_default);
end if;
end macro;

 macro z_notify_p : boolean :=
if (rst) then
 z_notify_default;
elsif (not (rst)) then
not(x_notify_default);
end if;
end macro;
*/

-- DP SIGNALS --
-- macro x_sig : std_logic_vector := x_sig end macro;
-- macro z_sig : std_logic_vector := z_sig end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '1'; end constraint;
constraint reset_state := active_operation = 2; end constraint;



-- VISIBLE REGISTERS --


-- STATES --
macro x_1 : boolean := active_state = st_x_1 end macro;	-- active_state is a signal from the wrapper
macro z_2 : boolean := active_state = st_z_2 end macro;

macro active_op : unsigned := active_operation end macro;



