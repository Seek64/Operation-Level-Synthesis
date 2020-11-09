-- SYNC AND NOTIFY SIGNALS (1-cycle macros) --
macro data_word_sync : boolean := true; end macro;
macro frame_pulse_notify : boolean := next(framer_comp/frame_pulse,2); end  macro;


-- DP SIGNALS --
--macro data_word_sig : marker_t :={false, resize(0,32)} end macro;
macro data_word_sig_isMarker : boolean := (MarkerPosition /= 8); end macro;
macro data_word_sig_markerAlignment : int :=
  if prev(reset_n)=0 then
      8;
    elsif prev(reset_n,2)=0 then
      if prev(data_in)&data_in = FRAMEMARK_C then 0;
      else 8;
      end if;
    else
      if (prev(data_in,2)&prev(data_in)&data_in)(15 downto 0) = FRAMEMARK_C then 0;
      elsif (prev(data_in,2)&prev(data_in)&data_in)(16 downto 1) = FRAMEMARK_C then 1;
      elsif (prev(data_in,2)&prev(data_in)&data_in)(17 downto 2) = FRAMEMARK_C then 2;
      elsif (prev(data_in,2)&prev(data_in)&data_in)(18 downto 3) = FRAMEMARK_C then 3;
      elsif (prev(data_in,2)&prev(data_in)&data_in)(19 downto 4) = FRAMEMARK_C then 4;
      elsif (prev(data_in,2)&prev(data_in)&data_in)(20 downto 5) = FRAMEMARK_C then 5;
      elsif (prev(data_in,2)&prev(data_in)&data_in)(21 downto 6) = FRAMEMARK_C then 6;
      elsif (prev(data_in,2)&prev(data_in)&data_in)(22 downto 7) = FRAMEMARK_C then 7;
      else 8;
      end if;
    end if;
end macro;
macro frame_pulse_sig : boolean := next(framer_comp/frame_pulse,2); end macro;
macro lof_sig : boolean := framer_comp/lof; end macro;
macro oof_sig : boolean := not next(framer_comp/synchronized,2); end macro;


-- CONSTRAINTS --
macro rst: boolean := not(framer_comp/reset_n); end macro;
constraint no_reset := rst = '0'; end constraint;


-- VISIBLE REGISTERS --
macro align : unsigned := next(framer_comp/prev_alignment,2); end macro;
macro frm_cnt : unsigned :=
  if(  next(framer_comp/frame_cnt_int,2) = 0 ) then 61;
  elsif (  next(framer_comp/frame_cnt_int,2) = 1 ) then 62;
  elsif (  next(framer_comp/frame_cnt_int,2) = 2 ) then 63;
  elsif (  next(framer_comp/frame_cnt_int,2) = 3 ) then 0;
  else unsigned( next(framer_comp/frame_cnt_int,2) - 3 );
  end if;
end macro;
macro WORDS_IN_FRAME : int := 64; end macro;
macro FRM_PULSE_POS : int := 0; end macro;
macro nextphase : Phases :=
  if(state_1) then SEARCH;
  elsif (state_2) then FIND_SYNC;
  elsif (state_3) then SYNC;
  elsif (state_4) then MISS;
  else INITIALISE;
  end if;
end macro;


-- STATES --
macro state_1 : boolean :=
  next(framer_comp/prev_miss,2) and not next(synchronized,2) and
  if prev(MarkerIn) and not (prev(reset_n)=0) then
      prev(MarkerPosition) /= prev(Align);
  end if and
  if prev(reset_n,2)=0 then
      framer_comp/data_buffer(22 downto 8) = 0
  end if;
end macro;
macro state_2 : boolean :=
  not next(framer_comp/prev_miss,2) and not next(synchronized) and
  not next(synchronized) and
  not next(framer_comp/prev_miss,2) and
  (not next(framer_comp/sync_hit) or not next(synchronized,2));
end macro;
macro state_3 : boolean := not next(framer_comp/prev_miss,2) and next(synchronized,2); end macro;
macro state_4 : boolean := next(framer_comp/prev_miss,2) and synchronized and next(synchronized,2); end macro;

-- HELPER --
macro FRAMEMARK_C : unsigned :=  framer_comp/FRAMEMARK_C; end macro;
macro MarkerPosition : unsigned :=
  if prev(reset_n)=0 then
    8;
  elsif prev(reset_n,2)=0 then
    if prev(data_in)&data_in = framer_comp/FRAMEMARK_C then 0;
    else 8;
    end if;
  else
    if (prev(data_in,2)&prev(data_in)&data_in)(15 downto 0) = framer_comp/FRAMEMARK_C then 0;
    elsif (prev(data_in,2)&prev(data_in)&data_in)(16 downto 1) = framer_comp/FRAMEMARK_C then 1;
    elsif (prev(data_in,2)&prev(data_in)&data_in)(17 downto 2) = framer_comp/FRAMEMARK_C then 2;
    elsif (prev(data_in,2)&prev(data_in)&data_in)(18 downto 3) = framer_comp/FRAMEMARK_C then 3;
    elsif (prev(data_in,2)&prev(data_in)&data_in)(19 downto 4) = framer_comp/FRAMEMARK_C then 4;
    elsif (prev(data_in,2)&prev(data_in)&data_in)(20 downto 5) = framer_comp/FRAMEMARK_C then 5;
    elsif (prev(data_in,2)&prev(data_in)&data_in)(21 downto 6) = framer_comp/FRAMEMARK_C then 6;
    elsif (prev(data_in,2)&prev(data_in)&data_in)(22 downto 7) = framer_comp/FRAMEMARK_C then 7;
    else 8;
    end if;
  end if;
end macro;
macro MarkerIn : bit :=
  if MarkerPosition = 8 then
    '0';
  else
    '1';
  end if;
end macro;
