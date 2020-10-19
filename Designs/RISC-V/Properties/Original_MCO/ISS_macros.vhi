-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
-- macro fromMemoryPort_sync : boolean := end macro;
-- macro toMemoryPort_sync : boolean := end macro;
-- macro fromMemoryPort_notify : boolean := end macro;
-- macro toMemoryPort_notify : boolean := end macro;
-- macro toRegsPort_notify : boolean := end macro;


-- DP SIGNALS --
-- macro fromMemoryPort_sig : MEtoCU_IF := fromMemoryPort_sig end macro;
macro fromMemoryPort_sig_loadedData : std_logic_vector := fromMemoryPort_sig.loadedData end macro;
-- macro fromRegsPort_sig : RegfileType := fromRegsPort_sig end macro;
macro fromRegsPort_sig_reg_file_01 : std_logic_vector := fromRegsPort_sig.reg_file_01 end macro;
macro fromRegsPort_sig_reg_file_02 : std_logic_vector := fromRegsPort_sig.reg_file_02 end macro;
macro fromRegsPort_sig_reg_file_03 : std_logic_vector := fromRegsPort_sig.reg_file_03 end macro;
macro fromRegsPort_sig_reg_file_04 : std_logic_vector := fromRegsPort_sig.reg_file_04 end macro;
macro fromRegsPort_sig_reg_file_05 : std_logic_vector := fromRegsPort_sig.reg_file_05 end macro;
macro fromRegsPort_sig_reg_file_06 : std_logic_vector := fromRegsPort_sig.reg_file_06 end macro;
macro fromRegsPort_sig_reg_file_07 : std_logic_vector := fromRegsPort_sig.reg_file_07 end macro;
macro fromRegsPort_sig_reg_file_08 : std_logic_vector := fromRegsPort_sig.reg_file_08 end macro;
macro fromRegsPort_sig_reg_file_09 : std_logic_vector := fromRegsPort_sig.reg_file_09 end macro;
macro fromRegsPort_sig_reg_file_10 : std_logic_vector := fromRegsPort_sig.reg_file_10 end macro;
macro fromRegsPort_sig_reg_file_11 : std_logic_vector := fromRegsPort_sig.reg_file_11 end macro;
macro fromRegsPort_sig_reg_file_12 : std_logic_vector := fromRegsPort_sig.reg_file_12 end macro;
macro fromRegsPort_sig_reg_file_13 : std_logic_vector := fromRegsPort_sig.reg_file_13 end macro;
macro fromRegsPort_sig_reg_file_14 : std_logic_vector := fromRegsPort_sig.reg_file_14 end macro;
macro fromRegsPort_sig_reg_file_15 : std_logic_vector := fromRegsPort_sig.reg_file_15 end macro;
macro fromRegsPort_sig_reg_file_16 : std_logic_vector := fromRegsPort_sig.reg_file_16 end macro;
macro fromRegsPort_sig_reg_file_17 : std_logic_vector := fromRegsPort_sig.reg_file_17 end macro;
macro fromRegsPort_sig_reg_file_18 : std_logic_vector := fromRegsPort_sig.reg_file_18 end macro;
macro fromRegsPort_sig_reg_file_19 : std_logic_vector := fromRegsPort_sig.reg_file_19 end macro;
macro fromRegsPort_sig_reg_file_20 : std_logic_vector := fromRegsPort_sig.reg_file_20 end macro;
macro fromRegsPort_sig_reg_file_21 : std_logic_vector := fromRegsPort_sig.reg_file_21 end macro;
macro fromRegsPort_sig_reg_file_22 : std_logic_vector := fromRegsPort_sig.reg_file_22 end macro;
macro fromRegsPort_sig_reg_file_23 : std_logic_vector := fromRegsPort_sig.reg_file_23 end macro;
macro fromRegsPort_sig_reg_file_24 : std_logic_vector := fromRegsPort_sig.reg_file_24 end macro;
macro fromRegsPort_sig_reg_file_25 : std_logic_vector := fromRegsPort_sig.reg_file_25 end macro;
macro fromRegsPort_sig_reg_file_26 : std_logic_vector := fromRegsPort_sig.reg_file_26 end macro;
macro fromRegsPort_sig_reg_file_27 : std_logic_vector := fromRegsPort_sig.reg_file_27 end macro;
macro fromRegsPort_sig_reg_file_28 : std_logic_vector := fromRegsPort_sig.reg_file_28 end macro;
macro fromRegsPort_sig_reg_file_29 : std_logic_vector := fromRegsPort_sig.reg_file_29 end macro;
macro fromRegsPort_sig_reg_file_30 : std_logic_vector := fromRegsPort_sig.reg_file_30 end macro;
macro fromRegsPort_sig_reg_file_31 : std_logic_vector := fromRegsPort_sig.reg_file_31 end macro;
-- macro toMemoryPort_sig : CUtoME_IF := toMemoryPort_sig end macro;
macro toMemoryPort_sig_addrIn : std_logic_vector := toMemoryPort_sig.addrIn end macro;
macro toMemoryPort_sig_dataIn : std_logic_vector := toMemoryPort_sig.dataIn end macro;
macro toMemoryPort_sig_mask : ME_MaskType := toMemoryPort_sig.mask end macro;
macro toMemoryPort_sig_req : ME_AccessType := toMemoryPort_sig.req end macro;
-- macro toRegsPort_sig : RegfileWriteType := toRegsPort_sig end macro;
macro toRegsPort_sig_dst : std_logic_vector := toRegsPort_sig.dst end macro;
macro toRegsPort_sig_dstData : std_logic_vector := toRegsPort_sig.dstData end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
-- macro pcReg : std_logic_vector := pcReg end macro;
macro regfileWrite_dst : std_logic_vector := regfileWrite.dst end macro;
macro regfileWrite_dstData : std_logic_vector := regfileWrite.dstData end macro;


-- STATES --
macro state_1 : boolean := active_state = st_state_1 and (ready_sig = '1' or idle_sig = '1') end macro;
macro state_2 : boolean := active_state = st_state_2 and (ready_sig = '1' or idle_sig = '1') end macro;
macro state_3 : boolean := active_state = st_state_3 and (ready_sig = '1' or idle_sig = '1') end macro;
macro state_4 : boolean := active_state = st_state_4 and (ready_sig = '1' or idle_sig = '1') end macro;
macro state_5 : boolean := active_state = st_state_5 and (ready_sig = '1' or idle_sig = '1') end macro;
macro state_6 : boolean := active_state = st_state_6 and (ready_sig = '1' or idle_sig = '1') end macro;

macro t_min : unsigned := 2; end macro;
macro t_max : unsigned := 7; end macro;
