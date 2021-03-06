library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Framer_operations;
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
	signal frm_cnt: std_logic_vector(31 downto 0);
	signal nextphase: Phases;
	signal align: std_logic_vector(31 downto 0);

	-- Operation Module Inputs
	signal data_word_sig_markerAlignment_in: std_logic_vector(31 downto 0);
	signal active_operation_in: std_logic_vector(4 downto 0);

	-- Module Outputs
	signal oof_sig_out: std_logic;
	signal frame_pulse_sig_out: std_logic;
	signal frame_pulse_notify_out: std_logic;

	-- Monitor Signals
	signal next_state: Framer_state_t;
	signal active_operation: Framer_operation_t;
	signal active_state: Framer_state_t;

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


	component Framer_operations is
	port(
		ap_clk: in std_logic;
		ap_rst: in std_logic;
		data_word_sig_markerAlignment_V: in std_logic_vector(31 downto 0);
		oof_sig: out std_logic;
		frame_pulse_sig: out std_logic;
		frm_cnt_V: out std_logic_vector(31 downto 0);
		nextphase: out std_logic_vector(2 downto 0);
		align_V: out std_logic_vector(31 downto 0);
		frame_pulse_notify: out std_logic;
		active_operation: in std_logic_vector(4 downto 0)
	);
	end component;

begin

	operations_inst: Framer_operations
	port map(
		ap_clk => clk,
		ap_rst => rst,
		data_word_sig_markerAlignment_V => data_word_sig_markerAlignment_in,
		oof_sig => oof_sig_out,
		frame_pulse_sig => frame_pulse_sig_out,
		frm_cnt_V => frm_cnt,
		nextphase => nextphase,
		align_V => align,
		frame_pulse_notify => frame_pulse_notify_out,
		active_operation => active_operation_in
	);

	-- Monitor
	process (active_state, data_word_sync, data_word_sig.markerAlignment, data_word_sig.isMarker, frm_cnt, nextphase, align)
	begin
		case active_state is
		when st_state_1 =>
			if (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and data_word_sig.isMarker) = '1' then 
				active_operation <= op_state_1_1;
				next_state <= st_state_2;
			elsif (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and not(data_word_sig.isMarker) and bool_to_sl(nextphase = SEARCH)) = '1' then 
				active_operation <= op_state_1_3;
				next_state <= st_state_1;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and data_word_sig.isMarker) = '1' then 
				active_operation <= op_state_1_5;
				next_state <= st_state_2;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and not(data_word_sig.isMarker) and bool_to_sl(nextphase = SEARCH)) = '1' then 
				active_operation <= op_state_1_7;
				next_state <= st_state_1;
			else
				active_operation <= op_state_1_10;
				next_state <= st_state_1;
			end if;
		when st_state_2 =>
			if (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not((data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)))) = '1' then 
				active_operation <= op_state_2_11;
				next_state <= st_state_1;
			elsif (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)) = '1' then 
				active_operation <= op_state_2_13;
				next_state <= st_state_3;
			elsif (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and not(bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and bool_to_sl(nextphase = FIND_SYNC)) = '1' then 
				active_operation <= op_state_2_15;
				next_state <= st_state_2;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not((data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)))) = '1' then 
				active_operation <= op_state_2_17;
				next_state <= st_state_1;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)) = '1' then 
				active_operation <= op_state_2_19;
				next_state <= st_state_3;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and not(bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and bool_to_sl(nextphase = FIND_SYNC)) = '1' then 
				active_operation <= op_state_2_21;
				next_state <= st_state_2;
			else
				active_operation <= op_state_2_24;
				next_state <= st_state_2;
			end if;
		when st_state_3 =>
			if (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not((data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)))) = '1' then 
				active_operation <= op_state_3_25;
				next_state <= st_state_4;
			elsif (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)) = '1' then 
				active_operation <= op_state_3_27;
				next_state <= st_state_3;
			elsif (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and not(bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and bool_to_sl(nextphase = SYNC)) = '1' then 
				active_operation <= op_state_3_29;
				next_state <= st_state_3;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not((data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)))) = '1' then 
				active_operation <= op_state_3_31;
				next_state <= st_state_4;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)) = '1' then 
				active_operation <= op_state_3_33;
				next_state <= st_state_3;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and not(bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and bool_to_sl(nextphase = SYNC)) = '1' then 
				active_operation <= op_state_3_35;
				next_state <= st_state_3;
			else
				active_operation <= op_state_3_38;
				next_state <= st_state_3;
			end if;
		when st_state_4 =>
			if (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not((data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)))) = '1' then 
				active_operation <= op_state_4_39;
				next_state <= st_state_1;
			elsif (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)) = '1' then 
				active_operation <= op_state_4_41;
				next_state <= st_state_3;
			elsif (data_word_sync and bool_to_sl(frm_cnt = FRM_PULSE_POS) and not(bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and bool_to_sl(nextphase = MISS)) = '1' then 
				active_operation <= op_state_4_43;
				next_state <= st_state_4;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and not((data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)))) = '1' then 
				active_operation <= op_state_4_45;
				next_state <= st_state_1;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000") and data_word_sig.isMarker and bool_to_sl(align = data_word_sig.markerAlignment)) = '1' then 
				active_operation <= op_state_4_47;
				next_state <= st_state_3;
			elsif (data_word_sync and not(bool_to_sl(frm_cnt = FRM_PULSE_POS)) and not(bool_to_sl(((x"00000001" + signed(frm_cnt)) rem signed(WORDS_IN_FRAME)) = x"00000000")) and bool_to_sl(nextphase = MISS)) = '1' then 
				active_operation <= op_state_4_49;
				next_state <= st_state_4;
			else
				active_operation <= op_state_4_52;
				next_state <= st_state_4;
			end if;
		end case;
	end process;


	-- Operation Module Outputs
	oof_sig <= oof_sig_out;
	frame_pulse_sig <= frame_pulse_sig_out;

	-- Notify Signals
	frame_pulse_notify <= frame_pulse_notify_out;

	-- Operation Module Inputs
	active_operation_in <= active_operation;
	data_word_sig_markerAlignment_in <= data_word_sig.markerAlignment;

	-- Control process
	process (clk, rst)
	begin
		if (rst = '1') then
			active_state <= st_state_1;
		elsif (clk = '1' and clk'event) then
			active_state <= next_state;
		end if;
	end process;

end Framer_arch;
