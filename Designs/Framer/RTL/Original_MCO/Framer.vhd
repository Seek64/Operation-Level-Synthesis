library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.operations;
use work.Framer_types.all;

entity Framer_module is
port(
	data_word_sig: in marker_t;
	lof_sig: in std_logic;
	oof_sig: out std_logic;
	frame_pulse_sig: out std_logic;
	frame_pulse_notify: out std_logic;
	data_word_sync: in std_logic;
	clk: in std_logic;
	rst: in std_logic
);
end Framer_module;

architecture Framer_arch of Framer_module is

	-- Internal Registers
	signal align: std_logic_vector(31 downto 0);
	signal frm_cnt: std_logic_vector(31 downto 0);
	signal nextphase: Phases;
	signal in_frm_cnt: std_logic_vector(31 downto 0);
	signal out_align: std_logic_vector(31 downto 0);
	signal out_align_vld: std_logic;
	signal out_frm_cnt: std_logic_vector(31 downto 0);
	signal out_frm_cnt_vld: std_logic;
	signal out_nextphase: std_logic_vector(2 downto 0);
	signal out_nextphase_vld: std_logic;

	-- Module Inputs
	signal data_word_sig_markerAlignment_in: std_logic_vector(31 downto 0);
	signal active_operation_in: std_logic_vector(4 downto 0);

	-- Module Outputs
	signal oof_sig_out: std_logic;
	signal oof_sig_vld: std_logic;
	signal frame_pulse_sig_out: std_logic;
	signal frame_pulse_sig_vld: std_logic;
	signal frame_pulse_notify_out: std_logic;
	signal frame_pulse_notify_vld: std_logic;
	signal frame_pulse_notify_reg: std_logic;

	-- Handshaking Protocol Signals (Communication between top and operations_inst)
	signal done_sig: std_logic;
	signal idle_sig: std_logic;
	signal ready_sig: std_logic;
	signal start_sig: std_logic;

	-- Monitor Signals
	signal active_state: Framer_state_t;
	signal wait_state: std_logic;
	signal next_state: Framer_state_t;
	signal active_operation: Framer_operation_t;

	component Framer_operations is
	port(
--		ap_clk: in std_logic;
--		ap_rst: in std_logic;
		ap_start: in std_logic;
		ap_done: out std_logic;
		ap_idle: out std_logic;
		ap_ready: out std_logic;
		data_word_sig_markerAlignment_V: in std_logic_vector(31 downto 0);
		oof_sig: out std_logic;
		oof_sig_ap_vld: out std_logic;
		frame_pulse_sig: out std_logic;
		frame_pulse_sig_ap_vld: out std_logic;
		in_frm_cnt_V: in std_logic_vector(31 downto 0);
		out_align_V: out std_logic_vector(31 downto 0);
		out_align_V_ap_vld: out std_logic;
		out_frm_cnt_V: out std_logic_vector(31 downto 0);
		out_frm_cnt_V_ap_vld: out std_logic;
		out_nextphase: out std_logic_vector(2 downto 0);
		out_nextphase_ap_vld: out std_logic;
		frame_pulse_notify: out std_logic;
		frame_pulse_notify_ap_vld: out std_logic;
		active_operation: in std_logic_vector(4 downto 0)
	);
	end component;

begin

	operations_inst: Framer_operations
	port map(
--		ap_clk => clk,
--		ap_rst => rst,
    ap_start => start_sig,
		ap_done => done_sig,
		ap_idle => idle_sig,
		ap_ready => ready_sig,
		data_word_sig_markerAlignment_V => data_word_sig_markerAlignment_in,
		oof_sig => oof_sig_out,
		oof_sig_ap_vld => oof_sig_vld,
		frame_pulse_sig => frame_pulse_sig_out,
		frame_pulse_sig_ap_vld => frame_pulse_sig_vld,
		in_frm_cnt_V => in_frm_cnt,
		out_align_V => out_align,
		out_align_V_ap_vld => out_align_vld,
		out_frm_cnt_V => out_frm_cnt,
		out_frm_cnt_V_ap_vld => out_frm_cnt_vld,
		out_nextphase => out_nextphase,
		out_nextphase_ap_vld => out_nextphase_vld,
		frame_pulse_notify => frame_pulse_notify_out,
		frame_pulse_notify_ap_vld  => frame_pulse_notify_vld,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, data_word_sync, data_word_sig.markerAlignment, data_word_sig.isMarker, align, frm_cnt, nextphase)
	begin
		case active_state is
		when st_state_1 =>
			if ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and (data_word_sig.isMarker = '1')) then
				active_operation <= op_state_1_1;
				next_state <= st_state_2;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and not((data_word_sig.isMarker = '1')) and (nextphase = SEARCH)) then
				active_operation <= op_state_1_3;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and (data_word_sig.isMarker = '1')) then
				active_operation <= op_state_1_5;
				next_state <= st_state_2;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and not((data_word_sig.isMarker = '1')) and (nextphase = SEARCH)) then
				active_operation <= op_state_1_7;
				next_state <= st_state_1;
				wait_state <= '0';
			else
				active_operation <= op_state_1_10;
				next_state <= st_state_1;
				wait_state <= '0';
			end if;
		when st_state_2 =>
			if ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not(((data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)))) then
				active_operation <= op_state_2_11;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and (data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)) then
				active_operation <= op_state_2_13;
				next_state <= st_state_3;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and not((((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and (nextphase = FIND_SYNC)) then
				active_operation <= op_state_2_15;
				next_state <= st_state_2;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not(((data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)))) then
				active_operation <= op_state_2_17;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and (data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)) then
				active_operation <= op_state_2_19;
				next_state <= st_state_3;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and not((((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and (nextphase = FIND_SYNC)) then
				active_operation <= op_state_2_21;
				next_state <= st_state_2;
				wait_state <= '0';
			else
				active_operation <= op_state_2_24;
				next_state <= st_state_2;
				wait_state <= '0';
			end if;
		when st_state_3 =>
			if ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not(((data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)))) then
				active_operation <= op_state_3_25;
				next_state <= st_state_4;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and (data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)) then
				active_operation <= op_state_3_27;
				next_state <= st_state_3;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and not((((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and (nextphase = SYNC)) then
				active_operation <= op_state_3_29;
				next_state <= st_state_3;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not(((data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)))) then
				active_operation <= op_state_3_31;
				next_state <= st_state_4;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and (data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)) then
				active_operation <= op_state_3_33;
				next_state <= st_state_3;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and not((((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and (nextphase = SYNC)) then
				active_operation <= op_state_3_35;
				next_state <= st_state_3;
				wait_state <= '0';
			else
				active_operation <= op_state_3_38;
				next_state <= st_state_3;
				wait_state <= '0';
			end if;
		when st_state_4 =>
			if ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not(((data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)))) then
				active_operation <= op_state_4_39;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and (data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)) then
				active_operation <= op_state_4_41;
				next_state <= st_state_3;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and (frm_cnt = FRM_PULSE_POS) and not((((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and (nextphase = MISS)) then
				active_operation <= op_state_4_43;
				next_state <= st_state_4;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not(((data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)))) then
				active_operation <= op_state_4_45;
				next_state <= st_state_1;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and (((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and (data_word_sig.isMarker = '1') and (align = data_word_sig.markerAlignment)) then
				active_operation <= op_state_4_47;
				next_state <= st_state_3;
				wait_state <= '0';
			elsif ((data_word_sync = '1') and not((frm_cnt = FRM_PULSE_POS)) and not((((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and (nextphase = MISS)) then
				active_operation <= op_state_4_49;
				next_state <= st_state_4;
				wait_state <= '0';
			else
				active_operation <= op_state_4_52;
				next_state <= st_state_4;
				wait_state <= '0';
			end if;
		end case;
	end process;

	-- Output_Vld Processes
	process (rst, oof_sig_vld)
	begin
		if (rst = '1') then
			oof_sig <= '1';
		elsif (oof_sig_vld = '1') then
			oof_sig <= oof_sig_out;
		end if;
	end process;

	process (rst, frame_pulse_sig_vld)
	begin
		if (rst = '1') then
			frame_pulse_sig <= '0';
		elsif (frame_pulse_sig_vld = '1') then
			frame_pulse_sig <= frame_pulse_sig_out;
		end if;
	end process;

	process (rst, out_align_vld)
	begin
		if (rst = '1') then
			align <= x"00000000";
		elsif (out_align_vld = '1') then
			align <= out_align;
		end if;
	end process;

	process (rst, out_nextphase_vld)
	begin
		if (rst = '1') then
			nextphase <= SEARCH;
		elsif (out_nextphase_vld = '1') then
			nextphase <= Phases'val(to_integer(unsigned(out_nextphase)));
		end if;
	end process;

	with out_frm_cnt_vld select
		frm_cnt <= in_frm_cnt when '0',
			out_frm_cnt when others;

	process(clk ,rst)
	begin
		if (rst = '1') then
			in_frm_cnt <= x"0000003f";
		elsif (clk = '1' and clk'event) then
			in_frm_cnt <= frm_cnt;
		end if;
	end process;

	process(frame_pulse_notify_vld)
	begin
		if (frame_pulse_notify_vld = '1') then
			frame_pulse_notify_reg <= frame_pulse_notify_out;
		end if;
	end process;

	-- Output Processes
	process(rst, done_sig)
	begin
		if (rst = '1') then
		elsif (done_sig = '1') then
		end if;
	end process;

	process(rst, done_sig, idle_sig)
	begin
		if (rst = '1') then
			frame_pulse_notify <= '0';
		else
			if (done_sig = '1') then
				frame_pulse_notify <= frame_pulse_notify_reg;
			elsif (idle_sig = '1') then
				frame_pulse_notify <= '0';
			else
				frame_pulse_notify <= '0';
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
				active_operation_in <= std_logic_vector(to_unsigned(Framer_operation_t'pos(active_operation), 5));
				data_word_sig_markerAlignment_in <= data_word_sig.markerAlignment;
			elsif ((idle_sig = '1' or  ready_sig = '1') and wait_state = '1') then
				start_sig <= '0';
			end if;
		end if;
	end process;

end Framer_arch;
