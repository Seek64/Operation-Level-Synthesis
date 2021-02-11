-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2020.1
-- Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity getMemoryMask is
port (
    ap_ready : OUT STD_LOGIC;
    instr : IN STD_LOGIC_VECTOR (5 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (2 downto 0) );
end;


architecture behav of getMemoryMask is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv6_E : STD_LOGIC_VECTOR (5 downto 0) := "001110";
    constant ap_const_lv6_10 : STD_LOGIC_VECTOR (5 downto 0) := "010000";
    constant ap_const_lv3_3 : STD_LOGIC_VECTOR (2 downto 0) := "011";
    constant ap_const_lv3_5 : STD_LOGIC_VECTOR (2 downto 0) := "101";
    constant ap_const_lv6_15 : STD_LOGIC_VECTOR (5 downto 0) := "010101";
    constant ap_const_lv6_D : STD_LOGIC_VECTOR (5 downto 0) := "001101";
    constant ap_const_lv6_16 : STD_LOGIC_VECTOR (5 downto 0) := "010110";
    constant ap_const_lv6_F : STD_LOGIC_VECTOR (5 downto 0) := "001111";
    constant ap_const_lv6_22 : STD_LOGIC_VECTOR (5 downto 0) := "100010";
    constant ap_const_lv6_12 : STD_LOGIC_VECTOR (5 downto 0) := "010010";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv3_4 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv3_2 : STD_LOGIC_VECTOR (2 downto 0) := "010";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv3_1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal icmp_ln260_fu_46_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln252_fu_60_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln252_1_fu_66_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln254_fu_78_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln254_1_fu_84_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln254_fu_90_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln252_fu_72_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln256_fu_102_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln256_1_fu_108_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln256_fu_114_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln254_1_fu_96_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln258_fu_40_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln256_1_fu_120_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln258_fu_126_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln258_fu_132_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln260_fu_52_p3 : STD_LOGIC_VECTOR (2 downto 0);
    signal icmp_ln252_2_fu_146_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln252_3_fu_152_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln254_2_fu_164_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln254_3_fu_170_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln254_fu_176_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal sel_tmp36_fu_182_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln252_fu_158_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal empty_fu_196_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal sel_tmp27_cast_fu_188_p3 : STD_LOGIC_VECTOR (2 downto 0);
    signal select_ln258_fu_138_p3 : STD_LOGIC_VECTOR (2 downto 0);
    signal icmp_ln256_2_fu_210_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln256_3_fu_216_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln256_fu_222_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln258_1_fu_234_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal sel_tmp62_fu_228_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln258_fu_248_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln258_1_fu_240_p3 : STD_LOGIC_VECTOR (2 downto 0);
    signal sel_tmp47_fu_202_p3 : STD_LOGIC_VECTOR (2 downto 0);


begin



    and_ln252_fu_72_p2 <= (icmp_ln252_fu_60_p2 and icmp_ln252_1_fu_66_p2);
    and_ln254_1_fu_96_p2 <= (and_ln254_fu_90_p2 and and_ln252_fu_72_p2);
    and_ln254_fu_90_p2 <= (icmp_ln254_fu_78_p2 and icmp_ln254_1_fu_84_p2);
    and_ln256_1_fu_120_p2 <= (and_ln256_fu_114_p2 and and_ln254_1_fu_96_p2);
    and_ln256_fu_114_p2 <= (icmp_ln256_fu_102_p2 and icmp_ln256_1_fu_108_p2);
    and_ln258_1_fu_234_p2 <= (icmp_ln258_fu_40_p2 and and_ln256_1_fu_120_p2);
    and_ln258_fu_132_p2 <= (xor_ln258_fu_126_p2 and and_ln256_1_fu_120_p2);
    ap_ready <= ap_const_logic_1;
    ap_return <= 
        select_ln258_1_fu_240_p3 when (or_ln258_fu_248_p2(0) = '1') else 
        sel_tmp47_fu_202_p3;
    empty_fu_196_p2 <= (sel_tmp36_fu_182_p2 or or_ln252_fu_158_p2);
    icmp_ln252_1_fu_66_p2 <= "0" when (instr = ap_const_lv6_D) else "1";
    icmp_ln252_2_fu_146_p2 <= "1" when (instr = ap_const_lv6_15) else "0";
    icmp_ln252_3_fu_152_p2 <= "1" when (instr = ap_const_lv6_D) else "0";
    icmp_ln252_fu_60_p2 <= "0" when (instr = ap_const_lv6_15) else "1";
    icmp_ln254_1_fu_84_p2 <= "0" when (instr = ap_const_lv6_F) else "1";
    icmp_ln254_2_fu_164_p2 <= "1" when (instr = ap_const_lv6_16) else "0";
    icmp_ln254_3_fu_170_p2 <= "1" when (instr = ap_const_lv6_F) else "0";
    icmp_ln254_fu_78_p2 <= "0" when (instr = ap_const_lv6_16) else "1";
    icmp_ln256_1_fu_108_p2 <= "0" when (instr = ap_const_lv6_12) else "1";
    icmp_ln256_2_fu_210_p2 <= "1" when (instr = ap_const_lv6_22) else "0";
    icmp_ln256_3_fu_216_p2 <= "1" when (instr = ap_const_lv6_12) else "0";
    icmp_ln256_fu_102_p2 <= "0" when (instr = ap_const_lv6_22) else "1";
    icmp_ln258_fu_40_p2 <= "1" when (instr = ap_const_lv6_E) else "0";
    icmp_ln260_fu_46_p2 <= "1" when (instr = ap_const_lv6_10) else "0";
    or_ln252_fu_158_p2 <= (icmp_ln252_3_fu_152_p2 or icmp_ln252_2_fu_146_p2);
    or_ln254_fu_176_p2 <= (icmp_ln254_3_fu_170_p2 or icmp_ln254_2_fu_164_p2);
    or_ln256_fu_222_p2 <= (icmp_ln256_3_fu_216_p2 or icmp_ln256_2_fu_210_p2);
    or_ln258_fu_248_p2 <= (sel_tmp62_fu_228_p2 or and_ln258_1_fu_234_p2);
    sel_tmp27_cast_fu_188_p3 <= 
        ap_const_lv3_2 when (sel_tmp36_fu_182_p2(0) = '1') else 
        ap_const_lv3_0;
    sel_tmp36_fu_182_p2 <= (or_ln254_fu_176_p2 and and_ln252_fu_72_p2);
    sel_tmp47_fu_202_p3 <= 
        sel_tmp27_cast_fu_188_p3 when (empty_fu_196_p2(0) = '1') else 
        select_ln258_fu_138_p3;
    sel_tmp62_fu_228_p2 <= (or_ln256_fu_222_p2 and and_ln254_1_fu_96_p2);
    select_ln258_1_fu_240_p3 <= 
        ap_const_lv3_1 when (and_ln258_1_fu_234_p2(0) = '1') else 
        ap_const_lv3_4;
    select_ln258_fu_138_p3 <= 
        select_ln260_fu_52_p3 when (and_ln258_fu_132_p2(0) = '1') else 
        ap_const_lv3_4;
    select_ln260_fu_52_p3 <= 
        ap_const_lv3_3 when (icmp_ln260_fu_46_p2(0) = '1') else 
        ap_const_lv3_5;
    xor_ln258_fu_126_p2 <= (icmp_ln258_fu_40_p2 xor ap_const_lv1_1);
end behav;