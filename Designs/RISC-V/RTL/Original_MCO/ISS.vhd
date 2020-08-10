library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ISS_operations;
use work.ISS_types.all;

entity ISS_module is
port(
	fromMemoryPort_sig: in MEtoCU_IF;
	fromRegsPort_sig: in RegfileType;
	toMemoryPort_sig: out CUtoME_IF;
	toRegsPort_sig: out RegfileWriteType;
	fromMemoryPort_notify: out std_logic;
	toMemoryPort_notify: out std_logic;
	toRegsPort_notify: out std_logic;
	fromMemoryPort_sync: in std_logic;
	toMemoryPort_sync: in std_logic;
	rst: in std_logic;
	clk: in std_logic
);
end ISS_module;

architecture ISS_arch of ISS_module is

	-- Internal Registers
	signal pcReg: std_logic_vector(31 downto 0);
	signal regfileWrite: RegfileWriteType;
	signal in_pcReg: std_logic_vector(31 downto 0);
	signal in_regfileWrite_dst: std_logic_vector(31 downto 0);
	signal out_regfileWrite_dstData: std_logic_vector(31 downto 0);
	signal out_regfileWrite_dstData_vld: std_logic;
	signal out_pcReg: std_logic_vector(31 downto 0);
	signal out_pcReg_vld: std_logic;
	signal out_regfileWrite_dst: std_logic_vector(31 downto 0);
	signal out_regfileWrite_dst_vld: std_logic;

	-- Module Inputs
	signal fromMemoryPort_sig_loadedData_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_01_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_02_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_03_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_04_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_05_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_06_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_07_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_08_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_09_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_10_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_11_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_12_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_13_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_14_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_15_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_16_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_17_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_18_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_19_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_20_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_21_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_22_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_23_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_24_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_25_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_26_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_27_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_28_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_29_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_30_in: std_logic_vector(31 downto 0);
	signal fromRegsPort_sig_reg_file_31_in: std_logic_vector(31 downto 0);
	signal active_operation_in: std_logic_vector(3 downto 0);

	-- Module Outputs
	signal toMemoryPort_sig_addrIn_out: std_logic_vector(31 downto 0);
	signal toMemoryPort_sig_addrIn_vld: std_logic;
	signal toMemoryPort_sig_dataIn_out: std_logic_vector(31 downto 0);
	signal toMemoryPort_sig_dataIn_vld: std_logic;
	signal toMemoryPort_sig_mask_out: std_logic_vector(2 downto 0);
	signal toMemoryPort_sig_mask_vld: std_logic;
	signal toMemoryPort_sig_req_out: std_logic_vector(1 downto 0);
	signal toMemoryPort_sig_req_vld: std_logic;
	signal fromMemoryPort_notify_out: std_logic;
	signal fromMemoryPort_notify_vld: std_logic;
	signal toMemoryPort_notify_out: std_logic;
	signal toMemoryPort_notify_vld: std_logic;
	signal toRegsPort_notify_out: std_logic;
	signal toRegsPort_notify_vld: std_logic;
	signal fromMemoryPort_notify_reg: std_logic;
	signal toMemoryPort_notify_reg: std_logic;
	signal toRegsPort_notify_reg: std_logic;

	-- Handshaking Protocol Signals (Communication between top and operations_inst)
	signal idle_sig: std_logic;
	signal done_sig: std_logic;
	signal start_sig: std_logic;
	signal ready_sig: std_logic;

	-- Monitor Signals
	signal active_operation: ISS_operation_t;
	signal active_state: ISS_state_t;
	signal next_state: ISS_state_t;
	signal wait_state: std_logic;

	-- Functions
	function getEncType(encodedInstr: std_logic_vector(31 downto 0)) return EncType;

	function getEncType(encodedInstr: std_logic_vector(31 downto 0)) return EncType is
	begin
		if (encodedInstr(6 downto 0) = "0110011") then return ENC_R;
		elsif (encodedInstr(6 downto 0) = "0010011") then return ENC_I_I;
		elsif (encodedInstr(6 downto 0) = "0000011") then return ENC_I_L;
		elsif (encodedInstr(6 downto 0) = "1100111") then return ENC_I_J;
		elsif (encodedInstr(6 downto 0) = "0100011") then return ENC_S;
		elsif (encodedInstr(6 downto 0) = "1100011") then return ENC_B;
		elsif ((encodedInstr(6 downto 0) = "0110111") or (encodedInstr(6 downto 0) = "0010111")) then return ENC_U;
		elsif (encodedInstr(6 downto 0) = "1101111") then return ENC_J;
		else return ENC_ERR;
		end if;
	end getEncType;


	component ISS_operations is
	port(
		ap_rst: in std_logic;
		ap_clk: in std_logic;
		ap_idle: out std_logic;
		ap_done: out std_logic;
		ap_start: in std_logic;
		ap_ready: out std_logic;
		fromMemoryPort_sig_loadedData_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_01_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_02_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_03_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_04_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_05_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_06_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_07_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_08_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_09_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_10_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_11_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_12_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_13_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_14_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_15_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_16_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_17_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_18_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_19_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_20_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_21_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_22_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_23_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_24_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_25_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_26_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_27_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_28_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_29_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_30_V: in std_logic_vector(31 downto 0);
		fromRegsPort_sig_reg_file_31_V: in std_logic_vector(31 downto 0);
		toMemoryPort_sig_addrIn_V: out std_logic_vector(31 downto 0);
		toMemoryPort_sig_addrIn_V_ap_vld: out std_logic;
		toMemoryPort_sig_dataIn_V: out std_logic_vector(31 downto 0);
		toMemoryPort_sig_dataIn_V_ap_vld: out std_logic;
		toMemoryPort_sig_mask: out std_logic_vector(2 downto 0);
		toMemoryPort_sig_mask_ap_vld: out std_logic;
		toMemoryPort_sig_req: out std_logic_vector(1 downto 0);
		toMemoryPort_sig_req_ap_vld: out std_logic;
		in_pcReg_V: in std_logic_vector(31 downto 0);
		in_regfileWrite_dst_V: in std_logic_vector(31 downto 0);
		out_regfileWrite_dstData_V: out std_logic_vector(31 downto 0);
		out_regfileWrite_dstData_V_ap_vld: out std_logic;
		out_pcReg_V: out std_logic_vector(31 downto 0);
		out_pcReg_V_ap_vld: out std_logic;
		out_regfileWrite_dst_V: out std_logic_vector(31 downto 0);
		out_regfileWrite_dst_V_ap_vld: out std_logic;
		fromMemoryPort_notify: out std_logic;
		fromMemoryPort_notify_ap_vld: out std_logic;
		toMemoryPort_notify: out std_logic;
		toMemoryPort_notify_ap_vld: out std_logic;
		toRegsPort_notify: out std_logic;
		toRegsPort_notify_ap_vld: out std_logic;
		active_operation: in std_logic_vector(3 downto 0)
	);
	end component;

begin

	operations_inst: ISS_operations
	port map(
		ap_rst => rst,
		ap_clk => clk,
		ap_idle => idle_sig,
		ap_done => done_sig,
		ap_start => start_sig,
		ap_ready => ready_sig,
		fromMemoryPort_sig_loadedData_V => fromMemoryPort_sig_loadedData_in,
		fromRegsPort_sig_reg_file_01_V => fromRegsPort_sig_reg_file_01_in,
		fromRegsPort_sig_reg_file_02_V => fromRegsPort_sig_reg_file_02_in,
		fromRegsPort_sig_reg_file_03_V => fromRegsPort_sig_reg_file_03_in,
		fromRegsPort_sig_reg_file_04_V => fromRegsPort_sig_reg_file_04_in,
		fromRegsPort_sig_reg_file_05_V => fromRegsPort_sig_reg_file_05_in,
		fromRegsPort_sig_reg_file_06_V => fromRegsPort_sig_reg_file_06_in,
		fromRegsPort_sig_reg_file_07_V => fromRegsPort_sig_reg_file_07_in,
		fromRegsPort_sig_reg_file_08_V => fromRegsPort_sig_reg_file_08_in,
		fromRegsPort_sig_reg_file_09_V => fromRegsPort_sig_reg_file_09_in,
		fromRegsPort_sig_reg_file_10_V => fromRegsPort_sig_reg_file_10_in,
		fromRegsPort_sig_reg_file_11_V => fromRegsPort_sig_reg_file_11_in,
		fromRegsPort_sig_reg_file_12_V => fromRegsPort_sig_reg_file_12_in,
		fromRegsPort_sig_reg_file_13_V => fromRegsPort_sig_reg_file_13_in,
		fromRegsPort_sig_reg_file_14_V => fromRegsPort_sig_reg_file_14_in,
		fromRegsPort_sig_reg_file_15_V => fromRegsPort_sig_reg_file_15_in,
		fromRegsPort_sig_reg_file_16_V => fromRegsPort_sig_reg_file_16_in,
		fromRegsPort_sig_reg_file_17_V => fromRegsPort_sig_reg_file_17_in,
		fromRegsPort_sig_reg_file_18_V => fromRegsPort_sig_reg_file_18_in,
		fromRegsPort_sig_reg_file_19_V => fromRegsPort_sig_reg_file_19_in,
		fromRegsPort_sig_reg_file_20_V => fromRegsPort_sig_reg_file_20_in,
		fromRegsPort_sig_reg_file_21_V => fromRegsPort_sig_reg_file_21_in,
		fromRegsPort_sig_reg_file_22_V => fromRegsPort_sig_reg_file_22_in,
		fromRegsPort_sig_reg_file_23_V => fromRegsPort_sig_reg_file_23_in,
		fromRegsPort_sig_reg_file_24_V => fromRegsPort_sig_reg_file_24_in,
		fromRegsPort_sig_reg_file_25_V => fromRegsPort_sig_reg_file_25_in,
		fromRegsPort_sig_reg_file_26_V => fromRegsPort_sig_reg_file_26_in,
		fromRegsPort_sig_reg_file_27_V => fromRegsPort_sig_reg_file_27_in,
		fromRegsPort_sig_reg_file_28_V => fromRegsPort_sig_reg_file_28_in,
		fromRegsPort_sig_reg_file_29_V => fromRegsPort_sig_reg_file_29_in,
		fromRegsPort_sig_reg_file_30_V => fromRegsPort_sig_reg_file_30_in,
		fromRegsPort_sig_reg_file_31_V => fromRegsPort_sig_reg_file_31_in,
		toMemoryPort_sig_addrIn_V => toMemoryPort_sig_addrIn_out,
		toMemoryPort_sig_addrIn_V_ap_vld => toMemoryPort_sig_addrIn_vld,
		toMemoryPort_sig_dataIn_V => toMemoryPort_sig_dataIn_out,
		toMemoryPort_sig_dataIn_V_ap_vld => toMemoryPort_sig_dataIn_vld,
		toMemoryPort_sig_mask => toMemoryPort_sig_mask_out,
		toMemoryPort_sig_mask_ap_vld => toMemoryPort_sig_mask_vld,
		toMemoryPort_sig_req => toMemoryPort_sig_req_out,
		toMemoryPort_sig_req_ap_vld => toMemoryPort_sig_req_vld,
		in_pcReg_V => in_pcReg,
		in_regfileWrite_dst_V => in_regfileWrite_dst,
		out_regfileWrite_dstData_V => out_regfileWrite_dstData,
		out_regfileWrite_dstData_V_ap_vld => out_regfileWrite_dstData_vld,
		out_pcReg_V => out_pcReg,
		out_pcReg_V_ap_vld => out_pcReg_vld,
		out_regfileWrite_dst_V => out_regfileWrite_dst,
		out_regfileWrite_dst_V_ap_vld => out_regfileWrite_dst_vld,
		fromMemoryPort_notify => fromMemoryPort_notify_out,
		fromMemoryPort_notify_ap_vld  => fromMemoryPort_notify_vld,
		toMemoryPort_notify => toMemoryPort_notify_out,
		toMemoryPort_notify_ap_vld  => toMemoryPort_notify_vld,
		toRegsPort_notify => toRegsPort_notify_out,
		toRegsPort_notify_ap_vld  => toRegsPort_notify_vld,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, fromMemoryPort_sync, toMemoryPort_sync, fromMemoryPort_sig.loadedData)
	begin
		case active_state is
		when st_state_1 =>
			if ((toMemoryPort_sync = '1')) then 
				active_operation <= op_state_1_1;
				next_state <= st_state_2;
				wait_state <= '0';
			else
				wait_state <= '1';
			end if;
		when st_state_2 =>
			if ((fromMemoryPort_sync = '1') and (getEncType(fromMemoryPort_sig.loadedData) = ENC_R)) then 
				active_operation <= op_state_2_2;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((fromMemoryPort_sync = '1') and (getEncType(fromMemoryPort_sig.loadedData) = ENC_B)) then 
				active_operation <= op_state_2_3;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((fromMemoryPort_sync = '1') and (getEncType(fromMemoryPort_sig.loadedData) = ENC_S)) then 
				active_operation <= op_state_2_4;
				next_state <= st_state_3;
				wait_state <= '0';
			elsif ((fromMemoryPort_sync = '1') and (getEncType(fromMemoryPort_sig.loadedData) = ENC_U)) then 
				active_operation <= op_state_2_5;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((fromMemoryPort_sync = '1') and (getEncType(fromMemoryPort_sig.loadedData) = ENC_J)) then 
				active_operation <= op_state_2_6;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((fromMemoryPort_sync = '1') and (getEncType(fromMemoryPort_sig.loadedData) = ENC_I_I)) then 
				active_operation <= op_state_2_7;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((fromMemoryPort_sync = '1') and (getEncType(fromMemoryPort_sig.loadedData) = ENC_I_L)) then 
				active_operation <= op_state_2_8;
				next_state <= st_state_5;
				wait_state <= '0';
			elsif ((fromMemoryPort_sync = '1') and (getEncType(fromMemoryPort_sig.loadedData) = ENC_I_J)) then 
				active_operation <= op_state_2_9;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((fromMemoryPort_sync = '1') and not((getEncType(fromMemoryPort_sig.loadedData) = ENC_R)) and not((getEncType(fromMemoryPort_sig.loadedData) = ENC_B)) and not((getEncType(fromMemoryPort_sig.loadedData) = ENC_S)) and not((getEncType(fromMemoryPort_sig.loadedData) = ENC_U)) and not((getEncType(fromMemoryPort_sig.loadedData) = ENC_J)) and not((getEncType(fromMemoryPort_sig.loadedData) = ENC_I_I)) and not((getEncType(fromMemoryPort_sig.loadedData) = ENC_I_L)) and not((getEncType(fromMemoryPort_sig.loadedData) = ENC_I_J))) then 
				active_operation <= op_state_2_10;
				next_state <= st_state_1;
				wait_state <= '0';
			else
				wait_state <= '1';
			end if;
		when st_state_3 =>
			if ((toMemoryPort_sync = '1')) then 
				active_operation <= op_state_3_11;
				next_state <= st_state_4;
				wait_state <= '0';
			else
				wait_state <= '1';
			end if;
		when st_state_4 =>
			if ((fromMemoryPort_sync = '1')) then 
				active_operation <= op_state_4_12;
				next_state <= st_state_1;
				wait_state <= '0';
			else
				wait_state <= '1';
			end if;
		when st_state_5 =>
			if ((toMemoryPort_sync = '1')) then 
				active_operation <= op_state_5_13;
				next_state <= st_state_6;
				wait_state <= '0';
			else
				wait_state <= '1';
			end if;
		when st_state_6 =>
			if ((fromMemoryPort_sync = '1')) then 
				active_operation <= op_state_6_14;
				next_state <= st_state_1;
				wait_state <= '0';
			else
				wait_state <= '1';
			end if;
		end case;
	end process;

	-- Output_Vld Processes
	process (rst, toMemoryPort_sig_addrIn_vld)
	begin
		if (rst = '1') then
			toMemoryPort_sig.addrIn <= x"00000000";
		elsif (toMemoryPort_sig_addrIn_vld = '1') then
			toMemoryPort_sig.addrIn <= toMemoryPort_sig_addrIn_out;
		end if;
	end process;

	process (rst, toMemoryPort_sig_dataIn_vld)
	begin
		if (rst = '1') then
			toMemoryPort_sig.dataIn <= x"00000000";
		elsif (toMemoryPort_sig_dataIn_vld = '1') then
			toMemoryPort_sig.dataIn <= toMemoryPort_sig_dataIn_out;
		end if;
	end process;

	process (rst, toMemoryPort_sig_mask_vld)
	begin
		if (rst = '1') then
			toMemoryPort_sig.mask <= MT_W;
		elsif (toMemoryPort_sig_mask_vld = '1') then
			toMemoryPort_sig.mask <= ME_MaskType'val(to_integer(unsigned(toMemoryPort_sig_mask_out)));
		end if;
	end process;

	process (rst, toMemoryPort_sig_req_vld)
	begin
		if (rst = '1') then
			toMemoryPort_sig.req <= ME_RD;
		elsif (toMemoryPort_sig_req_vld = '1') then
			toMemoryPort_sig.req <= ME_AccessType'val(to_integer(unsigned(toMemoryPort_sig_req_out)));
		end if;
	end process;

	process (rst, out_regfileWrite_dstData_vld)
	begin
		if (rst = '1') then
			regfileWrite.dstData <= x"00000000";
		elsif (out_regfileWrite_dstData_vld = '1') then
			regfileWrite.dstData <= out_regfileWrite_dstData;
		end if;
	end process;

	with out_pcReg_vld select
		pcReg <= in_pcReg when '0',
			out_pcReg when others;

	with out_regfileWrite_dst_vld select
		regfileWrite.dst <= in_regfileWrite_dst when '0',
			out_regfileWrite_dst when others;

	process(clk ,rst)
	begin
		if (rst = '1') then
			in_pcReg <= x"00000000";
		elsif (clk = '1' and clk'event) then
			in_pcReg <= pcReg;
		end if;
	end process;

	process(clk ,rst)
	begin
		if (rst = '1') then
			in_regfileWrite_dst <= x"00000000";
		elsif (clk = '1' and clk'event) then
			in_regfileWrite_dst <= regfileWrite.dst;
		end if;
	end process;

	process(fromMemoryPort_notify_vld)
	begin
		if (fromMemoryPort_notify_vld = '1') then
			fromMemoryPort_notify_reg <= fromMemoryPort_notify_out;
		end if;
	end process;

	process(toMemoryPort_notify_vld)
	begin
		if (toMemoryPort_notify_vld = '1') then
			toMemoryPort_notify_reg <= toMemoryPort_notify_out;
		end if;
	end process;

	process(toRegsPort_notify_vld)
	begin
		if (toRegsPort_notify_vld = '1') then
			toRegsPort_notify_reg <= toRegsPort_notify_out;
		end if;
	end process;

	-- Output Processes
	process(rst, done_sig)
	begin
		if (rst = '1') then
			toRegsPort_sig.dst <= x"00000000";
			toRegsPort_sig.dstData <= x"00000000";
		elsif (done_sig = '1') then
			toRegsPort_sig <= regfileWrite;
		end if;
	end process;

	process(rst, done_sig, idle_sig)
	begin
		if (rst = '1') then
			fromMemoryPort_notify <= '0';
			toMemoryPort_notify <= '1';
			toRegsPort_notify <= '0';
		else
			if (done_sig = '1') then
				fromMemoryPort_notify <= fromMemoryPort_notify_reg;
				toMemoryPort_notify <= toMemoryPort_notify_reg;
				toRegsPort_notify <= toRegsPort_notify_reg;
			elsif (idle_sig = '1') then
				toRegsPort_notify <= '0';
			else
				fromMemoryPort_notify <= '0';
				toMemoryPort_notify <= '0';
				toRegsPort_notify <= '0';
			end if;
		end if;
	end process;

	-- Control process
	process (clk, rst)
	begin
		if (rst = '1') then
			start_sig <= '0';
			active_state <= st_state_1;
		elsif (clk = '1' and clk'event) then
			if ((idle_sig = '1' or ready_sig = '1') and wait_state = '0') then
				start_sig <= '1';
				active_state <= next_state;
				active_operation_in <= std_logic_vector(to_unsigned(ISS_operation_t'pos(active_operation), 4));
				fromMemoryPort_sig_loadedData_in <= fromMemoryPort_sig.loadedData;
				fromRegsPort_sig_reg_file_01_in <= fromRegsPort_sig.reg_file_01;
				fromRegsPort_sig_reg_file_02_in <= fromRegsPort_sig.reg_file_02;
				fromRegsPort_sig_reg_file_03_in <= fromRegsPort_sig.reg_file_03;
				fromRegsPort_sig_reg_file_04_in <= fromRegsPort_sig.reg_file_04;
				fromRegsPort_sig_reg_file_05_in <= fromRegsPort_sig.reg_file_05;
				fromRegsPort_sig_reg_file_06_in <= fromRegsPort_sig.reg_file_06;
				fromRegsPort_sig_reg_file_07_in <= fromRegsPort_sig.reg_file_07;
				fromRegsPort_sig_reg_file_08_in <= fromRegsPort_sig.reg_file_08;
				fromRegsPort_sig_reg_file_09_in <= fromRegsPort_sig.reg_file_09;
				fromRegsPort_sig_reg_file_10_in <= fromRegsPort_sig.reg_file_10;
				fromRegsPort_sig_reg_file_11_in <= fromRegsPort_sig.reg_file_11;
				fromRegsPort_sig_reg_file_12_in <= fromRegsPort_sig.reg_file_12;
				fromRegsPort_sig_reg_file_13_in <= fromRegsPort_sig.reg_file_13;
				fromRegsPort_sig_reg_file_14_in <= fromRegsPort_sig.reg_file_14;
				fromRegsPort_sig_reg_file_15_in <= fromRegsPort_sig.reg_file_15;
				fromRegsPort_sig_reg_file_16_in <= fromRegsPort_sig.reg_file_16;
				fromRegsPort_sig_reg_file_17_in <= fromRegsPort_sig.reg_file_17;
				fromRegsPort_sig_reg_file_18_in <= fromRegsPort_sig.reg_file_18;
				fromRegsPort_sig_reg_file_19_in <= fromRegsPort_sig.reg_file_19;
				fromRegsPort_sig_reg_file_20_in <= fromRegsPort_sig.reg_file_20;
				fromRegsPort_sig_reg_file_21_in <= fromRegsPort_sig.reg_file_21;
				fromRegsPort_sig_reg_file_22_in <= fromRegsPort_sig.reg_file_22;
				fromRegsPort_sig_reg_file_23_in <= fromRegsPort_sig.reg_file_23;
				fromRegsPort_sig_reg_file_24_in <= fromRegsPort_sig.reg_file_24;
				fromRegsPort_sig_reg_file_25_in <= fromRegsPort_sig.reg_file_25;
				fromRegsPort_sig_reg_file_26_in <= fromRegsPort_sig.reg_file_26;
				fromRegsPort_sig_reg_file_27_in <= fromRegsPort_sig.reg_file_27;
				fromRegsPort_sig_reg_file_28_in <= fromRegsPort_sig.reg_file_28;
				fromRegsPort_sig_reg_file_29_in <= fromRegsPort_sig.reg_file_29;
				fromRegsPort_sig_reg_file_30_in <= fromRegsPort_sig.reg_file_30;
				fromRegsPort_sig_reg_file_31_in <= fromRegsPort_sig.reg_file_31;
			elsif ((idle_sig = '1' or  ready_sig = '1') and wait_state = '1') then
				start_sig <= '0';
			end if;
		end if;
	end process;

end ISS_arch;
