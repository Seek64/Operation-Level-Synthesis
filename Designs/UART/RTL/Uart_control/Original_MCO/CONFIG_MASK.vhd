-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2020.1
-- Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CONFIG_MASK is
port (
    ap_ready : OUT STD_LOGIC;
    frame_config_V : IN STD_LOGIC_VECTOR (31 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (8 downto 0) );
end;


architecture behav of CONFIG_MASK is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal tmp_fu_18_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln214_fu_26_p1 : STD_LOGIC_VECTOR (4 downto 0);


begin



    ap_ready <= ap_const_logic_1;
    ap_return <= ((tmp_fu_18_p3 & ap_const_lv3_0) & trunc_ln214_fu_26_p1);
    tmp_fu_18_p3 <= frame_config_V(8 downto 8);
    trunc_ln214_fu_26_p1 <= frame_config_V(5 - 1 downto 0);
end behav;
