-- 
-- Politecnico di Milano
-- Code created using PandA - Version: PandA 0.9.6 - Revision 5e5e306b86383a7d85274d64977a3d71fdcff4fe-master - Date 2021-01-30T11:57:16
-- /opt/panda/bin/bambu executed with: /opt/panda/bin/bambu --top-fname=ADDING_operations --writer H --generate-interface=INFER ../ADDING_FABRIZIO.cpp 
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
entity register_STD is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  in1 : in std_logic_vector(BITSIZE_in1-1 downto 0) ;
  wenable : in std_logic;
  -- OUT
  out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 

);
end register_STD;

architecture register_STD_arch of register_STD is
  
  signal reg_out1 : std_logic_vector(BITSIZE_out1-1 downto 0) := (others => '0');
  begin
  out1 <= reg_out1;
  process(clock)
  begin
    if(clock'event and clock = '1') then
      reg_out1 <= in1;
    end if;
  end process;

end register_STD_arch;

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
entity IUdata_converter_FU is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  in1 : in signed (BITSIZE_in1-1 downto 0);
  -- OUT
  out1 : out unsigned (BITSIZE_out1-1 downto 0)

);
end IUdata_converter_FU;

architecture IUdata_converter_FU_arch of IUdata_converter_FU is
  begin
    process(in1)
    begin
      if(BITSIZE_out1 <= BITSIZE_in1) then
        out1 <= unsigned(in1(BITSIZE_out1-1 downto 0));
      else
        out1 <= unsigned(resize(in1, BITSIZE_out1));
      end if;
    end process;
end IUdata_converter_FU_arch;

-- This component is part of the BAMBU/PANDA IP LIBRARY
-- Copyright (C) 2016-2020 Politecnico di Milano
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
entity lut_expr_FU is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  in1 : in std_logic_vector(BITSIZE_in1-1 downto 0) ;
  in2 : in std_logic;
  in3 : in std_logic;
  in4 : in std_logic;
  in5 : in std_logic;
  in6 : in std_logic;
  in7 : in std_logic;
  in8 : in std_logic;
  in9 : in std_logic;
  -- OUT
  out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 

);
end lut_expr_FU;

architecture lut_expr_FU_arch of lut_expr_FU is
    signal in0 : std_logic_vector(7 downto 0);
    signal shifted_s : unsigned(in1'range) := (others => '0');
  begin
    in0(0) <= in2;
    in0(1) <= in3;
    in0(2) <= in4;
    in0(3) <= in5;
    in0(4) <= in6;
    in0(5) <= in7;
    in0(6) <= in8;
    in0(7) <= in9;
    out1 <= std_logic_vector(resize(to_unsigned(1, BITSIZE_out1), BITSIZE_out1)) when (shifted_s(0) = '1') else (others => '0');
    process(in0, in1)
    begin
      shifted_s <= shift_right(unsigned(in1), to_integer(unsigned(in0)));
    end process;

end lut_expr_FU_arch;

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
entity multi_read_cond_FU is 
generic(
 BITSIZE_in1: integer;
 PORTSIZE_in1: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  in1 : in std_logic_vector((PORTSIZE_in1*BITSIZE_in1)+(-1) downto 0) ;
  -- OUT
  out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 

);
end multi_read_cond_FU;

architecture multi_read_cond_FU_arch of multi_read_cond_FU is
  begin
    out1 <= in1;
end multi_read_cond_FU_arch;

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
entity MUX_GATE is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_in2: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  sel : in std_logic;
  in1 : in std_logic_vector(BITSIZE_in1-1 downto 0) ;
  in2 : in std_logic_vector(BITSIZE_in2-1 downto 0) ;
  -- OUT
  out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 

);
end MUX_GATE;

architecture MUX_GATE_arch of MUX_GATE is
  begin
  out1 <= in1 when sel='1' else in2;
end MUX_GATE_arch;

-- Datapath RTL description for ADDING_operations
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
entity datapath_ADDING_operations is 
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  in_port_x_sig : in signed (31 downto 0);
  in_port_z_sig : in std_logic_vector(31 downto 0) ;
  in_port_x_notify : in std_logic_vector(31 downto 0) ;
  in_port_z_notify : in std_logic_vector(31 downto 0) ;
  in_port_active_operation : in unsigned (31 downto 0);
  selector_IN_UNBOUNDED_ADDING_operations_26642_26769 : in std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26785 : in std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26801 : in std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26817 : in std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26833 : in std_logic;
  selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 : in std_logic;
  selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 : in std_logic;
  wrenable_reg_0 : in std_logic;
  fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 : in std_logic;
  fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 : in std_logic;
  fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 : in std_logic;
  fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 : in std_logic;
  -- OUT
  \_x_notify\ : out std_logic_vector(0 downto 0);
  \_x_notify_vld\ : out std_logic;
  \_z_notify\ : out std_logic_vector(0 downto 0);
  \_z_notify_vld\ : out std_logic;
  \_z_sig\ : out std_logic_vector(31 downto 0) ;
  \_z_sig_vld\ : out std_logic;
  OUT_MULTIIF_ADDING_operations_26642_26836 : out std_logic_vector(1 downto 0) ;
  OUT_UNBOUNDED_ADDING_operations_26642_26769 : out std_logic;
  OUT_UNBOUNDED_ADDING_operations_26642_26785 : out std_logic;
  OUT_UNBOUNDED_ADDING_operations_26642_26801 : out std_logic;
  OUT_UNBOUNDED_ADDING_operations_26642_26817 : out std_logic;
  OUT_UNBOUNDED_ADDING_operations_26642_26833 : out std_logic

);
end datapath_ADDING_operations;

architecture datapath_ADDING_operations_arch of datapath_ADDING_operations is
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
  
  component register_STD
  generic(
   BITSIZE_in1: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    clock : in std_logic;
    reset : in std_logic;
    in1 : in std_logic_vector(BITSIZE_in1-1 downto 0) ;
    wenable : in std_logic;
    -- OUT
    out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 
  
  );
  end component;
  
  component IUdata_converter_FU
  generic(
   BITSIZE_in1: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    in1 : in signed (BITSIZE_in1-1 downto 0);
    -- OUT
    out1 : out unsigned (BITSIZE_out1-1 downto 0)
  
  );
  end component;
  
  component lut_expr_FU
  generic(
   BITSIZE_in1: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    in1 : in std_logic_vector(BITSIZE_in1-1 downto 0) ;
    in2 : in std_logic;
    in3 : in std_logic;
    in4 : in std_logic;
    in5 : in std_logic;
    in6 : in std_logic;
    in7 : in std_logic;
    in8 : in std_logic;
    in9 : in std_logic;
    -- OUT
    out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 
  
  );
  end component;
  
  component multi_read_cond_FU
  generic(
   BITSIZE_in1: integer;
   PORTSIZE_in1: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    in1 : in std_logic_vector((PORTSIZE_in1*BITSIZE_in1)+(-1) downto 0) ;
    -- OUT
    out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 
  
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
  
  component x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32
  generic(
   BITSIZE_in1: integer;
   PORTSIZE_in1: integer;
   BITSIZE_in2: integer;
   PORTSIZE_in2: integer;
   BITSIZE_in3: integer;
   PORTSIZE_in3: integer);
  port (
    -- IN
    start_port : in std_logic_vector (0 downto 0);
    in1 : in std_logic_vector((PORTSIZE_in1*BITSIZE_in1)+(-1) downto 0) ;
    in2 : in std_logic_vector((PORTSIZE_in2*BITSIZE_in2)+(-1) downto 0) ;
    in3 : in std_logic_vector((PORTSIZE_in3*BITSIZE_in3)+(-1) downto 0) ;
    -- OUT
    \_x_notify\ : out std_logic_vector(0 downto 0);
    \_x_notify_vld\ : out std_logic
  
  );
  end component;
  
  component z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32
  generic(
   BITSIZE_in1: integer;
   PORTSIZE_in1: integer;
   BITSIZE_in2: integer;
   PORTSIZE_in2: integer;
   BITSIZE_in3: integer;
   PORTSIZE_in3: integer);
  port (
    -- IN
    start_port : in std_logic_vector (0 downto 0);
    in1 : in std_logic_vector((PORTSIZE_in1*BITSIZE_in1)+(-1) downto 0) ;
    in2 : in std_logic_vector((PORTSIZE_in2*BITSIZE_in2)+(-1) downto 0) ;
    in3 : in std_logic_vector((PORTSIZE_in3*BITSIZE_in3)+(-1) downto 0) ;
    -- OUT
    \_z_notify\ : out std_logic_vector(0 downto 0);
    \_z_notify_vld\ : out std_logic
  
  );
  end component;
  
  component z_sig_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32
  generic(
   BITSIZE_in1: integer;
   PORTSIZE_in1: integer;
   BITSIZE_in2: integer;
   PORTSIZE_in2: integer;
   BITSIZE_in3: integer;
   PORTSIZE_in3: integer);
  port (
    -- IN
    start_port : in std_logic_vector (0 downto 0);
    in1 : in std_logic_vector((PORTSIZE_in1*BITSIZE_in1)+(-1) downto 0) ;
    in2 : in std_logic_vector((PORTSIZE_in2*BITSIZE_in2)+(-1) downto 0) ;
    in3 : in std_logic_vector((PORTSIZE_in3*BITSIZE_in3)+(-1) downto 0) ;
    -- OUT
    \_z_sig\ : out std_logic_vector(31 downto 0) ;
    \_z_sig_vld\ : out std_logic
  
  );
  end component;
  
  component OR_GATE
  generic(
   BITSIZE_in: integer;
   PORTSIZE_in: integer);
  port (
    -- IN
    \in\ : in std_logic_vector((PORTSIZE_in*BITSIZE_in)-1 downto 0) ;
    -- OUT
    out1 : out std_logic
  
  );
  end component;
  
  component MUX_GATE
  generic(
   BITSIZE_in1: integer;
   BITSIZE_in2: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    sel : in std_logic;
    in1 : in std_logic_vector(BITSIZE_in1-1 downto 0) ;
    in2 : in std_logic_vector(BITSIZE_in2-1 downto 0) ;
    -- OUT
    out1 : out std_logic_vector(BITSIZE_out1-1 downto 0) 
  
  );
  end component;
  signal out_IUdata_converter_FU_2_i0_fu_ADDING_operations_26642_26765 : unsigned (31 downto 0);
  signal out_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 : std_logic_vector(0 downto 0);
  signal out_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 : std_logic_vector(0 downto 0);
  signal out_const_0 : std_logic_vector(0 downto 0);
  signal out_const_1 : std_logic_vector(1 downto 0) ;
  signal out_const_2 : std_logic_vector(0 downto 0);
  signal out_const_3 : std_logic_vector(2 downto 0) ;
  signal out_const_4 : std_logic_vector(5 downto 0) ;
  signal out_lshift_expr_FU_32_0_32_7_i0_fu_ADDING_operations_26642_26689 : signed (31 downto 0);
  signal out_lut_expr_FU_3_i0_fu_ADDING_operations_26642_26842 : std_logic_vector(0 downto 0);
  signal out_multi_read_cond_FU_4_i0_fu_ADDING_operations_26642_26836 : std_logic_vector(1 downto 0) ;
  signal out_reg_0_reg_0 : std_logic_vector(31 downto 0) ;
  signal out_ui_eq_expr_FU_32_0_32_8_i0_fu_ADDING_operations_26642_26745 : std_logic_vector(0 downto 0);
  signal out_ui_eq_expr_FU_32_0_32_9_i0_fu_ADDING_operations_26642_26747 : std_logic_vector(0 downto 0);
  signal s_start_port0 : std_logic;
  signal s_start_port1 : std_logic;
begin
  MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 : MUX_GATE generic map(BITSIZE_in1=>1, BITSIZE_in2=>1, BITSIZE_out1=>1) port map (out1 => out_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0, sel => selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0, in1 => out_const_0, in2 => out_const_2);
  MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 : MUX_GATE generic map(BITSIZE_in1=>1, BITSIZE_in2=>1, BITSIZE_out1=>1) port map (out1 => out_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0, sel => selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0, in1 => out_const_0, in2 => out_const_2);
  const_0 : constant_value generic map(BITSIZE_out1=>1, value=>"0") port map (out1 => out_const_0);
  const_1 : constant_value generic map(BITSIZE_out1=>2, value=>"01") port map (out1 => out_const_1);
  const_2 : constant_value generic map(BITSIZE_out1=>1, value=>"1") port map (out1 => out_const_2);
  const_3 : constant_value generic map(BITSIZE_out1=>3, value=>"100") port map (out1 => out_const_3);
  const_4 : constant_value generic map(BITSIZE_out1=>6, value=>"100000") port map (out1 => out_const_4);
  fu_ADDING_operations_26642_26689 : lshift_expr_FU generic map(BITSIZE_in1=>32, BITSIZE_in2=>2, BITSIZE_out1=>32, PRECISION=>32) port map (out1 => out_lshift_expr_FU_32_0_32_7_i0_fu_ADDING_operations_26642_26689, in1 => in_port_x_sig, in2 => out_const_1);
  fu_ADDING_operations_26642_26745 : ui_eq_expr_FU generic map(BITSIZE_in1=>32, BITSIZE_in2=>1, BITSIZE_out1=>1) port map (out1 => out_ui_eq_expr_FU_32_0_32_8_i0_fu_ADDING_operations_26642_26745, in1 => in_port_active_operation, in2 => unsigned(out_const_0));
  fu_ADDING_operations_26642_26747 : ui_eq_expr_FU generic map(BITSIZE_in1=>32, BITSIZE_in2=>1, BITSIZE_out1=>1) port map (out1 => out_ui_eq_expr_FU_32_0_32_9_i0_fu_ADDING_operations_26642_26747, in1 => in_port_active_operation, in2 => unsigned(out_const_2));
  fu_ADDING_operations_26642_26765 : IUdata_converter_FU generic map(BITSIZE_in1=>32, BITSIZE_out1=>32) port map (out1 => out_IUdata_converter_FU_2_i0_fu_ADDING_operations_26642_26765, in1 => out_lshift_expr_FU_32_0_32_7_i0_fu_ADDING_operations_26642_26689);
  fu_ADDING_operations_26642_26769 : z_sig_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32 generic map(BITSIZE_in1=>6, PORTSIZE_in1=>1, BITSIZE_in2=>32, PORTSIZE_in2=>1, BITSIZE_in3=>32, PORTSIZE_in3=>1) port map (\_z_sig\ => \_z_sig\, \_z_sig_vld\ => \_z_sig_vld\, start_port(0) => selector_IN_UNBOUNDED_ADDING_operations_26642_26769, in1(5 downto 0) => out_const_4, in2(31 downto 0) => out_reg_0_reg_0, in3(31 downto 0) => in_port_z_sig);
  fu_ADDING_operations_26642_26836 : multi_read_cond_FU generic map(BITSIZE_in1=>1, PORTSIZE_in1=>2, BITSIZE_out1=>2) port map (out1 => out_multi_read_cond_FU_4_i0_fu_ADDING_operations_26642_26836, in1(1 downto 1) => out_lut_expr_FU_3_i0_fu_ADDING_operations_26642_26842, in1(0 downto 0) => out_ui_eq_expr_FU_32_0_32_8_i0_fu_ADDING_operations_26642_26745);
  fu_ADDING_operations_26642_26842 : lut_expr_FU generic map(BITSIZE_in1=>3, BITSIZE_out1=>1) port map (out1 => out_lut_expr_FU_3_i0_fu_ADDING_operations_26642_26842, in1 => out_const_3, in2 => out_ui_eq_expr_FU_32_0_32_8_i0_fu_ADDING_operations_26642_26745(0), in3 => out_ui_eq_expr_FU_32_0_32_9_i0_fu_ADDING_operations_26642_26747(0), in4 => '0', in5 => '0', in6 => '0', in7 => '0', in8 => '0', in9 => '0');
  s_start_port0 <= selector_IN_UNBOUNDED_ADDING_operations_26642_26785 or selector_IN_UNBOUNDED_ADDING_operations_26642_26801;
  s_start_port1 <= selector_IN_UNBOUNDED_ADDING_operations_26642_26817 or selector_IN_UNBOUNDED_ADDING_operations_26642_26833;
  reg_0 : register_STD generic map(BITSIZE_in1=>32, BITSIZE_out1=>32) port map (out1 => out_reg_0_reg_0, clock => clock, reset => reset, in1 => std_logic_vector(out_IUdata_converter_FU_2_i0_fu_ADDING_operations_26642_26765), wenable => wrenable_reg_0);
  x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0 : x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32 generic map(BITSIZE_in1=>1, PORTSIZE_in1=>1, BITSIZE_in2=>1, PORTSIZE_in2=>1, BITSIZE_in3=>32, PORTSIZE_in3=>1) port map (\_x_notify\ => \_x_notify\, \_x_notify_vld\ => \_x_notify_vld\, start_port(0) => s_start_port0, in1(0 downto 0) => out_const_2, in2(0 downto 0) => out_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0, in3(31 downto 0) => in_port_x_notify);
  z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0 : z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32 generic map(BITSIZE_in1=>1, PORTSIZE_in1=>1, BITSIZE_in2=>1, PORTSIZE_in2=>1, BITSIZE_in3=>32, PORTSIZE_in3=>1) port map (\_z_notify\ => \_z_notify\, \_z_notify_vld\ => \_z_notify_vld\, start_port(0) => s_start_port1, in1(0 downto 0) => out_const_2, in2(0 downto 0) => out_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0, in3(31 downto 0) => in_port_z_notify);
  -- io-signal post fix
  OUT_MULTIIF_ADDING_operations_26642_26836 <= out_multi_read_cond_FU_4_i0_fu_ADDING_operations_26642_26836;

end datapath_ADDING_operations_arch;

-- FSM based controller description for ADDING_operations
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
entity controller_ADDING_operations is 
port (
  -- IN
  OUT_MULTIIF_ADDING_operations_26642_26836 : in std_logic_vector(1 downto 0) ;
  OUT_UNBOUNDED_ADDING_operations_26642_26769 : in std_logic;
  OUT_UNBOUNDED_ADDING_operations_26642_26785 : in std_logic;
  OUT_UNBOUNDED_ADDING_operations_26642_26801 : in std_logic;
  OUT_UNBOUNDED_ADDING_operations_26642_26817 : in std_logic;
  OUT_UNBOUNDED_ADDING_operations_26642_26833 : in std_logic;
  clock : in std_logic;
  reset : in std_logic;
  start_port : in std_logic;
  -- OUT
  done_port : out std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26769 : out std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26785 : out std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26801 : out std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26817 : out std_logic;
  selector_IN_UNBOUNDED_ADDING_operations_26642_26833 : out std_logic;
  selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 : out std_logic;
  selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 : out std_logic;
  wrenable_reg_0 : out std_logic;
  fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 : out std_logic;
  fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 : out std_logic;
  fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 : out std_logic;
  fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 : out std_logic

);
end controller_ADDING_operations;

architecture controller_ADDING_operations_arch of controller_ADDING_operations is
  -- define the states of FSM model
  constant S_0: std_logic_vector(3 downto 0) := "0001";
  constant S_3: std_logic_vector(3 downto 0) := "1000";
  constant S_2: std_logic_vector(3 downto 0) := "0100";
  constant S_1: std_logic_vector(3 downto 0) := "0010";
  signal present_state, next_state : std_logic_vector(3 downto 0);
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
  comb_logic0: process(present_state, OUT_MULTIIF_ADDING_operations_26642_26836, OUT_UNBOUNDED_ADDING_operations_26642_26769, OUT_UNBOUNDED_ADDING_operations_26642_26785, OUT_UNBOUNDED_ADDING_operations_26642_26801, OUT_UNBOUNDED_ADDING_operations_26642_26817, OUT_UNBOUNDED_ADDING_operations_26642_26833, start_port)
  begin
    done_port <= '0';
    selector_IN_UNBOUNDED_ADDING_operations_26642_26769 <= '0';
    selector_IN_UNBOUNDED_ADDING_operations_26642_26785 <= '0';
    selector_IN_UNBOUNDED_ADDING_operations_26642_26801 <= '0';
    selector_IN_UNBOUNDED_ADDING_operations_26642_26817 <= '0';
    selector_IN_UNBOUNDED_ADDING_operations_26642_26833 <= '0';
    selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 <= '0';
    selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 <= '0';
    wrenable_reg_0 <= '0';
    fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 <= '0';
    fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 <= '0';
    fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 <= '0';
    fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 <= '0';
    next_state <= S_0;
    case present_state is
      when S_0 =>
        if(start_port /= '1') then
          selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 <= 'X';
          selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 <= 'X';
          wrenable_reg_0 <= 'X';
          next_state <= S_0;
        else
          wrenable_reg_0 <= '1';
          if (OUT_MULTIIF_ADDING_operations_26642_26836(0) = '1') then
            next_state <= S_1;
            done_port <= '1';
          elsif (OUT_MULTIIF_ADDING_operations_26642_26836(1) = '1') then
            next_state <= S_2;
            done_port <= '1';
            wrenable_reg_0 <= '0';
          else
            next_state <= S_3;
            done_port <= '1';
            wrenable_reg_0 <= '0';
          end if;
        end if;
      when S_3 =>
        next_state <= S_0;
      when S_2 =>
        selector_IN_UNBOUNDED_ADDING_operations_26642_26801 <= '1';
        selector_IN_UNBOUNDED_ADDING_operations_26642_26833 <= '1';
        selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 <= '1';
        fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 <= '1';
        fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 <= '1';
        next_state <= S_0;
      when S_1 =>
        selector_IN_UNBOUNDED_ADDING_operations_26642_26769 <= '1';
        selector_IN_UNBOUNDED_ADDING_operations_26642_26785 <= '1';
        selector_IN_UNBOUNDED_ADDING_operations_26642_26817 <= '1';
        selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 <= '1';
        fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 <= '1';
        fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 <= '1';
        next_state <= S_0;
      when others =>
        selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 <= 'X';
        selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 <= 'X';
        wrenable_reg_0 <= 'X';
    end case;
  end process;

end controller_ADDING_operations_arch;

-- This component is part of the BAMBU/PANDA IP LIBRARY
-- Copyright (C) 2004-2020 Politecnico di Milano
-- Author(s): Marco Lattuada <marco.lattuada@polimi.it>
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
entity flipflop_AR is 
generic(
 BITSIZE_in1: integer;
 BITSIZE_out1: integer);
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  in1 : in std_logic;
  -- OUT
  out1 : out std_logic

);
end flipflop_AR;

architecture flipflop_AR_arch of flipflop_AR is
  
  signal reg_out1 : std_logic := '0';
  begin
    process(clock,reset)
    begin
      if(reset = '0') then
        reg_out1 <= '0';
      elsif(clock'event and clock = '1') then
        reg_out1 <= in1;
      end if;
    end process;
    out1 <= reg_out1;

end flipflop_AR_arch;

-- Top component for ADDING_operations
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
entity \_ADDING_operations\ is 
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  start_port : in std_logic;
  x_sig : in signed (31 downto 0);
  z_sig : in std_logic_vector(31 downto 0) ;
  x_notify : in std_logic_vector(31 downto 0) ;
  z_notify : in std_logic_vector(31 downto 0) ;
  active_operation : in unsigned (31 downto 0);
  -- OUT
  done_port : out std_logic;
  \_x_notify\ : out std_logic_vector(0 downto 0);
  \_x_notify_vld\ : out std_logic;
  \_z_notify\ : out std_logic_vector(0 downto 0);
  \_z_notify_vld\ : out std_logic;
  \_z_sig\ : out std_logic_vector(31 downto 0) ;
  \_z_sig_vld\ : out std_logic

);
end \_ADDING_operations\;

architecture \_ADDING_operations_arch\ of \_ADDING_operations\ is
  -- Component and signal declarations
  
  component datapath_ADDING_operations
  port (
    -- IN
    clock : in std_logic;
    reset : in std_logic;
    in_port_x_sig : in signed (31 downto 0);
    in_port_z_sig : in std_logic_vector(31 downto 0) ;
    in_port_x_notify : in std_logic_vector(31 downto 0) ;
    in_port_z_notify : in std_logic_vector(31 downto 0) ;
    in_port_active_operation : in unsigned (31 downto 0);
    selector_IN_UNBOUNDED_ADDING_operations_26642_26769 : in std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26785 : in std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26801 : in std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26817 : in std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26833 : in std_logic;
    selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 : in std_logic;
    selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 : in std_logic;
    wrenable_reg_0 : in std_logic;
    fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 : in std_logic;
    fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 : in std_logic;
    fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 : in std_logic;
    fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 : in std_logic;
    -- OUT
    \_x_notify\ : out std_logic_vector(0 downto 0);
    \_x_notify_vld\ : out std_logic;
    \_z_notify\ : out std_logic_vector(0 downto 0);
    \_z_notify_vld\ : out std_logic;
    \_z_sig\ : out std_logic_vector(31 downto 0) ;
    \_z_sig_vld\ : out std_logic;
    OUT_MULTIIF_ADDING_operations_26642_26836 : out std_logic_vector(1 downto 0) ;
    OUT_UNBOUNDED_ADDING_operations_26642_26769 : out std_logic;
    OUT_UNBOUNDED_ADDING_operations_26642_26785 : out std_logic;
    OUT_UNBOUNDED_ADDING_operations_26642_26801 : out std_logic;
    OUT_UNBOUNDED_ADDING_operations_26642_26817 : out std_logic;
    OUT_UNBOUNDED_ADDING_operations_26642_26833 : out std_logic
  
  );
  end component;
  
  component controller_ADDING_operations
  port (
    -- IN
    OUT_MULTIIF_ADDING_operations_26642_26836 : in std_logic_vector(1 downto 0) ;
    OUT_UNBOUNDED_ADDING_operations_26642_26769 : in std_logic;
    OUT_UNBOUNDED_ADDING_operations_26642_26785 : in std_logic;
    OUT_UNBOUNDED_ADDING_operations_26642_26801 : in std_logic;
    OUT_UNBOUNDED_ADDING_operations_26642_26817 : in std_logic;
    OUT_UNBOUNDED_ADDING_operations_26642_26833 : in std_logic;
    clock : in std_logic;
    reset : in std_logic;
    start_port : in std_logic;
    -- OUT
    done_port : out std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26769 : out std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26785 : out std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26801 : out std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26817 : out std_logic;
    selector_IN_UNBOUNDED_ADDING_operations_26642_26833 : out std_logic;
    selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 : out std_logic;
    selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 : out std_logic;
    wrenable_reg_0 : out std_logic;
    fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 : out std_logic;
    fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 : out std_logic;
    fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 : out std_logic;
    fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 : out std_logic
  
  );
  end component;
  
  component flipflop_AR
  generic(
   BITSIZE_in1: integer;
   BITSIZE_out1: integer);
  port (
    -- IN
    clock : in std_logic;
    reset : in std_logic;
    in1 : in std_logic;
    -- OUT
    out1 : out std_logic
  
  );
  end component;
  signal OUT_MULTIIF_ADDING_operations_26642_26836 : std_logic_vector(1 downto 0) ;
  signal OUT_UNBOUNDED_ADDING_operations_26642_26769 : std_logic;
  signal OUT_UNBOUNDED_ADDING_operations_26642_26785 : std_logic;
  signal OUT_UNBOUNDED_ADDING_operations_26642_26801 : std_logic;
  signal OUT_UNBOUNDED_ADDING_operations_26642_26817 : std_logic;
  signal OUT_UNBOUNDED_ADDING_operations_26642_26833 : std_logic;
  signal done_delayed_REG_signal_in : std_logic;
  signal done_delayed_REG_signal_out : std_logic;
  signal fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 : std_logic;
  signal fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 : std_logic;
  signal fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 : std_logic;
  signal fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 : std_logic;
  signal selector_IN_UNBOUNDED_ADDING_operations_26642_26769 : std_logic;
  signal selector_IN_UNBOUNDED_ADDING_operations_26642_26785 : std_logic;
  signal selector_IN_UNBOUNDED_ADDING_operations_26642_26801 : std_logic;
  signal selector_IN_UNBOUNDED_ADDING_operations_26642_26817 : std_logic;
  signal selector_IN_UNBOUNDED_ADDING_operations_26642_26833 : std_logic;
  signal selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 : std_logic;
  signal selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 : std_logic;
  signal wrenable_reg_0 : std_logic;
begin
  Controller_i : controller_ADDING_operations port map (done_port => done_delayed_REG_signal_in, selector_IN_UNBOUNDED_ADDING_operations_26642_26769 => selector_IN_UNBOUNDED_ADDING_operations_26642_26769, selector_IN_UNBOUNDED_ADDING_operations_26642_26785 => selector_IN_UNBOUNDED_ADDING_operations_26642_26785, selector_IN_UNBOUNDED_ADDING_operations_26642_26801 => selector_IN_UNBOUNDED_ADDING_operations_26642_26801, selector_IN_UNBOUNDED_ADDING_operations_26642_26817 => selector_IN_UNBOUNDED_ADDING_operations_26642_26817, selector_IN_UNBOUNDED_ADDING_operations_26642_26833 => selector_IN_UNBOUNDED_ADDING_operations_26642_26833, selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 => selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0, selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 => selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0, wrenable_reg_0 => wrenable_reg_0, fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 => fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0, fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 => fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1, fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 => fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0, fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 => fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1, OUT_MULTIIF_ADDING_operations_26642_26836 => OUT_MULTIIF_ADDING_operations_26642_26836, OUT_UNBOUNDED_ADDING_operations_26642_26769 => OUT_UNBOUNDED_ADDING_operations_26642_26769, OUT_UNBOUNDED_ADDING_operations_26642_26785 => OUT_UNBOUNDED_ADDING_operations_26642_26785, OUT_UNBOUNDED_ADDING_operations_26642_26801 => OUT_UNBOUNDED_ADDING_operations_26642_26801, OUT_UNBOUNDED_ADDING_operations_26642_26817 => OUT_UNBOUNDED_ADDING_operations_26642_26817, OUT_UNBOUNDED_ADDING_operations_26642_26833 => OUT_UNBOUNDED_ADDING_operations_26642_26833, clock => clock, reset => reset, start_port => start_port);
  Datapath_i : datapath_ADDING_operations port map (\_x_notify\ => \_x_notify\, \_x_notify_vld\ => \_x_notify_vld\, \_z_notify\ => \_z_notify\, \_z_notify_vld\ => \_z_notify_vld\, \_z_sig\ => \_z_sig\, \_z_sig_vld\ => \_z_sig_vld\, OUT_MULTIIF_ADDING_operations_26642_26836 => OUT_MULTIIF_ADDING_operations_26642_26836, OUT_UNBOUNDED_ADDING_operations_26642_26769 => OUT_UNBOUNDED_ADDING_operations_26642_26769, OUT_UNBOUNDED_ADDING_operations_26642_26785 => OUT_UNBOUNDED_ADDING_operations_26642_26785, OUT_UNBOUNDED_ADDING_operations_26642_26801 => OUT_UNBOUNDED_ADDING_operations_26642_26801, OUT_UNBOUNDED_ADDING_operations_26642_26817 => OUT_UNBOUNDED_ADDING_operations_26642_26817, OUT_UNBOUNDED_ADDING_operations_26642_26833 => OUT_UNBOUNDED_ADDING_operations_26642_26833, clock => clock, reset => reset, in_port_x_sig => x_sig, in_port_z_sig => z_sig, in_port_x_notify => x_notify, in_port_z_notify => z_notify, in_port_active_operation => active_operation, selector_IN_UNBOUNDED_ADDING_operations_26642_26769 => selector_IN_UNBOUNDED_ADDING_operations_26642_26769, selector_IN_UNBOUNDED_ADDING_operations_26642_26785 => selector_IN_UNBOUNDED_ADDING_operations_26642_26785, selector_IN_UNBOUNDED_ADDING_operations_26642_26801 => selector_IN_UNBOUNDED_ADDING_operations_26642_26801, selector_IN_UNBOUNDED_ADDING_operations_26642_26817 => selector_IN_UNBOUNDED_ADDING_operations_26642_26817, selector_IN_UNBOUNDED_ADDING_operations_26642_26833 => selector_IN_UNBOUNDED_ADDING_operations_26642_26833, selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0 => selector_MUX_15_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_1_0_0, selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0 => selector_MUX_18_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_1_0_0, wrenable_reg_0 => wrenable_reg_0, fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0 => fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid0, fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1 => fuselector_x_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_10_i0_x_notify_bambu_artificial_ParmMgr_Write_valid1, fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0 => fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid0, fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1 => fuselector_z_notify_bambu_artificial_ParmMgr_Write_valid_VECTOR_BOOL32_11_i0_z_notify_bambu_artificial_ParmMgr_Write_valid1);
  done_delayed_REG : flipflop_AR generic map(BITSIZE_in1=>1, BITSIZE_out1=>1) port map (out1 => done_delayed_REG_signal_out, clock => clock, reset => reset, in1 => done_delayed_REG_signal_in);
  -- io-signal post fix
  done_port <= done_delayed_REG_signal_out;

end \_ADDING_operations_arch\;

-- Minimal interface for function: ADDING_operations
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
entity ADDING_operations is 
port (
  -- IN
  clock : in std_logic;
  reset : in std_logic;
  start_port : in std_logic;
  x_sig : in std_logic_vector(31 downto 0) ;
  active_operation : in std_logic_vector(31 downto 0) ;
  -- OUT
  done_port : out std_logic;
  x_notify : out std_logic_vector(0 downto 0);
  x_notify_vld : out std_logic;
  z_notify : out std_logic_vector(0 downto 0);
  z_notify_vld : out std_logic;
  z_sig : out std_logic_vector(31 downto 0) ;
  z_sig_vld : out std_logic

);
end ADDING_operations;

architecture ADDING_operations_arch of ADDING_operations is
  -- Component and signal declarations
  
  component \_ADDING_operations\
  port (
    -- IN
    clock : in std_logic;
    reset : in std_logic;
    start_port : in std_logic;
    x_sig : in signed (31 downto 0);
    z_sig : in std_logic_vector(31 downto 0) ;
    x_notify : in std_logic_vector(31 downto 0) ;
    z_notify : in std_logic_vector(31 downto 0) ;
    active_operation : in unsigned (31 downto 0);
    -- OUT
    done_port : out std_logic;
    \_x_notify\ : out std_logic_vector(0 downto 0);
    \_x_notify_vld\ : out std_logic;
    \_z_notify\ : out std_logic_vector(0 downto 0);
    \_z_notify_vld\ : out std_logic;
    \_z_sig\ : out std_logic_vector(31 downto 0) ;
    \_z_sig_vld\ : out std_logic
  
  );
  end component;
begin
  \_ADDING_operations_i0\ : \_ADDING_operations\ port map (done_port => done_port, \_x_notify\ => x_notify, \_x_notify_vld\ => x_notify_vld, \_z_notify\ => z_notify, \_z_notify_vld\ => z_notify_vld, \_z_sig\ => z_sig, \_z_sig_vld\ => z_sig_vld, clock => clock, reset => reset, start_port => start_port, x_sig => signed(x_sig), z_sig => "00000000000000000000000000000000", x_notify => "00000000000000000000000000000000", z_notify => "00000000000000000000000000000000", active_operation => unsigned(active_operation));

end ADDING_operations_arch;


