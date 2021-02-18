-- 
-- Politecnico di Milano
-- Code created using PandA - Version: PandA 0.9.6 - Revision 5e5e306b86383a7d85274d64977a3d71fdcff4fe-master - Date 2020-11-22T12:55:52
-- /opt/panda/bin/bambu executed with: /opt/panda/bin/bambu --top-fname=z_sig --writer H ../z_sig.cpp 
-- 
-- Send any bug to: panda-info@polimi.it
-- ************************************************************************
-- The following text holds for all the components tagged with PANDA_LGPLv3.
-- They are all part of the BAMBU/PANDA IP LIBRARY.
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 3 of the License, or (at your option) any later version.
-- 
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public
-- License along with the PandA framework; see the files COPYING.LIB
-- If not, see <http://www.gnu.org/licenses/>.
-- ************************************************************************


library IEEE;
use IEEE.numeric_std.all;

package panda_pkg is
   function resize_signed(input : signed; size : integer) return signed;
end;

package body panda_pkg is
   function resize_signed(input : signed; size : integer) return signed is
   begin
     if (size > input'length) then
       return resize(input, size);
     else
       return input(size-1+input'right downto input'right);
     end if;
   end function;
end package body;

-- This component is part of the BAMBU/PANDA IP LIBRARY
-- Copyright (C) 2004-2020 Politecnico di Milano
-- Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>, Christian Pilato <christian.pilato@polimi.it>
-- License: PANDA_LGPLv3
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity constant_value is 
generic(
 BITSIZE_out1: integer;
 value: std_logic_vector);
port (
  -- OUT
  out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 

);
end constant_value;

architecture constant_value_arch of constant_value is
  begin
   out1 <= value;
end constant_value_arch;

-- This component is part of the BAMBU/PANDA IP LIBRARY
-- Copyright (C) 2004-2020 Politecnico di Milano
-- Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
-- License: PANDA_LGPLv3
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity cond_expr_FU is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_in2: integer;
 BITSIZE_in3: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  in1 : in std_logic_vector(BITSIZE_in1-1 downto 0) ;
  in2 : in signed (BITSIZE_in2-1 downto 0);
  in3 : in signed (BITSIZE_in3-1 downto 0);
  -- OUT
  out1 : out signed (BITSIZE_out1-1 downto 0)

);
end cond_expr_FU;

architecture cond_expr_FU_arch of cond_expr_FU is
  constant zeroes : std_logic_vector(in1'range) := (others => '0');
  begin
    out1 <= resize_signed(in2, BITSIZE_out1) when (in1 /= zeroes) else resize_signed(in3, BITSIZE_out1);

end cond_expr_FU_arch;

-- This component is part of the BAMBU/PANDA IP LIBRARY
-- Copyright (C) 2004-2020 Politecnico di Milano
-- Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
-- License: PANDA_LGPLv3
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity lshift_expr_FU is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_in2: integer;
 BITSIZE_out1: integer;
 PRECISION: integer);
port (
  -- IN
  in1 : in signed (BITSIZE_in1-1 downto 0);
  in2 : in std_logic_vector(BITSIZE_in2-1 downto 0) ;
  -- OUT
  out1 : out signed (BITSIZE_out1-1 downto 0)

);
end lshift_expr_FU;

architecture lshift_expr_FU_arch of lshift_expr_FU is
  begin
    process(in1, in2)
    begin
      out1 <= shift_left(resize_signed(in1, BITSIZE_out1), to_integer(unsigned(in2) rem PRECISION));
    end process;

end lshift_expr_FU_arch;

-- This component is part of the BAMBU/PANDA IP LIBRARY
-- Copyright (C) 2004-2020 Politecnico di Milano
-- Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
-- License: PANDA_LGPLv3
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity rshift_expr_FU is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_in2: integer;
 BITSIZE_out1: integer;
 PRECISION: integer);
port (
  -- IN
  in1 : in signed (BITSIZE_in1-1 downto 0);
  in2 : in std_logic_vector(BITSIZE_in2-1 downto 0) ;
  -- OUT
  out1 : out signed (BITSIZE_out1-1 downto 0)

);
end rshift_expr_FU;

architecture rshift_expr_FU_arch of rshift_expr_FU is
  begin
    process(in1, in2)
    begin
      out1 <= resize_signed(shift_right(in1, to_integer(unsigned(in2) rem PRECISION)), BITSIZE_out1);
    end process;

end rshift_expr_FU_arch;

-- This component is part of the BAMBU/PANDA IP LIBRARY
-- Copyright (C) 2004-2020 Politecnico di Milano
-- Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
-- License: PANDA_LGPLv3
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity ui_eq_expr_FU is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_in2: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  in1 : in unsigned (BITSIZE_in1-1 downto 0);
  in2 : in unsigned (BITSIZE_in2-1 downto 0);
  -- OUT
  out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 

);
end ui_eq_expr_FU;

architecture ui_eq_expr_FU_arch of ui_eq_expr_FU is
  begin
    out1 <= std_logic_vector(resize(to_unsigned(1, BITSIZE_out1), BITSIZE_out1)) when (in1 = in2) else (others => '0');

end ui_eq_expr_FU_arch;

-- Datapath RTL description for z_sig
-- This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
-- Author(s): Component automatically generated by bambu
-- License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity datapath_z_sig is 
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  in_port_x_sig : in signed (31 downto 0);
  in_port_Z_SIG0 : in signed (31 downto 0);
  in_port_x_notify : in std_logic_vector(0 downto 0);
  in_port_z_notify : in std_logic_vector(0 downto 0);
  in_port_active_operation : in unsigned (31 downto 0);
  -- OUT
  return_port : out signed (31 downto 0)

);
end datapath_z_sig;

architecture datapath_z_sig_arch of datapath_z_sig is
  -- Component and signal declarations
  
  component constant_value
  generic(
   BITSIZE_out1: integer;
   value: std_logic_vector);
  port (
    -- OUT
    out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 
  
  );
  end component;
  
  component cond_expr_FU
  generic(
   BITSIZE_in1: integer;
   BITSIZE_in2: integer;
   BITSIZE_in3: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    in1 : in std_logic_vector(BITSIZE_in1-1 downto 0) ;
    in2 : in signed (BITSIZE_in2-1 downto 0);
    in3 : in signed (BITSIZE_in3-1 downto 0);
    -- OUT
    out1 : out signed (BITSIZE_out1-1 downto 0)
  
  );
  end component;
  
  component lshift_expr_FU
  generic(
   BITSIZE_in1: integer;
   BITSIZE_in2: integer;
   BITSIZE_out1: integer;
   PRECISION: integer);
  port (
    -- IN
    in1 : in signed (BITSIZE_in1-1 downto 0);
    in2 : in std_logic_vector(BITSIZE_in2-1 downto 0) ;
    -- OUT
    out1 : out signed (BITSIZE_out1-1 downto 0)
  
  );
  end component;
  
  component rshift_expr_FU
  generic(
   BITSIZE_in1: integer;
   BITSIZE_in2: integer;
   BITSIZE_out1: integer;
   PRECISION: integer);
  port (
    -- IN
    in1 : in signed (BITSIZE_in1-1 downto 0);
    in2 : in std_logic_vector(BITSIZE_in2-1 downto 0) ;
    -- OUT
    out1 : out signed (BITSIZE_out1-1 downto 0)
  
  );
  end component;
  
  component ui_eq_expr_FU
  generic(
   BITSIZE_in1: integer;
   BITSIZE_in2: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    in1 : in unsigned (BITSIZE_in1-1 downto 0);
    in2 : in unsigned (BITSIZE_in2-1 downto 0);
    -- OUT
    out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 
  
  );
  end component;
  signal out_cond_expr_FU_32_32_32_32_3_i0_fu_z_sig_26642_26718 : signed (30 downto 0);
  signal out_const_0 : std_logic_vector(0 downto 0);
  signal out_const_1 : std_logic_vector(1 downto 0) ;
  signal out_lshift_expr_FU_32_0_32_4_i0_fu_z_sig_26642_26683 : signed (31 downto 0);
  signal out_lshift_expr_FU_32_0_32_4_i1_fu_z_sig_26642_26729 : signed (31 downto 0);
  signal out_rshift_expr_FU_32_0_32_5_i0_fu_z_sig_26642_26722 : signed (30 downto 0);
  signal out_ui_eq_expr_FU_32_0_32_6_i0_fu_z_sig_26642_26715 : std_logic_vector(0 downto 0);
begin
  const_0 : constant_value generic map(BITSIZE_out1=>1, value=>"0") port map (out1 => out_const_0);
  const_1 : constant_value generic map(BITSIZE_out1=>2, value=>"01") port map (out1 => out_const_1);
  fu_z_sig_26642_26683 : lshift_expr_FU generic map(BITSIZE_in1=>32, BITSIZE_in2=>2, BITSIZE_out1=>32, PRECISION=>32) port map (out1 => out_lshift_expr_FU_32_0_32_4_i0_fu_z_sig_26642_26683, in1 => in_port_x_sig, in2 => out_const_1);
  fu_z_sig_26642_26715 : ui_eq_expr_FU generic map(BITSIZE_in1=>32, BITSIZE_in2=>1, BITSIZE_out1=>1) port map (out1 => out_ui_eq_expr_FU_32_0_32_6_i0_fu_z_sig_26642_26715, in1 => in_port_active_operation, in2 => unsigned(out_const_0));
  fu_z_sig_26642_26718 : cond_expr_FU generic map(BITSIZE_in1=>1, BITSIZE_in2=>31, BITSIZE_in3=>1, BITSIZE_out1=>31) port map (out1 => out_cond_expr_FU_32_32_32_32_3_i0_fu_z_sig_26642_26718, in1 => out_ui_eq_expr_FU_32_0_32_6_i0_fu_z_sig_26642_26715, in2 => out_rshift_expr_FU_32_0_32_5_i0_fu_z_sig_26642_26722, in3 => signed(out_const_0));
  fu_z_sig_26642_26722 : rshift_expr_FU generic map(BITSIZE_in1=>32, BITSIZE_in2=>2, BITSIZE_out1=>31, PRECISION=>32) port map (out1 => out_rshift_expr_FU_32_0_32_5_i0_fu_z_sig_26642_26722, in1 => out_lshift_expr_FU_32_0_32_4_i0_fu_z_sig_26642_26683, in2 => out_const_1);
  fu_z_sig_26642_26729 : lshift_expr_FU generic map(BITSIZE_in1=>31, BITSIZE_in2=>2, BITSIZE_out1=>32, PRECISION=>32) port map (out1 => out_lshift_expr_FU_32_0_32_4_i1_fu_z_sig_26642_26729, in1 => out_cond_expr_FU_32_32_32_32_3_i0_fu_z_sig_26642_26718, in2 => out_const_1);
  -- io-signal post fix
  return_port <= out_lshift_expr_FU_32_0_32_4_i1_fu_z_sig_26642_26729;

end datapath_z_sig_arch;

-- FSM based controller description for z_sig
-- This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
-- Author(s): Component automatically generated by bambu
-- License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity controller_z_sig is 
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  start_port : in std_logic;
  -- OUT
  done_port : out std_logic

);
end controller_z_sig;

architecture controller_z_sig_arch of controller_z_sig is
  -- define the states of FSM model
  constant S_0: std_logic_vector(0 downto 0) := "1";
  signal present_state, next_state : std_logic_vector(0 downto 0);
begin
  -- concurrent process#1: state registers
  state_reg: process(clock)
  begin
    if (clock'event and clock='1') then
      if (reset='0') then
        present_state <= S_0;
      else
        present_state <= next_state;
      end if;
    end if;
  end process;
  -- concurrent process#0: combinational logic
  comb_logic0: process(present_state, start_port)
  begin
    done_port <= '0';
    next_state <= S_0;
    case present_state is
      when S_0 =>
        if(start_port /= '1') then
          next_state <= S_0;
        else
          next_state <= S_0;
          done_port <= '1';
        end if;
      when others =>
    end case;
  end process;

end controller_z_sig_arch;

-- Top component for z_sig
-- This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
-- Author(s): Component automatically generated by bambu
-- License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity \_z_sig\ is 
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  start_port : in std_logic;
  x_sig : in signed (31 downto 0);
  Z_SIG0 : in signed (31 downto 0);
  x_notify : in std_logic_vector(0 downto 0);
  z_notify : in std_logic_vector(0 downto 0);
  active_operation : in unsigned (31 downto 0);
  -- OUT
  done_port : out std_logic;
  return_port : out signed (31 downto 0)

);
end \_z_sig\;

architecture \_z_sig_arch\ of \_z_sig\ is
  -- Component and signal declarations
  
  component datapath_z_sig
  port (
    -- IN
    clock : in std_logic;
    reset : in std_logic;
    in_port_x_sig : in signed (31 downto 0);
    in_port_Z_SIG0 : in signed (31 downto 0);
    in_port_x_notify : in std_logic_vector(0 downto 0);
    in_port_z_notify : in std_logic_vector(0 downto 0);
    in_port_active_operation : in unsigned (31 downto 0);
    -- OUT
    return_port : out signed (31 downto 0)
  
  );
  end component;
  
  component controller_z_sig
  port (
    -- IN
    clock : in std_logic;
    reset : in std_logic;
    start_port : in std_logic;
    -- OUT
    done_port : out std_logic
  
  );
  end component;
begin
  Controller_i : controller_z_sig port map (done_port => done_port, clock => clock, reset => reset, start_port => start_port);
  Datapath_i : datapath_z_sig port map (return_port => return_port, clock => clock, reset => reset, in_port_x_sig => x_sig, in_port_Z_SIG0 => Z_SIG0, in_port_x_notify => x_notify, in_port_z_notify => z_notify, in_port_active_operation => active_operation);

end \_z_sig_arch\;

-- This component is part of the BAMBU/PANDA IP LIBRARY
-- Copyright (C) 2004-2020 Politecnico di Milano
-- Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
-- License: PANDA_LGPLv3
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity view_convert_expr_FU is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  in1 : in signed (BITSIZE_in1-1 downto 0);
  -- OUT
  out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 

);
end view_convert_expr_FU;

architecture view_convert_expr_FU_arch of view_convert_expr_FU is
  begin
  out1 <= std_logic_vector(resize(signed(in1), BITSIZE_out1));
end view_convert_expr_FU_arch;

-- Minimal interface for function: z_sig
-- This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
-- Author(s): Component automatically generated by bambu
-- License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
-- synthesis translate_off
use STD.env.all;
-- synthesis translate_on
use work.panda_pkg.all;
entity z_sig is 
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  start_port : in std_logic;
  x_sig : in std_logic_vector(31 downto 0) ;
  Z_SIG0 : in std_logic_vector(31 downto 0) ;
  x_notify : in std_logic_vector(0 downto 0);
  z_notify : in std_logic_vector(0 downto 0);
  active_operation : in std_logic_vector(31 downto 0) ;
  -- OUT
  done_port : out std_logic;
  return_port : out std_logic_vector(31 downto 0) 

);
end z_sig;

architecture z_sig_arch of z_sig is
  -- Component and signal declarations
  
  component \_z_sig\
  port (
    -- IN
    clock : in std_logic;
    reset : in std_logic;
    start_port : in std_logic;
    x_sig : in signed (31 downto 0);
    Z_SIG0 : in signed (31 downto 0);
    x_notify : in std_logic_vector(0 downto 0);
    z_notify : in std_logic_vector(0 downto 0);
    active_operation : in unsigned (31 downto 0);
    -- OUT
    done_port : out std_logic;
    return_port : out signed (31 downto 0)
  
  );
  end component;
  
  component view_convert_expr_FU
  generic(
   BITSIZE_in1: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    in1 : in signed (BITSIZE_in1-1 downto 0);
    -- OUT
    out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 
  
  );
  end component;
  signal out_return_port_view_convert_expr_FU : signed (31 downto 0);
begin
  \_z_sig_i0\ : \_z_sig\ port map (done_port => done_port, return_port => out_return_port_view_convert_expr_FU, clock => clock, reset => reset, start_port => start_port, x_sig => signed(x_sig), Z_SIG0 => signed(Z_SIG0), x_notify => x_notify, z_notify => z_notify, active_operation => unsigned(active_operation));
  return_port_view_convert_expr_FU : view_convert_expr_FU generic map(BITSIZE_in1=>32, BITSIZE_out1=>32) port map (out1 => return_port, in1 => out_return_port_view_convert_expr_FU);

end z_sig_arch;


