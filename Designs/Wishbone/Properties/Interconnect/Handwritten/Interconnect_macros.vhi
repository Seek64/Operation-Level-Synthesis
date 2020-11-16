-- DP SIGNALS --
-- macro master_input_sig : master_signals := master_input_sig end macro;
macro master_input_sig_addr : integer := master_in.addr; end macro;
macro master_input_sig_cyc  : boolean := master_in.cyc;  end macro;
macro master_input_sig_data : integer := master_in.data; end macro;
macro master_input_sig_stb  : boolean := master_in.stb;  end macro;
macro master_input_sig_we   : boolean := master_in.we;   end macro;

-- macro master_output_sig : slave_signals := master_output_sig end macro;
macro master_output_sig_ack  : boolean := master_out.ack;  end macro;
macro master_output_sig_data : integer := master_out.data; end macro;
macro master_output_sig_err  : boolean := master_out.err;  end macro;

-- macro slave_in0_sig : slave_signals := slave_in0_sig end macro;
macro slave_in0_sig_ack  : boolean := slave_in0.ack;  end macro;
macro slave_in0_sig_data : integer := slave_in0.data; end macro;
macro slave_in0_sig_err  : boolean := slave_in0.err;  end macro;

-- macro slave_in1_sig : slave_signals := slave_in1_sig end macro;
macro slave_in1_sig_ack  : boolean := slave_in1.ack;  end macro;
macro slave_in1_sig_data : integer := slave_in1.data; end macro;
macro slave_in1_sig_err  : boolean := slave_in1.err;  end macro;

-- macro slave_in2_sig : slave_signals := slave_in2_sig end macro;
macro slave_in2_sig_ack  : boolean := slave_in2.ack;  end macro;
macro slave_in2_sig_data : integer := slave_in2.data; end macro;
macro slave_in2_sig_err  : boolean := slave_in2.err;  end macro;

-- macro slave_in3_sig : slave_signals := slave_in3_sig end macro;
macro slave_in3_sig_ack  : boolean := slave_in3.ack;  end macro;
macro slave_in3_sig_data : integer := slave_in3.data; end macro;
macro slave_in3_sig_err  : boolean := slave_in3.err;  end macro;

-- macro slave_out0_sig : master_signals := slave_out0_sig end macro;
macro slave_out0_sig_addr : integer := slave_out0.addr; end macro;
macro slave_out0_sig_cyc  : boolean := slave_out0.cyc;  end macro;
macro slave_out0_sig_data : integer := slave_out0.data; end macro;
macro slave_out0_sig_stb  : boolean := slave_out0.stb;  end macro;
macro slave_out0_sig_we   : boolean := slave_out0.we;   end macro;

-- macro slave_out1_sig : master_signals := slave_out1_sig end macro;
macro slave_out1_sig_addr : integer := slave_out1.addr; end macro;
macro slave_out1_sig_cyc  : boolean := slave_out1.cyc;  end macro;
macro slave_out1_sig_data : integer := slave_out1.data; end macro;
macro slave_out1_sig_stb  : boolean := slave_out1.stb;  end macro;
macro slave_out1_sig_we   : boolean := slave_out1.we;   end macro;

-- macro slave_out2_sig : master_signals := slave_out2_sig end macro;
macro slave_out2_sig_addr : integer := slave_out2.addr; end macro;
macro slave_out2_sig_cyc  : boolean := slave_out2.cyc;  end macro;
macro slave_out2_sig_data : integer := slave_out2.data; end macro;
macro slave_out2_sig_stb  : boolean := slave_out2.stb;  end macro;
macro slave_out2_sig_we   : boolean := slave_out2.we;   end macro;

-- macro slave_out3_sig   : master_signals := slave_out3_sig end macro;
macro slave_out3_sig_addr : integer := slave_out3.addr; end macro;
macro slave_out3_sig_cyc  : boolean := slave_out3.cyc;  end macro;
macro slave_out3_sig_data : integer := slave_out3.data; end macro;
macro slave_out3_sig_stb  : boolean := slave_out3.stb;  end macro;
macro slave_out3_sig_we   : boolean := slave_out3.we;   end macro;


-- CONSTRAINTS --
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro from_master_addr : integer := from_master_signal.addr; end macro;
macro from_master_cyc  : boolean := from_master_signal.cyc;  end macro;
macro from_master_data : integer := from_master_signal.data; end macro;
macro from_master_stb  : boolean := from_master_signal.stb;  end macro;
macro from_master_we   : boolean := from_master_signal.we;   end macro;

macro nextsection : Interconnect_SECTIONS := section; end macro;
-- macro section : Sections := section end macro;

macro slave_number : integer := slave_number_signal; end macro;

macro to_master_ack  : boolean := to_master_signal.ack;  end macro;
macro to_master_data : integer := to_master_signal.data; end macro;
macro to_master_err  : boolean := to_master_signal.err;  end macro;


-- STATES --
macro state_1 : boolean := section = IDLE;                        end macro;
macro state_2 : boolean := section = TRANSMITTING and helper = 0; end macro;
macro state_3 : boolean := section = DONE and helper = 0;         end macro;
