-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro master_in_sync : boolean := end macro;
-- macro master_out_sync : boolean := end macro;
-- macro slave_in0_sync : boolean := end macro;
-- macro slave_in1_sync : boolean := end macro;
-- macro slave_in2_sync : boolean := end macro;
-- macro slave_in3_sync : boolean := end macro;
-- macro slave_out0_sync : boolean := end macro;
-- macro slave_out1_sync : boolean := end macro;
-- macro slave_out2_sync : boolean := end macro;
-- macro slave_out3_sync : boolean := end macro;
-- macro master_in_notify : boolean := end macro;
-- macro master_out_notify : boolean := end macro;
-- macro slave_in0_notify : boolean := end macro;
-- macro slave_in1_notify : boolean := end macro;
-- macro slave_in2_notify : boolean := end macro;
-- macro slave_in3_notify : boolean := end macro;
-- macro slave_out0_notify : boolean := end macro;
-- macro slave_out1_notify : boolean := end macro;
-- macro slave_out2_notify : boolean := end macro;
-- macro slave_out3_notify : boolean := end macro;


-- DP SIGNALS --
-- macro master_in_sig : bus_req_t := master_in_sig end macro;
macro master_in_sig_addr : std_logic_vector := master_in_sig.addr end macro;
macro master_in_sig_data : std_logic_vector := master_in_sig.data end macro;
macro master_in_sig_trans_type : trans_t := master_in_sig.trans_type end macro;
-- macro master_out_sig : bus_resp_t := master_out_sig end macro;
macro master_out_sig_ack : ack_t := master_out_sig.ack end macro;
macro master_out_sig_data : std_logic_vector := master_out_sig.data end macro;
-- macro slave_in0_sig : bus_resp_t := slave_in0_sig end macro;
macro slave_in0_sig_ack : ack_t := slave_in0_sig.ack end macro;
macro slave_in0_sig_data : std_logic_vector := slave_in0_sig.data end macro;
-- macro slave_in1_sig : bus_resp_t := slave_in1_sig end macro;
macro slave_in1_sig_ack : ack_t := slave_in1_sig.ack end macro;
macro slave_in1_sig_data : std_logic_vector := slave_in1_sig.data end macro;
-- macro slave_in2_sig : bus_resp_t := slave_in2_sig end macro;
macro slave_in2_sig_ack : ack_t := slave_in2_sig.ack end macro;
macro slave_in2_sig_data : std_logic_vector := slave_in2_sig.data end macro;
-- macro slave_in3_sig : bus_resp_t := slave_in3_sig end macro;
macro slave_in3_sig_ack : ack_t := slave_in3_sig.ack end macro;
macro slave_in3_sig_data : std_logic_vector := slave_in3_sig.data end macro;
-- macro slave_out0_sig : bus_req_t := slave_out0_sig end macro;
macro slave_out0_sig_addr : std_logic_vector := slave_out0_sig.addr end macro;
macro slave_out0_sig_data : std_logic_vector := slave_out0_sig.data end macro;
macro slave_out0_sig_trans_type : trans_t := slave_out0_sig.trans_type end macro;
-- macro slave_out1_sig : bus_req_t := slave_out1_sig end macro;
macro slave_out1_sig_addr : std_logic_vector := slave_out1_sig.addr end macro;
macro slave_out1_sig_data : std_logic_vector := slave_out1_sig.data end macro;
macro slave_out1_sig_trans_type : trans_t := slave_out1_sig.trans_type end macro;
-- macro slave_out2_sig : bus_req_t := slave_out2_sig end macro;
macro slave_out2_sig_addr : std_logic_vector := slave_out2_sig.addr end macro;
macro slave_out2_sig_data : std_logic_vector := slave_out2_sig.data end macro;
macro slave_out2_sig_trans_type : trans_t := slave_out2_sig.trans_type end macro;
-- macro slave_out3_sig : bus_req_t := slave_out3_sig end macro;
macro slave_out3_sig_addr : std_logic_vector := slave_out3_sig.addr end macro;
macro slave_out3_sig_data : std_logic_vector := slave_out3_sig.data end macro;
macro slave_out3_sig_trans_type : trans_t := slave_out3_sig.trans_type end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '1'; end constraint;


-- VISIBLE REGISTERS --
macro req_trans_type : trans_t := req_reg.trans_type end macro;
macro resp_ack : ack_t := resp_reg.ack end macro;
macro resp_data : std_logic_vector := resp_reg.data end macro;


-- STATES --
macro master_in_1 : boolean := (active_state = st_master_in_1) and (wait_r = '1') end macro;
macro slave_out0_2 : boolean := (active_state = st_slave_out0_2) and (wait_r = '1') end macro;
macro slave_in0_3 : boolean := (active_state = st_slave_in0_3) and (wait_r = '1') end macro;
macro master_out_4 : boolean := (active_state = st_master_out_4) and (wait_r = '1') end macro;
macro slave_out1_5 : boolean := (active_state = st_slave_out1_5) and (wait_r = '1') end macro;
macro slave_in1_6 : boolean := (active_state = st_slave_in1_6) and (wait_r = '1') end macro;
macro slave_out2_7 : boolean := (active_state = st_slave_out2_7) and (wait_r = '1') end macro;
macro slave_in2_8 : boolean := (active_state = st_slave_in2_8) and (wait_r = '1') end macro;
macro slave_out3_9 : boolean := (active_state = st_slave_out3_9) and (wait_r = '1') end macro;
macro slave_in3_10 : boolean := (active_state = st_slave_in3_10) and (wait_r = '1') end macro;


