-- External data type definition package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ISS_types is

	 -- States
	type ISS_state_t is (st_state_1, st_state_2, st_state_3, st_state_4, st_state_5, st_state_6);

	-- Operations
	subtype ISS_operation_t is std_logic_vector(3 downto 0);
	constant op_state_1_1 : ISS_operation_t := "0000";
	constant op_state_2_10 : ISS_operation_t := "0001";
	constant op_state_2_2 : ISS_operation_t := "0010";
	constant op_state_2_3 : ISS_operation_t := "0011";
	constant op_state_2_4 : ISS_operation_t := "0100";
	constant op_state_2_5 : ISS_operation_t := "0101";
	constant op_state_2_6 : ISS_operation_t := "0110";
	constant op_state_2_7 : ISS_operation_t := "0111";
	constant op_state_2_8 : ISS_operation_t := "1000";
	constant op_state_2_9 : ISS_operation_t := "1001";
	constant op_state_3_11 : ISS_operation_t := "1010";
	constant op_state_4_12 : ISS_operation_t := "1011";
	constant op_state_5_13 : ISS_operation_t := "1100";
	constant op_state_6_14 : ISS_operation_t := "1101";
	constant op_state_wait : ISS_operation_t := "1110";

	-- Enum Types
	subtype ME_MaskType is std_logic_vector(2 downto 0);
	constant MT_B : ME_MaskType := "000";
	constant MT_BU : ME_MaskType := "001";
	constant MT_H : ME_MaskType := "010";
	constant MT_HU : ME_MaskType := "011";
	constant MT_W : ME_MaskType := "100";
	constant MT_X : ME_MaskType := "101";

	subtype ME_AccessType is std_logic_vector(1 downto 0);
	constant ME_RD : ME_AccessType := "00";
	constant ME_WR : ME_AccessType := "01";
	constant ME_X : ME_AccessType := "10";

	subtype EncType is std_logic_vector(3 downto 0);
	constant ENC_B : EncType := "0000";
	constant ENC_ERR : EncType := "0001";
	constant ENC_I_I : EncType := "0010";
	constant ENC_I_J : EncType := "0011";
	constant ENC_I_L : EncType := "0100";
	constant ENC_J : EncType := "0101";
	constant ENC_R : EncType := "0110";
	constant ENC_S : EncType := "0111";
	constant ENC_U : EncType := "1000";

	subtype InstrType is std_logic_vector(5 downto 0);
	constant INSTR_ADD : InstrType := "000000";
	constant INSTR_ADDI : InstrType := "000001";
	constant INSTR_AND : InstrType := "000010";
	constant INSTR_ANDI : InstrType := "000011";
	constant INSTR_AUIPC : InstrType := "000100";
	constant INSTR_BEQ : InstrType := "000101";
	constant INSTR_BGE : InstrType := "000110";
	constant INSTR_BGEU : InstrType := "000111";
	constant INSTR_BLT : InstrType := "001000";
	constant INSTR_BLTU : InstrType := "001001";
	constant INSTR_BNE : InstrType := "001010";
	constant INSTR_JAL : InstrType := "001011";
	constant INSTR_JALR : InstrType := "001100";
	constant INSTR_LB : InstrType := "001101";
	constant INSTR_LBU : InstrType := "001110";
	constant INSTR_LH : InstrType := "001111";
	constant INSTR_LHU : InstrType := "010000";
	constant INSTR_LUI : InstrType := "010001";
	constant INSTR_LW : InstrType := "010010";
	constant INSTR_OR : InstrType := "010011";
	constant INSTR_ORI : InstrType := "010100";
	constant INSTR_SB : InstrType := "010101";
	constant INSTR_SH : InstrType := "010110";
	constant INSTR_SLL : InstrType := "010111";
	constant INSTR_SLLI : InstrType := "011000";
	constant INSTR_SLT : InstrType := "011001";
	constant INSTR_SLTI : InstrType := "011010";
	constant INSTR_SLTU : InstrType := "011011";
	constant INSTR_SLTUI : InstrType := "011100";
	constant INSTR_SRA : InstrType := "011101";
	constant INSTR_SRAI : InstrType := "011110";
	constant INSTR_SRL : InstrType := "011111";
	constant INSTR_SRLI : InstrType := "100000";
	constant INSTR_SUB : InstrType := "100001";
	constant INSTR_SW : InstrType := "100010";
	constant INSTR_UNKNOWN : InstrType := "100011";
	constant INSTR_XOR : InstrType := "100100";
	constant INSTR_XORI : InstrType := "100101";

	subtype ALUfuncType is std_logic_vector(3 downto 0);
	constant ALU_ADD : ALUfuncType := "0000";
	constant ALU_AND : ALUfuncType := "0001";
	constant ALU_COPY1 : ALUfuncType := "0010";
	constant ALU_OR : ALUfuncType := "0011";
	constant ALU_SLL : ALUfuncType := "0100";
	constant ALU_SLT : ALUfuncType := "0101";
	constant ALU_SLTU : ALUfuncType := "0110";
	constant ALU_SRA : ALUfuncType := "0111";
	constant ALU_SRL : ALUfuncType := "1000";
	constant ALU_SUB : ALUfuncType := "1001";
	constant ALU_X : ALUfuncType := "1010";
	constant ALU_XOR : ALUfuncType := "1011";


	-- Compound Types
	type MEtoCU_IF is record
		loadedData: std_logic_vector(31 downto 0);
	end record;

	type CUtoME_IF is record
		addrIn: std_logic_vector(31 downto 0);
		dataIn: std_logic_vector(31 downto 0);
		mask: ME_MaskType;
		req: ME_AccessType;
	end record;

	type RegfileWriteType is record
		dst: std_logic_vector(31 downto 0);
		dstData: std_logic_vector(31 downto 0);
	end record;

	type RegfileType is record
		reg_file_01: std_logic_vector(31 downto 0);
		reg_file_02: std_logic_vector(31 downto 0);
		reg_file_03: std_logic_vector(31 downto 0);
		reg_file_04: std_logic_vector(31 downto 0);
		reg_file_05: std_logic_vector(31 downto 0);
		reg_file_06: std_logic_vector(31 downto 0);
		reg_file_07: std_logic_vector(31 downto 0);
		reg_file_08: std_logic_vector(31 downto 0);
		reg_file_09: std_logic_vector(31 downto 0);
		reg_file_10: std_logic_vector(31 downto 0);
		reg_file_11: std_logic_vector(31 downto 0);
		reg_file_12: std_logic_vector(31 downto 0);
		reg_file_13: std_logic_vector(31 downto 0);
		reg_file_14: std_logic_vector(31 downto 0);
		reg_file_15: std_logic_vector(31 downto 0);
		reg_file_16: std_logic_vector(31 downto 0);
		reg_file_17: std_logic_vector(31 downto 0);
		reg_file_18: std_logic_vector(31 downto 0);
		reg_file_19: std_logic_vector(31 downto 0);
		reg_file_20: std_logic_vector(31 downto 0);
		reg_file_21: std_logic_vector(31 downto 0);
		reg_file_22: std_logic_vector(31 downto 0);
		reg_file_23: std_logic_vector(31 downto 0);
		reg_file_24: std_logic_vector(31 downto 0);
		reg_file_25: std_logic_vector(31 downto 0);
		reg_file_26: std_logic_vector(31 downto 0);
		reg_file_27: std_logic_vector(31 downto 0);
		reg_file_28: std_logic_vector(31 downto 0);
		reg_file_29: std_logic_vector(31 downto 0);
		reg_file_30: std_logic_vector(31 downto 0);
		reg_file_31: std_logic_vector(31 downto 0);
	end record;


end package ISS_types;