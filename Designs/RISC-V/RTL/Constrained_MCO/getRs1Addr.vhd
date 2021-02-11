-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2020.1
-- Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity getRs1Addr is
port (
    ap_ready : OUT STD_LOGIC;
    encodedInstr_V : IN STD_LOGIC_VECTOR (31 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (4 downto 0) );
end;


architecture behav of getRs1Addr is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001111";
    constant ap_const_lv32_13 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010011";
    constant ap_const_lv7_67 : STD_LOGIC_VECTOR (6 downto 0) := "1100111";
    constant ap_const_lv7_63 : STD_LOGIC_VECTOR (6 downto 0) := "1100011";
    constant ap_const_lv7_33 : STD_LOGIC_VECTOR (6 downto 0) := "0110011";
    constant ap_const_lv7_23 : STD_LOGIC_VECTOR (6 downto 0) := "0100011";
    constant ap_const_lv7_13 : STD_LOGIC_VECTOR (6 downto 0) := "0010011";
    constant ap_const_lv7_3 : STD_LOGIC_VECTOR (6 downto 0) := "0000011";
    constant ap_const_lv5_0 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal trunc_ln879_fu_30_p1 : STD_LOGIC_VECTOR (6 downto 0);
    signal icmp_ln276_1_fu_50_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln276_2_fu_56_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln276_fu_80_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln276_fu_44_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln276_4_fu_68_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln276_5_fu_74_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln276_2_fu_92_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln276_3_fu_62_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln276_3_fu_98_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln276_1_fu_86_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln276_4_fu_104_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln2_fu_34_p4 : STD_LOGIC_VECTOR (4 downto 0);


begin



    ap_ready <= ap_const_logic_1;
    ap_return <= 
        trunc_ln2_fu_34_p4 when (or_ln276_4_fu_104_p2(0) = '1') else 
        ap_const_lv5_0;
    icmp_ln276_1_fu_50_p2 <= "1" when (trunc_ln879_fu_30_p1 = ap_const_lv7_63) else "0";
    icmp_ln276_2_fu_56_p2 <= "1" when (trunc_ln879_fu_30_p1 = ap_const_lv7_33) else "0";
    icmp_ln276_3_fu_62_p2 <= "1" when (trunc_ln879_fu_30_p1 = ap_const_lv7_23) else "0";
    icmp_ln276_4_fu_68_p2 <= "1" when (trunc_ln879_fu_30_p1 = ap_const_lv7_13) else "0";
    icmp_ln276_5_fu_74_p2 <= "1" when (trunc_ln879_fu_30_p1 = ap_const_lv7_3) else "0";
    icmp_ln276_fu_44_p2 <= "1" when (trunc_ln879_fu_30_p1 = ap_const_lv7_67) else "0";
    or_ln276_1_fu_86_p2 <= (or_ln276_fu_80_p2 or icmp_ln276_fu_44_p2);
    or_ln276_2_fu_92_p2 <= (icmp_ln276_5_fu_74_p2 or icmp_ln276_4_fu_68_p2);
    or_ln276_3_fu_98_p2 <= (or_ln276_2_fu_92_p2 or icmp_ln276_3_fu_62_p2);
    or_ln276_4_fu_104_p2 <= (or_ln276_3_fu_98_p2 or or_ln276_1_fu_86_p2);
    or_ln276_fu_80_p2 <= (icmp_ln276_2_fu_56_p2 or icmp_ln276_1_fu_50_p2);
    trunc_ln2_fu_34_p4 <= encodedInstr_V(19 downto 15);
    trunc_ln879_fu_30_p1 <= encodedInstr_V(7 - 1 downto 0);
end behav;