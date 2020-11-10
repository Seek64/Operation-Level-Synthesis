-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --


-- DP SIGNALS --
-- macro master_input_sig : master_signals := master_input_sig end macro;
macro master_input_sig_addr : std_logic_vector := master_input_sig.addr end macro;
macro master_input_sig_cyc : boolean := master_input_sig.cyc end macro;
macro master_input_sig_data : std_logic_vector := master_input_sig.data end macro;
macro master_input_sig_stb : boolean := master_input_sig.stb end macro;
macro master_input_sig_we : boolean := master_input_sig.we end macro;
-- macro master_output_sig : slave_signals := master_output_sig end macro;
macro master_output_sig_ack : boolean := master_output_sig.ack end macro;
macro master_output_sig_data : std_logic_vector := master_output_sig.data end macro;
macro master_output_sig_err : boolean := master_output_sig.err end macro;
-- macro slave_in0_sig : slave_signals := slave_in0_sig end macro;
macro slave_in0_sig_ack : boolean := slave_in0_sig.ack end macro;
macro slave_in0_sig_data : std_logic_vector := slave_in0_sig.data end macro;
macro slave_in0_sig_err : boolean := slave_in0_sig.err end macro;
-- macro slave_in1_sig : slave_signals := slave_in1_sig end macro;
macro slave_in1_sig_ack : boolean := slave_in1_sig.ack end macro;
macro slave_in1_sig_data : std_logic_vector := slave_in1_sig.data end macro;
macro slave_in1_sig_err : boolean := slave_in1_sig.err end macro;
-- macro slave_in2_sig : slave_signals := slave_in2_sig end macro;
macro slave_in2_sig_ack : boolean := slave_in2_sig.ack end macro;
macro slave_in2_sig_data : std_logic_vector := slave_in2_sig.data end macro;
macro slave_in2_sig_err : boolean := slave_in2_sig.err end macro;
-- macro slave_in3_sig : slave_signals := slave_in3_sig end macro;
macro slave_in3_sig_ack : boolean := slave_in3_sig.ack end macro;
macro slave_in3_sig_data : std_logic_vector := slave_in3_sig.data end macro;
macro slave_in3_sig_err : boolean := slave_in3_sig.err end macro;
-- macro slave_out0_sig : master_signals := slave_out0_sig end macro;
macro slave_out0_sig_addr : std_logic_vector := slave_out0_sig.addr end macro;
macro slave_out0_sig_cyc : boolean := slave_out0_sig.cyc end macro;
macro slave_out0_sig_data : std_logic_vector := slave_out0_sig.data end macro;
macro slave_out0_sig_stb : boolean := slave_out0_sig.stb end macro;
macro slave_out0_sig_we : boolean := slave_out0_sig.we end macro;
-- macro slave_out1_sig : master_signals := slave_out1_sig end macro;
macro slave_out1_sig_addr : std_logic_vector := slave_out1_sig.addr end macro;
macro slave_out1_sig_cyc : boolean := slave_out1_sig.cyc end macro;
macro slave_out1_sig_data : std_logic_vector := slave_out1_sig.data end macro;
macro slave_out1_sig_stb : boolean := slave_out1_sig.stb end macro;
macro slave_out1_sig_we : boolean := slave_out1_sig.we end macro;
-- macro slave_out2_sig : master_signals := slave_out2_sig end macro;
macro slave_out2_sig_addr : std_logic_vector := slave_out2_sig.addr end macro;
macro slave_out2_sig_cyc : boolean := slave_out2_sig.cyc end macro;
macro slave_out2_sig_data : std_logic_vector := slave_out2_sig.data end macro;
macro slave_out2_sig_stb : boolean := slave_out2_sig.stb end macro;
macro slave_out2_sig_we : boolean := slave_out2_sig.we end macro;
-- macro slave_out3_sig : master_signals := slave_out3_sig end macro;
macro slave_out3_sig_addr : std_logic_vector := slave_out3_sig.addr end macro;
macro slave_out3_sig_cyc : boolean := slave_out3_sig.cyc end macro;
macro slave_out3_sig_data : std_logic_vector := slave_out3_sig.data end macro;
macro slave_out3_sig_stb : boolean := slave_out3_sig.stb end macro;
macro slave_out3_sig_we : boolean := slave_out3_sig.we end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro from_master_addr : std_logic_vector := from_master.addr end macro;
macro from_master_cyc : boolean := from_master.cyc end macro;
macro from_master_data : std_logic_vector := from_master.data end macro;
macro from_master_stb : boolean := from_master.stb end macro;
macro from_master_we : boolean := from_master.we end macro;
-- macro nextsection : Sections := nextsection end macro;
-- macro section : Sections := section end macro;
-- macro slave_number : std_logic_vector := slave_number end macro;
macro to_master_ack : boolean := to_master.ack end macro;
macro to_master_data : std_logic_vector := to_master.data end macro;
macro to_master_err : boolean := to_master.err end macro;


-- STATES --
macro state_1 : boolean := active_state = st_state_1 end macro;
macro state_2 : boolean := active_state = st_state_2 end macro;
macro state_3 : boolean := active_state = st_state_3 end macro;


