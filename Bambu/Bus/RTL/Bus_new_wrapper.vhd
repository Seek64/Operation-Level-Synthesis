library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Bus_new_operations;
use work.Bus_new_types.all;

entity Bus_new_module is
port(

	master_in_sig: in bus_req_t;		
	slave_in0_sig: in bus_resp_t;
	slave_in1_sig: in bus_resp_t;
	slave_in2_sig: in bus_resp_t;
	slave_in3_sig: in bus_resp_t;
	master_out_sig: out bus_resp_t;		
	slave_out0_sig: out bus_req_t;
	slave_out1_sig: out bus_req_t;
	slave_out2_sig: out bus_req_t;
	slave_out3_sig: out bus_req_t;

	master_in_notify: out std_logic_vector (0 downto 0);
	master_out_notify: out std_logic_vector (0 downto 0);
	slave_in0_notify: out std_logic_vector (0 downto 0);
	slave_in1_notify: out std_logic_vector (0 downto 0);
	slave_in2_notify: out std_logic_vector (0 downto 0);
	slave_in3_notify: out std_logic_vector (0 downto 0);
	slave_out0_notify: out std_logic_vector (0 downto 0);
	slave_out1_notify: out std_logic_vector (0 downto 0);
	slave_out2_notify: out std_logic_vector (0 downto 0);
	slave_out3_notify: out std_logic_vector (0 downto 0);

	master_in_sync: in std_logic;
	master_out_sync: in std_logic;
	slave_in0_sync: in std_logic;
	slave_in1_sync: in std_logic;
	slave_in2_sync: in std_logic;
	slave_in3_sync: in std_logic;
	slave_out0_sync: in std_logic;
	slave_out1_sync: in std_logic;
	slave_out2_sync: in std_logic;
	slave_out3_sync: in std_logic;

	start_port: in std_logic;

	rst: in std_logic;
	clk: in std_logic
);
end Bus_new_module;

architecture Bus_new_arch of Bus_new_module is

	-- Internal Registers
	signal req: bus_req_t;
	signal req_trans_type_vld_out: std_logic;
	signal req_data_vld_out: std_logic;
	signal req_addr_vld_out: std_logic;

	signal resp: bus_resp_t;
	signal resp_ack_vld_out: std_logic;
	signal resp_data_vld_out: std_logic;


	signal req_reg: bus_req_t;
	signal resp_reg: bus_resp_t;

	-- Operation Module Inputs
	signal master_in_sig_addr_in: std_logic_vector(31 downto 0);
	signal master_in_sig_data_in: std_logic_vector(31 downto 0);
	signal master_in_sig_trans_type_in: std_logic_vector(0 downto 0);
	signal slave_in0_sig_ack_in: std_logic_vector(7 downto 0);
	signal slave_in0_sig_data_in: std_logic_vector(31 downto 0);
	signal slave_in1_sig_ack_in: std_logic_vector(7 downto 0);
	signal slave_in1_sig_data_in: std_logic_vector(31 downto 0);
	signal slave_in2_sig_ack_in: std_logic_vector(7 downto 0);
	signal slave_in2_sig_data_in: std_logic_vector(31 downto 0);
	signal slave_in3_sig_ack_in: std_logic_vector(7 downto 0);
	signal slave_in3_sig_data_in: std_logic_vector(31 downto 0);

	-- Monitor Signals
	signal active_state: Bus_new_state_t;	
	signal next_state: Bus_new_state_t;
---------------------------------------------------------------
	

	signal master_in_notify_out: std_logic_vector (0 downto 0);
	signal master_in_notify_vld_out: std_logic;

	signal master_out_notify_out: std_logic_vector (0 downto 0);
	signal master_out_notify_vld_out: std_logic;

	signal slave_in0_notify_out: std_logic_vector (0 downto 0);
		signal slave_in0_notify_vld_out: std_logic;
	signal slave_in1_notify_out: std_logic_vector (0 downto 0);
		signal slave_in1_notify_vld_out: std_logic;
	signal slave_in2_notify_out: std_logic_vector (0 downto 0);
		signal slave_in2_notify_vld_out: std_logic;
	signal slave_in3_notify_out: std_logic_vector (0 downto 0);
		signal slave_in3_notify_vld_out: std_logic;
	signal slave_out0_notify_out: std_logic_vector (0 downto 0);
		signal slave_out0_notify_vld_out: std_logic;
	signal slave_out1_notify_out: std_logic_vector (0 downto 0);
		signal slave_out1_notify_vld_out: std_logic;
	signal slave_out2_notify_out: std_logic_vector (0 downto 0);
		signal slave_out2_notify_vld_out: std_logic;
	signal slave_out3_notify_out: std_logic_vector (0 downto 0);
		signal slave_out3_notify_vld_out: std_logic;

	signal start_port_in: std_logic;
	signal done_s: std_logic;

	signal master_in_notify_reg: std_logic_vector (0 downto 0);
	signal master_out_notify_reg: std_logic_vector (0 downto 0);
	signal slave_out0_notify_reg: std_logic_vector (0 downto 0); 
	signal slave_out1_notify_reg: std_logic_vector (0 downto 0);
	signal slave_out2_notify_reg: std_logic_vector (0 downto 0);
	signal slave_out3_notify_reg: std_logic_vector (0 downto 0);
	signal slave_in0_notify_reg: std_logic_vector (0 downto 0);
	signal slave_in1_notify_reg: std_logic_vector (0 downto 0);
	signal slave_in2_notify_reg: std_logic_vector (0 downto 0);
	signal slave_in3_notify_reg: std_logic_vector (0 downto 0);

	signal active_operation_in: Bus_new_operation_t;

	signal wait_r  : std_logic;
	signal wait_rr  : std_logic;

	-- Functions
	function bool_to_sl(x : boolean) return std_logic;

	function bool_to_sl(x : boolean) return std_logic is
	begin
  	if x then
	return '1';
  	else
    	return '0';
  	end if;
	end bool_to_sl;

	component Bus_new_operations is
	port(
	    clock : in std_logic;
	    reset : in std_logic;

	    start_port : in std_logic;

	    master_in_sig_addr : in std_logic_vector(31 downto 0) ;
	    master_in_sig_data : in std_logic_vector(31 downto 0) ;
	    master_in_sig_trans_type : in std_logic_vector(0 downto 0) ;

	    slave_in0_sig_ack : in std_logic_vector(7 downto 0) ;
	    slave_in0_sig_data : in std_logic_vector(31 downto 0) ;

	    slave_in1_sig_ack : in std_logic_vector(7 downto 0) ;
	    slave_in1_sig_data : in std_logic_vector(31 downto 0) ;

	    slave_in2_sig_ack : in std_logic_vector(7 downto 0) ;
	    slave_in2_sig_data : in std_logic_vector(31 downto 0) ;

	    slave_in3_sig_ack : in std_logic_vector(7 downto 0) ;
	    slave_in3_sig_data : in std_logic_vector(31 downto 0) ;

	    done_port : out std_logic;

	    master_in_notify : out std_logic_vector(0 downto 0);
	    master_in_notify_vld : out std_logic;
	    master_out_notify : out std_logic_vector(0 downto 0);
	    master_out_notify_vld : out std_logic;

	    active_operation: in std_logic_vector(31 downto 0);

	    req_trans_type : out std_logic_vector(0 downto 0) ;
	    req_trans_type_vld : out std_logic;
	    req_addr : out std_logic_vector(31 downto 0) ;
	    req_addr_vld : out std_logic;
	    req_data : out std_logic_vector(31 downto 0) ;
	    req_data_vld : out std_logic;

	    resp_ack : out std_logic_vector(7 downto 0) ;
	    resp_ack_vld : out std_logic;
	    resp_data : out std_logic_vector(31 downto 0) ;
	    resp_data_vld : out std_logic;

	    slave_in0_notify : out std_logic_vector(0 downto 0);
	    slave_in0_notify_vld : out std_logic;
	    slave_in1_notify : out std_logic_vector(0 downto 0);
	    slave_in1_notify_vld : out std_logic;
	    slave_in2_notify : out std_logic_vector(0 downto 0);
	    slave_in2_notify_vld : out std_logic;
	    slave_in3_notify : out std_logic_vector(0 downto 0);
	    slave_in3_notify_vld : out std_logic;
	    slave_out0_notify : out std_logic_vector(0 downto 0);
	    slave_out0_notify_vld : out std_logic;
	    slave_out1_notify : out std_logic_vector(0 downto 0);
	    slave_out1_notify_vld : out std_logic;
	    slave_out2_notify : out std_logic_vector(0 downto 0);
	    slave_out2_notify_vld : out std_logic;
	    slave_out3_notify : out std_logic_vector(0 downto 0);
	    slave_out3_notify_vld : out std_logic

	);
	end component;

begin

	Bus_new_operations_inst: Bus_new_operations	-- component port => signals
	port map(
		clock  => clk,
		reset  => rst,
	   	start_port => start_port_in,

		master_in_sig_addr  => master_in_sig_addr_in,
		master_in_sig_data => master_in_sig_data_in,
		master_in_sig_trans_type => master_in_sig_trans_type_in,

		slave_in0_sig_ack => slave_in0_sig_ack_in,
		slave_in0_sig_data => slave_in0_sig_data_in,

		slave_in1_sig_ack => slave_in1_sig_ack_in ,
		slave_in1_sig_data => slave_in1_sig_data_in,

		slave_in2_sig_ack => slave_in2_sig_ack_in,
		slave_in2_sig_data => slave_in2_sig_data_in,

		slave_in3_sig_ack => slave_in3_sig_ack_in,
		slave_in3_sig_data => slave_in3_sig_data_in,

		req_trans_type => req.trans_type,
		req_trans_type_vld => req_trans_type_vld_out,
		req_data => req.data,
		req_data_vld => req_data_vld_out,
		req_addr => req.addr,
		req_addr_vld => req_addr_vld_out,

		resp_data => resp.data,
		resp_data_vld => resp_data_vld_out,

		resp_ack => resp.ack,
		resp_ack_vld => resp_ack_vld_out,

	   	done_port => done_s,

		master_in_notify => master_in_notify_out,
		master_in_notify_vld => master_in_notify_vld_out,

		master_out_notify => master_out_notify_out,
		master_out_notify_vld => master_out_notify_vld_out,

		slave_in0_notify => slave_in0_notify_out,
		slave_in0_notify_vld => slave_in0_notify_vld_out,
		slave_in1_notify => slave_in1_notify_out,
		slave_in1_notify_vld => slave_in1_notify_vld_out,
		slave_in2_notify => slave_in2_notify_out,
		slave_in2_notify_vld => slave_in2_notify_vld_out,
		slave_in3_notify => slave_in3_notify_out,
		slave_in3_notify_vld => slave_in3_notify_vld_out,

		slave_out0_notify => slave_out0_notify_out,
		slave_out0_notify_vld => slave_out0_notify_vld_out,
		slave_out1_notify => slave_out1_notify_out,
		slave_out1_notify_vld => slave_out1_notify_vld_out,
		slave_out2_notify => slave_out2_notify_out,
		slave_out2_notify_vld => slave_out2_notify_vld_out,
		slave_out3_notify => slave_out3_notify_out,
		slave_out3_notify_vld => slave_out3_notify_vld_out,
		active_operation => active_operation_in
	);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   -- Control process
   process (clk, rst)
   begin
      if (rst = '0') then -- Active Low
         active_operation_in <= op_state_wait;
         active_state        <= st_master_in_1;		-- active_state was state_r
         start_port_in       <= '0';
         wait_r     	     <= '1';
      elsif (clk = '1' and clk'event) then
         -- New Operation
         if (wait_r = '1') then
            case active_state is
		when st_master_in_1 =>
			if (master_in_sync and bool_to_sl(SINGLE_READ = master_in_sig.trans_type) and bool_to_sl(master_in_sig.addr >= x"00000000") and bool_to_sl(master_in_sig.addr <= x"00000007")) = '1' then 
				active_operation_in <= op_master_in_1_1;
				active_state <= st_slave_out0_2;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and bool_to_sl(SINGLE_READ = master_in_sig.trans_type) and bool_to_sl(master_in_sig.addr >= x"00000008") and bool_to_sl(master_in_sig.addr <= x"0000000f")) = '1' then 
				active_operation_in <= op_master_in_1_2;
				active_state <= st_slave_out1_5;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and bool_to_sl(SINGLE_READ = master_in_sig.trans_type) and bool_to_sl(master_in_sig.addr >= x"00000010") and bool_to_sl(master_in_sig.addr <= x"00000017")) = '1' then 
				active_operation_in <= op_master_in_1_3;
				active_state <= st_slave_out2_7;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and bool_to_sl(SINGLE_READ = master_in_sig.trans_type) and bool_to_sl(master_in_sig.addr >= x"00000018") and bool_to_sl(master_in_sig.addr <= x"0000001f")) = '1' then 
				active_operation_in <= op_master_in_1_4;
				active_state <= st_slave_out3_9;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and bool_to_sl(SINGLE_READ = master_in_sig.trans_type) and not((bool_to_sl(master_in_sig.addr >= x"00000000") and bool_to_sl(master_in_sig.addr <= x"00000007"))) and not((bool_to_sl(master_in_sig.addr >= x"00000008") and bool_to_sl(master_in_sig.addr <= x"0000000f"))) and not((bool_to_sl(master_in_sig.addr >= x"00000010") and bool_to_sl(master_in_sig.addr <= x"00000017"))) and not((bool_to_sl(master_in_sig.addr >= x"00000018") and bool_to_sl(master_in_sig.addr <= x"0000001f")))) = '1' then 
				active_operation_in <= op_master_in_1_5;
				active_state <= st_master_out_4;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and not(bool_to_sl(SINGLE_READ = master_in_sig.trans_type)) and bool_to_sl(master_in_sig.addr >= x"00000000") and bool_to_sl(master_in_sig.addr <= x"00000007")) = '1' then 
				active_operation_in <= op_master_in_1_6;
				active_state <= st_slave_out0_2;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and not(bool_to_sl(SINGLE_READ = master_in_sig.trans_type)) and bool_to_sl(master_in_sig.addr >= x"00000008") and bool_to_sl(master_in_sig.addr <= x"0000000f")) = '1' then 
				active_operation_in <= op_master_in_1_7;
				active_state <= st_slave_out1_5;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and not(bool_to_sl(SINGLE_READ = master_in_sig.trans_type)) and bool_to_sl(master_in_sig.addr >= x"00000010") and bool_to_sl(master_in_sig.addr <= x"00000017")) = '1' then 
				active_operation_in <= op_master_in_1_8;
				active_state <= st_slave_out2_7;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and not(bool_to_sl(SINGLE_READ = master_in_sig.trans_type)) and bool_to_sl(master_in_sig.addr >= x"00000018") and bool_to_sl(master_in_sig.addr <= x"0000001f")) = '1' then 
				active_operation_in <= op_master_in_1_9;
				active_state <= st_slave_out3_9;
				start_port_in <= '1';
				wait_r <= '0';
			elsif (master_in_sync and not((bool_to_sl(master_in_sig.addr >= x"00000000") and bool_to_sl(master_in_sig.addr <= x"00000007"))) and not((bool_to_sl(master_in_sig.addr >= x"00000008") and bool_to_sl(master_in_sig.addr <= x"0000000f"))) and not((bool_to_sl(master_in_sig.addr >= x"00000010") and bool_to_sl(master_in_sig.addr <= x"00000017"))) and not((bool_to_sl(master_in_sig.addr >= x"00000018") and bool_to_sl(master_in_sig.addr <= x"0000001f"))) and bool_to_sl(SINGLE_WRITE = master_in_sig.trans_type)) = '1' then 
				active_operation_in <= op_master_in_1_10;
				active_state <= st_master_out_4;
				start_port_in <= '1';
				wait_r <= '0';	-- it was 0
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_slave_out0_2 =>
			if (slave_out0_sync) = '1' then 
				active_operation_in <= op_slave_out0_2_11;
				active_state <= st_slave_in0_3;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_slave_in0_3 =>
			if (slave_in0_sync and bool_to_sl(SINGLE_WRITE = req.trans_type)) = '1' then 
				active_operation_in <= op_slave_in0_3_12;
				active_state <= st_master_out_4;
			elsif (slave_in0_sync and not(bool_to_sl(SINGLE_WRITE = req.trans_type))) = '1' then 
				active_operation_in <= op_slave_in0_3_13;
				active_state <= st_master_out_4;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_master_out_4 =>
			if (master_out_sync) = '1' then 
				active_operation_in <= op_master_out_4_14;
				active_state <= st_master_in_1;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_slave_out1_5 =>
			if (slave_out1_sync) = '1' then 
				active_operation_in <= op_slave_out1_5_15;
				active_state <= st_slave_in1_6;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_slave_in1_6 =>
			if (slave_in1_sync and bool_to_sl(SINGLE_WRITE = req.trans_type)) = '1' then 
				active_operation_in <= op_slave_in1_6_16;
				active_state <= st_master_out_4;
			elsif (slave_in1_sync and not(bool_to_sl(SINGLE_WRITE = req.trans_type))) = '1' then 
				active_operation_in <= op_slave_in1_6_17;
				active_state <= st_master_out_4;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_slave_out2_7 =>
			if (slave_out2_sync) = '1' then 
				active_operation_in <= op_slave_out2_7_18;
				active_state <= st_slave_in2_8;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_slave_in2_8 =>
			if (slave_in2_sync and bool_to_sl(SINGLE_WRITE = req.trans_type)) = '1' then 
				active_operation_in <= op_slave_in2_8_19;
				active_state <= st_master_out_4;
			elsif (slave_in2_sync and not(bool_to_sl(SINGLE_WRITE = req.trans_type))) = '1' then 
				active_operation_in <= op_slave_in2_8_20;
				active_state <= st_master_out_4;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_slave_out3_9 =>
			if (slave_out3_sync) = '1' then 
				active_operation_in <= op_slave_out3_9_21;
				active_state <= st_slave_in3_10;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1';
			end if;
		when st_slave_in3_10 =>
			if (slave_in3_sync and bool_to_sl(SINGLE_WRITE = req.trans_type)) = '1' then 
				active_operation_in <= op_slave_in3_10_22;
				active_state <= st_master_out_4;
			elsif (slave_in3_sync and not(bool_to_sl(SINGLE_WRITE = req.trans_type))) = '1' then 
				active_operation_in <= op_slave_in3_10_23;
				active_state <= st_master_out_4;
			else
				active_operation_in <= op_state_wait;
				active_state <= active_state;
				start_port_in <= '0';
				wait_r <= '1'  ;
			end if;
	         end case;

		  -- Operation Finished
		elsif (done_s = '1') then
		    active_operation_in <= active_operation_in;
		    active_state <= active_state;
		    start_port_in <= '0';
		    wait_r <= '1';
		 -- Operation Running
		 else
		    active_operation_in <= active_operation_in;		-- active_operation_in was operation_r
		    active_state <= active_state;
		    start_port_in <= '0';
		    wait_r <= '0';
		 end if;
	end if;
   end process;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Input Register
   process (clk, rst)		-- master_in_sig register
   begin
      if (rst = '0') then
         master_in_sig_addr_in 		<= (others => '0');
         master_in_sig_data_in 		<= (others => '0');
         master_in_sig_trans_type_in 	<= (others => '0');     

      elsif (clk = '1' and clk'event) then
         if (master_in_sync = '1') then
            master_in_sig_addr_in 	<= master_in_sig.addr;   
            master_in_sig_data_in 	<= master_in_sig.data;   
            master_in_sig_trans_type_in <= master_in_sig.trans_type;   
         end if;
      end if;
   end process;

   process (clk, rst)		-- slave_in0_sig register
   begin
      if (rst = '0') then
         slave_in0_sig_ack_in		<= (others => '0');
         slave_in0_sig_data_in 		<= (others => '0');
      elsif (clk = '1' and clk'event) then
         if (slave_in0_sync = '1') then
            slave_in0_sig_ack_in 	<= slave_in0_sig.ack;   
            slave_in0_sig_data_in 	<= slave_in0_sig.data;   
         end if;
      end if;
   end process;

   process (clk, rst)		-- slave_in1_sig register
   begin
      if (rst = '0') then
         slave_in1_sig_ack_in		<= (others => '0');
         slave_in1_sig_data_in 		<= (others => '0');
      elsif (clk = '1' and clk'event) then
         if (slave_in0_sync = '1') then
            slave_in1_sig_ack_in 	<= slave_in1_sig.ack;   
            slave_in1_sig_data_in 	<= slave_in1_sig.data;   
         end if;
      end if;
   end process;

   process (clk, rst)		-- slave_in2_sig register
   begin
      if (rst = '0') then
         slave_in2_sig_ack_in		<= (others => '0');
         slave_in2_sig_data_in 		<= (others => '0');
      elsif (clk = '1' and clk'event) then
         if (slave_in2_sync = '1') then
            slave_in2_sig_ack_in 	<= slave_in2_sig.ack;   
            slave_in2_sig_data_in 	<= slave_in2_sig.data;   
         end if;
      end if;
   end process;

   process (clk, rst)		-- slave_in3_sig register
   begin
      if (rst = '0') then
         slave_in3_sig_ack_in		<= (others => '0');
         slave_in3_sig_data_in 		<= (others => '0');
      elsif (clk = '1' and clk'event) then
         if (slave_in3_sync = '1') then
            slave_in3_sig_ack_in 	<= slave_in3_sig.ack;   
            slave_in3_sig_data_in 	<= slave_in3_sig.data;   
         end if;
      end if;
   end process;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   -- Output Registers
 

   process (clk, rst)			-- resp register
   begin
      if (rst = '0') then
	 resp_reg.ack <= ok;				-- I need to set these signals in the else case
	 resp_reg.data <= "00000000000000000000000000000000";

      elsif (clk = '1' and clk'event) then
	   if (resp_ack_vld_out = '1' and resp_data_vld_out = '1') then
		resp_reg.data <= resp.data;
		master_out_sig.ack <= slave_in0_sig_ack_in;
	end if;
      end if;
   end process;


  process (clk, rst)			-- req register
   begin
      if (rst = '0') then
         req_reg.addr <= (others => '0');		
	 req_reg.data <= (others => '0');
	 req_reg.trans_type <= (others => '0');	
      elsif (clk = '1' and clk'event) then
	   if (req_addr_vld_out = '1' and req_data_vld_out = '1' and req_trans_type_vld_out = '1') then
--		slave_out0_sig <= req;
		req_reg.addr <= req.addr;
		req_reg.data <= req.data;
		req_reg.trans_type <= master_in_sig_trans_type_in;	

	end if;
      end if;
   end process;

   process (clk, rst)			-- slave_out0_sig register
   begin
      if (rst = '0') then
         slave_out0_sig.addr <= (others => '0');		
	 slave_out0_sig.data <= (others => '0');
	 slave_out0_sig.trans_type <= (others => '0');	
         slave_out1_sig.addr <= (others => '0');		
	 slave_out1_sig.data <= (others => '0');
	 slave_out1_sig.trans_type <= (others => '0');	
         slave_out2_sig.addr <= (others => '0');		
	 slave_out2_sig.data <= (others => '0');
	 slave_out2_sig.trans_type <= (others => '0');	
         slave_out3_sig.addr <= (others => '0');		
	 slave_out3_sig.data <= (others => '0');
	 slave_out3_sig.trans_type <= (others => '0');	

      elsif (clk = '1' and clk'event) then
	   if (req_addr_vld_out = '1' and req_data_vld_out = '1' and req_trans_type_vld_out = '1') then
		slave_out0_sig.trans_type <= req_reg.trans_type;
		slave_out1_sig.trans_type <= req_reg.trans_type;
		slave_out2_sig.trans_type <= req_reg.trans_type;
		slave_out3_sig.trans_type <= req_reg.trans_type;
	--	req_reg.trans_type <= req.trans_type;


	end if;
      end if;
   end process;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   -- Notify Registers 
   process (clk, rst)
   begin
      if (rst = '0') then
         master_in_notify_reg <= "1";
      elsif (clk = '1' and clk'event) then
         if (master_in_notify_vld_out = '1') then
            master_in_notify_reg <= master_in_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         slave_out0_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_out0_notify_vld_out = '1') then
            slave_out0_notify_reg <= slave_out0_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         slave_in0_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_in0_notify_vld_out = '1') then
            slave_in0_notify_reg <= slave_in0_notify_out;   
         end if;
      end if;
   end process;

    process (clk, rst)
    begin
      if (rst = '0') then
         slave_out1_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_out1_notify_vld_out = '1') then
            slave_out1_notify_reg <= slave_out1_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         master_out_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (master_out_notify_vld_out = '1') then
            master_out_notify_reg <= master_out_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         slave_in1_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_in1_notify_vld_out = '1') then
            slave_in1_notify_reg <= slave_in1_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         slave_out2_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_out2_notify_vld_out = '1') then
            slave_out2_notify_reg <= slave_out2_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         slave_in2_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_in2_notify_vld_out = '1') then
            slave_in2_notify_reg <= slave_in2_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         slave_out3_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_out3_notify_vld_out = '1') then
            slave_out3_notify_reg <= slave_out3_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         slave_in3_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_in3_notify_vld_out = '1') then
            slave_in3_notify_reg <= slave_in3_notify_out;   
         end if;
      end if;
   end process;

   process (clk, rst)
   begin
      if (rst = '0') then
         slave_out0_notify_reg <= "0";
      elsif (clk = '1' and clk'event) then
         if (slave_out0_notify_vld_out = '1') then
            slave_out0_notify_reg <= slave_out0_notify_out;   
         end if;
      end if;
   end process;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 -- Notify Output Logic
   master_in_notify <= master_in_notify_reg when (wait_r = '1') else "0";
   slave_out0_notify <= slave_out0_notify_reg when (wait_r = '1') else "0";
   slave_out1_notify <= slave_out1_notify_reg when (wait_r = '1') else "0";
   slave_out2_notify <= slave_out2_notify_reg when (wait_r = '1') else "0";
   slave_out3_notify <= slave_out3_notify_reg when (wait_r = '1') else "0";
   slave_in0_notify <= slave_in0_notify_reg when (wait_r = '1') else "0";
   slave_in1_notify <= slave_in1_notify_reg when (wait_r = '1') else "0";
   slave_in2_notify <= slave_in2_notify_reg when (wait_r = '1') else "0";
   slave_in3_notify <= slave_in3_notify_reg when (wait_r = '1') else "0";
   master_out_notify <= master_out_notify_reg when (wait_r = '1') else "0";

-- Outputs
     master_out_sig <= resp_reg;
     slave_out0_sig.addr <= req_reg.addr;
     slave_out0_sig.data <= req_reg.data;
     slave_out1_sig.addr <= req_reg.addr;
     slave_out1_sig.data <= req_reg.data;
     slave_out2_sig.addr <= req_reg.addr;
     slave_out2_sig.data <= req_reg.data;
     slave_out3_sig.addr <= req_reg.addr;
     slave_out3_sig.data <= req_reg.data;
--     slave_out1_sig <= req_reg;
--     slave_out2_sig <= req_reg;
--     slave_out3_sig <= req_reg;
--   slave_out0_sig.data <= req_reg.data;
--   slave_out0_sig.addr <= req_reg.addr;
  -- slave_out0_sig.trans_type <= master_in_sig.trans_type;


end Bus_new_arch;
