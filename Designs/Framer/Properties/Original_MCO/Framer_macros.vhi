-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro data_word_sync : boolean := end macro;
-- macro frame_pulse_notify : boolean := end macro;


-- DP SIGNALS --
-- macro data_word_sig : marker_t := data_word_sig end macro;
macro data_word_sig_isMarker : boolean := data_word_sig.isMarker end macro;
macro data_word_sig_markerAlignment : std_logic_vector := data_word_sig.markerAlignment end macro;
-- macro frame_pulse_sig : boolean := frame_pulse_sig end macro;
-- macro lof_sig : boolean := lof_sig end macro;
-- macro oof_sig : boolean := oof_sig end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
-- macro FRM_PULSE_POS : std_logic_vector := FRM_PULSE_POS end macro;
-- macro WORDS_IN_FRAME : std_logic_vector := WORDS_IN_FRAME end macro;
-- macro align : std_logic_vector := align end macro;
-- macro frm_cnt : std_logic_vector := frm_cnt end macro;
-- macro nextphase : Phases := nextphase end macro;


-- STATES --
macro state_1 : boolean := active_state = st_state_1 and (ready_sig = '1' or idle_sig = '1') end macro;
macro state_2 : boolean := active_state = st_state_2 and (ready_sig = '1' or idle_sig = '1') end macro;
macro state_3 : boolean := active_state = st_state_3 and (ready_sig = '1' or idle_sig = '1') end macro;
macro state_4 : boolean := active_state = st_state_4 and (ready_sig = '1' or idle_sig = '1') end macro;


