-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2020.1
-- Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity getRdAddr is
port (
    ap_ready : OUT STD_LOGIC;
    encodedInstr_V : IN STD_LOGIC_VECTOR (31 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (4 downto 0) );
end;


architecture behav of getRdAddr is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_7 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000111";
    constant ap_const_lv32_B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001011";
    constant ap_const_lv7_6F : STD_LOGIC_VECTOR (6 downto 0) := "1101111";
    constant ap_const_lv7_67 : STD_LOGIC_VECTOR (6 downto 0) := "1100111";
    constant ap_const_lv7_37 : STD_LOGIC_VECTOR (6 downto 0) := "0110111";
    constant ap_const_lv7_33 : STD_LOGIC_VECTOR (6 downto 0) := "0110011";
    constant ap_const_lv7_17 : STD_LOGIC_VECTOR (6 downto 0) := "0010111";
    constant ap_const_lv7_13 : STD_LOGIC_VECTOR (6 downto 0) := "0010011";
    constant ap_const_lv7_3 : STD_LOGIC_VECTOR (6 downto 0) := "0000011";
    constant ap_const_lv5_0 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal trunc_ln879_fu_32_p1 : STD_LOGIC_VECTOR (6 downto 0);
    signal icmp_ln268_1_fu_52_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln268_2_fu_58_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln268_fu_88_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln268_fu_46_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln268_3_fu_64_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln268_4_fu_70_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln268_5_fu_76_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln268_6_fu_82_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln268_3_fu_106_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln268_2_fu_100_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln268_4_fu_112_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln268_1_fu_94_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln268_5_fu_118_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln3_fu_36_p4 : STD_LOGIC_VECTOR (4 downto 0);


begin



    ap_ready <= ap_const_logic_1;
    ap_return <= 
        trunc_ln3_fu_36_p4 when (or_ln268_5_fu_118_p2(0) = '1') else 
        ap_const_lv5_0;
    icmp_ln268_1_fu_52_p2 <= "1" when (trunc_ln879_fu_32_p1 = ap_const_lv7_67) else "0";
    icmp_ln268_2_fu_58_p2 <= "1" when (trunc_ln879_fu_32_p1 = ap_const_lv7_37) else "0";
    icmp_ln268_3_fu_64_p2 <= "1" when (trunc_ln879_fu_32_p1 = ap_const_lv7_33) else "0";
    icmp_ln268_4_fu_70_p2 <= "1" when (trunc_ln879_fu_32_p1 = ap_const_lv7_17) else "0";
    icmp_ln268_5_fu_76_p2 <= "1" when (trunc_ln879_fu_32_p1 = ap_const_lv7_13) else "0";
    icmp_ln268_6_fu_82_p2 <= "1" when (trunc_ln879_fu_32_p1 = ap_const_lv7_3) else "0";
    icmp_ln268_fu_46_p2 <= "1" when (trunc_ln879_fu_32_p1 = ap_const_lv7_6F) else "0";
    or_ln268_1_fu_94_p2 <= (or_ln268_fu_88_p2 or icmp_ln268_fu_46_p2);
    or_ln268_2_fu_100_p2 <= (icmp_ln268_4_fu_70_p2 or icmp_ln268_3_fu_64_p2);
    or_ln268_3_fu_106_p2 <= (icmp_ln268_6_fu_82_p2 or icmp_ln268_5_fu_76_p2);
    or_ln268_4_fu_112_p2 <= (or_ln268_3_fu_106_p2 or or_ln268_2_fu_100_p2);
    or_ln268_5_fu_118_p2 <= (or_ln268_4_fu_112_p2 or or_ln268_1_fu_94_p2);
    or_ln268_fu_88_p2 <= (icmp_ln268_2_fu_58_p2 or icmp_ln268_1_fu_52_p2);
    trunc_ln3_fu_36_p4 <= encodedInstr_V(11 downto 7);
    trunc_ln879_fu_32_p1 <= encodedInstr_V(7 - 1 downto 0);
end behav;