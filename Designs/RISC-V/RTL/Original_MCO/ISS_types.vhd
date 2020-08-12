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
	type ME_MaskType is (MT_B, MT_BU, MT_H, MT_HU, MT_W, MT_X);
	type ME_AccessType is (ME_RD, ME_WR, ME_X);
	type EncType is (ENC_B, ENC_ERR, ENC_I_I, ENC_I_J, ENC_I_L, ENC_J, ENC_R, ENC_S, ENC_U);
	type InstrType is (INSTR_ADD, INSTR_ADDI, INSTR_AND, INSTR_ANDI, INSTR_AUIPC, INSTR_BEQ, INSTR_BGE, INSTR_BGEU, INSTR_BLT, INSTR_BLTU, INSTR_BNE, INSTR_JAL, INSTR_JALR, INSTR_LB, INSTR_LBU, INSTR_LH, INSTR_LHU, INSTR_LUI, INSTR_LW, INSTR_OR, INSTR_ORI, INSTR_SB, INSTR_SH, INSTR_SLL, INSTR_SLLI, INSTR_SLT, INSTR_SLTI, INSTR_SLTU, INSTR_SLTUI, INSTR_SRA, INSTR_SRAI, INSTR_SRL, INSTR_SRLI, INSTR_SUB, INSTR_SW, INSTR_UNKNOWN, INSTR_XOR, INSTR_XORI);
	type ALUfuncType is (ALU_ADD, ALU_AND, ALU_COPY1, ALU_OR, ALU_SLL, ALU_SLT, ALU_SLTU, ALU_SRA, ALU_SRL, ALU_SUB, ALU_X, ALU_XOR);

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

	-- Array Types

	-- Constants

end package ISS_types;