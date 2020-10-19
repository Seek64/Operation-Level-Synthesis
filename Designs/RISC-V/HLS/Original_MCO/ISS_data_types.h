#ifndef DATA_TYPES_H
#define DATA_TYPES_H

#include "ap_int.h"

// States
enum state {state_1, state_2, state_3, state_4, state_5, state_6};

// Operations
enum operation {state_1_1, state_2_10, state_2_2, state_2_3, state_2_4, state_2_5, state_2_6, state_2_7, state_2_8, state_2_9, state_3_11, state_4_12, state_5_13, state_6_14};

// Enum Types
enum ME_MaskType {MT_B, MT_BU, MT_H, MT_HU, MT_W, MT_X};

enum ME_AccessType {ME_RD, ME_WR, ME_X};

enum EncType {ENC_B, ENC_ERR, ENC_I_I, ENC_I_J, ENC_I_L, ENC_J, ENC_R, ENC_S, ENC_U};

enum InstrType {INSTR_ADD, INSTR_ADDI, INSTR_AND, INSTR_ANDI, INSTR_AUIPC, INSTR_BEQ, INSTR_BGE, INSTR_BGEU, INSTR_BLT, INSTR_BLTU, INSTR_BNE, INSTR_JAL, INSTR_JALR, INSTR_LB, INSTR_LBU, INSTR_LH, INSTR_LHU, INSTR_LUI, INSTR_LW, INSTR_OR, INSTR_ORI, INSTR_SB, INSTR_SH, INSTR_SLL, INSTR_SLLI, INSTR_SLT, INSTR_SLTI, INSTR_SLTU, INSTR_SLTUI, INSTR_SRA, INSTR_SRAI, INSTR_SRL, INSTR_SRLI, INSTR_SUB, INSTR_SW, INSTR_UNKNOWN, INSTR_XOR, INSTR_XORI};

enum ALUfuncType {ALU_ADD, ALU_AND, ALU_COPY1, ALU_OR, ALU_SLL, ALU_SLT, ALU_SLTU, ALU_SRA, ALU_SRL, ALU_SUB, ALU_X, ALU_XOR};

// Compound Types
struct MEtoCU_IF {
	ap_uint<32> loadedData;
};

struct CUtoME_IF {
	ap_uint<32> addrIn;
	ap_uint<32> dataIn;
	ME_MaskType mask;
	ME_AccessType req;
};

struct RegfileWriteType {
	ap_uint<32> dst;
	ap_uint<32> dstData;
};

struct RegfileType {
	ap_uint<32> reg_file_01;
	ap_uint<32> reg_file_02;
	ap_uint<32> reg_file_03;
	ap_uint<32> reg_file_04;
	ap_uint<32> reg_file_05;
	ap_uint<32> reg_file_06;
	ap_uint<32> reg_file_07;
	ap_uint<32> reg_file_08;
	ap_uint<32> reg_file_09;
	ap_uint<32> reg_file_10;
	ap_uint<32> reg_file_11;
	ap_uint<32> reg_file_12;
	ap_uint<32> reg_file_13;
	ap_uint<32> reg_file_14;
	ap_uint<32> reg_file_15;
	ap_uint<32> reg_file_16;
	ap_uint<32> reg_file_17;
	ap_uint<32> reg_file_18;
	ap_uint<32> reg_file_19;
	ap_uint<32> reg_file_20;
	ap_uint<32> reg_file_21;
	ap_uint<32> reg_file_22;
	ap_uint<32> reg_file_23;
	ap_uint<32> reg_file_24;
	ap_uint<32> reg_file_25;
	ap_uint<32> reg_file_26;
	ap_uint<32> reg_file_27;
	ap_uint<32> reg_file_28;
	ap_uint<32> reg_file_29;
	ap_uint<32> reg_file_30;
	ap_uint<32> reg_file_31;
};


#endif //DATA_TYPES_H