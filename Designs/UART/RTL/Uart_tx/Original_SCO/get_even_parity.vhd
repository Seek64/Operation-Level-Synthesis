-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2018.2
-- Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity get_even_parity is
port (
    ap_ready : OUT STD_LOGIC;
    data_V : IN STD_LOGIC_VECTOR (31 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of get_even_parity is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv32_6 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000110";
    constant ap_const_lv32_7 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000111";
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal tmp_2_fu_30_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_1_fu_26_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_3_fu_38_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_4_fu_46_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp2_fu_92_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp1_fu_86_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_5_fu_54_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_6_fu_62_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_7_fu_70_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_8_fu_78_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp5_fu_110_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp4_fu_104_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp3_fu_116_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_fu_98_p2 : STD_LOGIC_VECTOR (0 downto 0);


begin



    ap_ready <= ap_const_logic_1;
    ap_return <= (tmp_fu_98_p2 xor tmp3_fu_116_p2);
    tmp1_fu_86_p2 <= (tmp_2_fu_30_p3 xor tmp_1_fu_26_p1);
    tmp2_fu_92_p2 <= (tmp_4_fu_46_p3 xor tmp_3_fu_38_p3);
    tmp3_fu_116_p2 <= (tmp5_fu_110_p2 xor tmp4_fu_104_p2);
    tmp4_fu_104_p2 <= (tmp_6_fu_62_p3 xor tmp_5_fu_54_p3);
    tmp5_fu_110_p2 <= (tmp_8_fu_78_p3 xor tmp_7_fu_70_p3);
    tmp_1_fu_26_p1 <= data_V(1 - 1 downto 0);
    tmp_2_fu_30_p3 <= data_V(1 downto 1);
    tmp_3_fu_38_p3 <= data_V(2 downto 2);
    tmp_4_fu_46_p3 <= data_V(3 downto 3);
    tmp_5_fu_54_p3 <= data_V(4 downto 4);
    tmp_6_fu_62_p3 <= data_V(5 downto 5);
    tmp_7_fu_70_p3 <= data_V(6 downto 6);
    tmp_8_fu_78_p3 <= data_V(7 downto 7);
    tmp_fu_98_p2 <= (tmp2_fu_92_p2 xor tmp1_fu_86_p2);
end behav;
