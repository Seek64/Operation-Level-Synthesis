#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include "ap_int.h"
#include "ISS_data_Types.h"

ap_uint<32> branchPCcalculation(ap_uint<32> aluResult, ap_uint<32> encodedInstr, ap_uint<32> pcReg);
ALUfuncType getALUfunc(InstrType instr);
ap_uint<32> getALUresult(ALUfuncType aluFunction, ap_uint<32> operand1, ap_uint<32> operand2);
EncType getEncType(ap_uint<32> encodedInstr);
ap_uint<32> getEncUALUresult(ap_uint<32> encodedInstr, ap_uint<32> pcReg);
ap_uint<32> getImmediate(ap_uint<32> encodedInstr);
InstrType getInstrType(ap_uint<32> encodedInstr);
ME_MaskType getMemoryMask(InstrType instr);
ap_uint<32> getRdAddr(ap_uint<32> encodedInstr);
ap_uint<32> getRs1Addr(ap_uint<32> encodedInstr);
ap_uint<32> getRs2Addr(ap_uint<32> encodedInstr);
ap_uint<32> readRegfile(ap_uint<32> regfile_reg_file_01, ap_uint<32> regfile_reg_file_02, ap_uint<32> regfile_reg_file_03, ap_uint<32> regfile_reg_file_04, ap_uint<32> regfile_reg_file_05, ap_uint<32> regfile_reg_file_06, ap_uint<32> regfile_reg_file_07, ap_uint<32> regfile_reg_file_08, ap_uint<32> regfile_reg_file_09, ap_uint<32> regfile_reg_file_10, ap_uint<32> regfile_reg_file_11, ap_uint<32> regfile_reg_file_12, ap_uint<32> regfile_reg_file_13, ap_uint<32> regfile_reg_file_14, ap_uint<32> regfile_reg_file_15, ap_uint<32> regfile_reg_file_16, ap_uint<32> regfile_reg_file_17, ap_uint<32> regfile_reg_file_18, ap_uint<32> regfile_reg_file_19, ap_uint<32> regfile_reg_file_20, ap_uint<32> regfile_reg_file_21, ap_uint<32> regfile_reg_file_22, ap_uint<32> regfile_reg_file_23, ap_uint<32> regfile_reg_file_24, ap_uint<32> regfile_reg_file_25, ap_uint<32> regfile_reg_file_26, ap_uint<32> regfile_reg_file_27, ap_uint<32> regfile_reg_file_28, ap_uint<32> regfile_reg_file_29, ap_uint<32> regfile_reg_file_30, ap_uint<32> regfile_reg_file_31, ap_uint<32> src);


ap_uint<32> branchPCcalculation(ap_uint<32> aluResult, ap_uint<32> encodedInstr, ap_uint<32> pcReg) {
	if (((getInstrType(encodedInstr) == INSTR_BEQ) && (aluResult == 0))) {
		return((pcReg + getImmediate(encodedInstr)));
	} else if(((getInstrType(encodedInstr) == INSTR_BNE) && (aluResult != 0))) {
		return((pcReg + getImmediate(encodedInstr)));
	} else if(((getInstrType(encodedInstr) == INSTR_BLT) && (aluResult == 1))) {
		return((pcReg + getImmediate(encodedInstr)));
	} else if(((getInstrType(encodedInstr) == INSTR_BGE) && (aluResult == 0))) {
		return((pcReg + getImmediate(encodedInstr)));
	} else if(((getInstrType(encodedInstr) == INSTR_BLTU) && (aluResult == 1))) {
		return((pcReg + getImmediate(encodedInstr)));
	} else if(((getInstrType(encodedInstr) == INSTR_BGEU) && (aluResult == 0))) {
		return((pcReg + getImmediate(encodedInstr)));
	} else {
		return((pcReg + 4));
	} 
}

ALUfuncType getALUfunc(InstrType instr) {
	if (((instr == INSTR_ADD) || (instr == INSTR_ADDI) || (instr == INSTR_LB) || (instr == INSTR_LH) || (instr == INSTR_LW) || (instr == INSTR_LBU) || (instr == INSTR_LHU) || (instr == INSTR_SB) || (instr == INSTR_SH) || (instr == INSTR_SW) || (instr == INSTR_AUIPC))) {
		return(ALU_ADD);
	} else if(((instr == INSTR_SUB) || (instr == INSTR_BEQ) || (instr == INSTR_BNE))) {
		return(ALU_SUB);
	} else if(((instr == INSTR_SLL) || (instr == INSTR_SLLI))) {
		return(ALU_SLL);
	} else if(((instr == INSTR_SLT) || (instr == INSTR_SLTI) || (instr == INSTR_BLT) || (instr == INSTR_BGE))) {
		return(ALU_SLT);
	} else if(((instr == INSTR_SLTU) || (instr == INSTR_SLTUI) || (instr == INSTR_BLTU) || (instr == INSTR_BGEU))) {
		return(ALU_SLTU);
	} else if(((instr == INSTR_XOR) || (instr == INSTR_XORI))) {
		return(ALU_XOR);
	} else if(((instr == INSTR_SRL) || (instr == INSTR_SRLI))) {
		return(ALU_SRL);
	} else if(((instr == INSTR_SRA) || (instr == INSTR_SRAI))) {
		return(ALU_SRA);
	} else if(((instr == INSTR_OR) || (instr == INSTR_ORI))) {
		return(ALU_OR);
	} else if(((instr == INSTR_AND) || (instr == INSTR_ANDI))) {
		return(ALU_AND);
	} else if(((instr == INSTR_JALR) || (instr == INSTR_JAL))) {
		return(ALU_X);
	} else if(((instr == INSTR_LUI))) {
		return(ALU_COPY1);
	} else {
		return(ALU_X);
	} 
}

ap_uint<32> getALUresult(ALUfuncType aluFunction, ap_uint<32> operand1, ap_uint<32> operand2) {
	if (((aluFunction == ALU_ADD))) {
		return((operand1 + operand2));
	} else if(((aluFunction == ALU_SUB))) {
		return((operand1 + (operand2 * 4294967295)));
	} else if(((aluFunction == ALU_AND))) {
		return((operand1 & operand2));
	} else if(((aluFunction == ALU_OR))) {
		return((operand1 | operand2));
	} else if(((aluFunction == ALU_XOR))) {
		return((operand1 ^ operand2));
	} else if(((aluFunction == ALU_SLT)) && ((ap_int<32>(operand1) < ap_int<32>(operand2)))) {
		return(1);
	} else if(((aluFunction == ALU_SLT))) {
		return(0);
	} else if(((aluFunction == ALU_SLTU)) && ((operand1 < operand2))) {
		return(1);
	} else if(((aluFunction == ALU_SLTU))) {
		return(0);
	} else if(((aluFunction == ALU_SLL))) {
		return((static_cast<unsigned>(operand1) << static_cast<unsigned>(operand2.range(4, 0))));
	} else if(((aluFunction == ALU_SRA))) {
		return(ap_uint<32>((ap_int<32>(operand1) >> ap_int<32>(operand2.range(4, 0)))));
	} else if(((aluFunction == ALU_SRL))) {
		return((static_cast<unsigned>(operand1) >> static_cast<unsigned>(operand2.range(4, 0))));
	} else if(((aluFunction == ALU_COPY1))) {
		return(operand1);
	} else {
		return(0);
	} 
}

EncType getEncType(ap_uint<32> encodedInstr) {
	if (((encodedInstr.range(6, 0) == 51))) {
		return(ENC_R);
	} else if(((encodedInstr.range(6, 0) == 19))) {
		return(ENC_I_I);
	} else if(((encodedInstr.range(6, 0) == 3))) {
		return(ENC_I_L);
	} else if(((encodedInstr.range(6, 0) == 103))) {
		return(ENC_I_J);
	} else if(((encodedInstr.range(6, 0) == 35))) {
		return(ENC_S);
	} else if(((encodedInstr.range(6, 0) == 99))) {
		return(ENC_B);
	} else if(((encodedInstr.range(6, 0) == 55) || (encodedInstr.range(6, 0) == 23))) {
		return(ENC_U);
	} else if(((encodedInstr.range(6, 0) == 111))) {
		return(ENC_J);
	} else {
		return(ENC_ERR);
	} 
}

ap_uint<32> getEncUALUresult(ap_uint<32> encodedInstr, ap_uint<32> pcReg) {
	if (((getInstrType(encodedInstr) == INSTR_LUI))) {
		return(getALUresult(ALU_COPY1, getImmediate(encodedInstr), 0));
	} else {
		return(getALUresult(ALU_ADD, pcReg, getImmediate(encodedInstr)));
	} 
}

ap_uint<32> getImmediate(ap_uint<32> encodedInstr) {
	if (((encodedInstr.range(6, 0) == 19) || (encodedInstr.range(6, 0) == 3) || (encodedInstr.range(6, 0) == 103)) && ((encodedInstr.range(31, 31) == 0))) {
		return(encodedInstr.range(31, 20));
	} else if(((encodedInstr.range(6, 0) == 19) || (encodedInstr.range(6, 0) == 3) || (encodedInstr.range(6, 0) == 103))) {
		return((ap_uint<20>(1048575), encodedInstr.range(31, 20)));
	} else if(((encodedInstr.range(6, 0) == 35)) && ((encodedInstr.range(31, 31) == 0))) {
		return((ap_uint<20>(0), encodedInstr.range(31, 25), encodedInstr.range(11, 7)));
	} else if(((encodedInstr.range(6, 0) == 35))) {
		return((ap_uint<20>(1048575), encodedInstr.range(31, 25), encodedInstr.range(11, 7)));
	} else if(((encodedInstr.range(6, 0) == 99)) && ((encodedInstr.range(31, 31) == 0))) {
		return((ap_uint<20>(0), encodedInstr.range(7, 7), encodedInstr.range(30, 25), encodedInstr.range(11, 8), ap_uint<1>(0)));
	} else if(((encodedInstr.range(6, 0) == 99))) {
		return((ap_uint<20>(1048575), encodedInstr.range(7, 7), encodedInstr.range(30, 25), encodedInstr.range(11, 8), ap_uint<1>(0)));
	} else if(((encodedInstr.range(6, 0) == 55) || (encodedInstr.range(6, 0) == 23))) {
		return((encodedInstr & ap_uint<32>(-4096)));
	} else if(((encodedInstr.range(6, 0) == 111)) && ((encodedInstr.range(31, 31) == 0))) {
		return((ap_uint<12>(0), encodedInstr.range(19, 12), encodedInstr.range(20, 20), encodedInstr.range(30, 21), ap_uint<1>(0)));
	} else if(((encodedInstr.range(6, 0) == 111))) {
		return((ap_uint<12>(4095), encodedInstr.range(19, 12), encodedInstr.range(20, 20), encodedInstr.range(30, 21), ap_uint<1>(0)));
	} else {
		return(0);
	} 
}

InstrType getInstrType(ap_uint<32> encodedInstr) {
	if (((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 0)) && ((encodedInstr.range(31, 25) == 0))) {
		return(INSTR_ADD);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 0)) && ((encodedInstr.range(31, 25) == 32))) {
		return(INSTR_SUB);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 0))) {
		return(INSTR_UNKNOWN);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 1))) {
		return(INSTR_SLL);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 2))) {
		return(INSTR_SLT);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 3))) {
		return(INSTR_SLTU);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 4))) {
		return(INSTR_XOR);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 5)) && ((encodedInstr.range(31, 25) == 0))) {
		return(INSTR_SRL);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 5)) && ((encodedInstr.range(31, 25) == 32))) {
		return(INSTR_SRA);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 5))) {
		return(INSTR_UNKNOWN);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 6))) {
		return(INSTR_OR);
	} else if(((encodedInstr.range(6, 0) == 51)) && ((encodedInstr.range(14, 12) == 7))) {
		return(INSTR_AND);
	} else if(((encodedInstr.range(6, 0) == 51))) {
		return(INSTR_UNKNOWN);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 0))) {
		return(INSTR_ADDI);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 1))) {
		return(INSTR_SLLI);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 2))) {
		return(INSTR_SLTI);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 3))) {
		return(INSTR_SLTUI);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 4))) {
		return(INSTR_XORI);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 5)) && ((encodedInstr.range(31, 25) == 0))) {
		return(INSTR_SRLI);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 5)) && ((encodedInstr.range(31, 25) == 32))) {
		return(INSTR_SRAI);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 5))) {
		return(INSTR_UNKNOWN);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 6))) {
		return(INSTR_ORI);
	} else if(((encodedInstr.range(6, 0) == 19)) && ((encodedInstr.range(14, 12) == 7))) {
		return(INSTR_ANDI);
	} else if(((encodedInstr.range(6, 0) == 19))) {
		return(INSTR_UNKNOWN);
	} else if(((encodedInstr.range(6, 0) == 3)) && ((encodedInstr.range(14, 12) == 0))) {
		return(INSTR_LB);
	} else if(((encodedInstr.range(6, 0) == 3)) && ((encodedInstr.range(14, 12) == 1))) {
		return(INSTR_LH);
	} else if(((encodedInstr.range(6, 0) == 3)) && ((encodedInstr.range(14, 12) == 2))) {
		return(INSTR_LW);
	} else if(((encodedInstr.range(6, 0) == 3)) && ((encodedInstr.range(14, 12) == 4))) {
		return(INSTR_LBU);
	} else if(((encodedInstr.range(6, 0) == 3)) && ((encodedInstr.range(14, 12) == 5))) {
		return(INSTR_LHU);
	} else if(((encodedInstr.range(6, 0) == 3))) {
		return(INSTR_UNKNOWN);
	} else if(((encodedInstr.range(6, 0) == 103))) {
		return(INSTR_JALR);
	} else if(((encodedInstr.range(6, 0) == 35)) && ((encodedInstr.range(14, 12) == 0))) {
		return(INSTR_SB);
	} else if(((encodedInstr.range(6, 0) == 35)) && ((encodedInstr.range(14, 12) == 1))) {
		return(INSTR_SH);
	} else if(((encodedInstr.range(6, 0) == 35)) && ((encodedInstr.range(14, 12) == 2))) {
		return(INSTR_SW);
	} else if(((encodedInstr.range(6, 0) == 35))) {
		return(INSTR_UNKNOWN);
	} else if(((encodedInstr.range(6, 0) == 99)) && ((encodedInstr.range(14, 12) == 0))) {
		return(INSTR_BEQ);
	} else if(((encodedInstr.range(6, 0) == 99)) && ((encodedInstr.range(14, 12) == 1))) {
		return(INSTR_BNE);
	} else if(((encodedInstr.range(6, 0) == 99)) && ((encodedInstr.range(14, 12) == 4))) {
		return(INSTR_BLT);
	} else if(((encodedInstr.range(6, 0) == 99)) && ((encodedInstr.range(14, 12) == 5))) {
		return(INSTR_BGE);
	} else if(((encodedInstr.range(6, 0) == 99)) && ((encodedInstr.range(14, 12) == 6))) {
		return(INSTR_BLTU);
	} else if(((encodedInstr.range(6, 0) == 99)) && ((encodedInstr.range(14, 12) == 7))) {
		return(INSTR_BGEU);
	} else if(((encodedInstr.range(6, 0) == 99))) {
		return(INSTR_UNKNOWN);
	} else if(((encodedInstr.range(6, 0) == 55))) {
		return(INSTR_LUI);
	} else if(((encodedInstr.range(6, 0) == 23))) {
		return(INSTR_AUIPC);
	} else if(((encodedInstr.range(6, 0) == 111))) {
		return(INSTR_JAL);
	} else {
		return(INSTR_UNKNOWN);
	} 
}

ME_MaskType getMemoryMask(InstrType instr) {
	if (((instr == INSTR_LB) || (instr == INSTR_SB))) {
		return(MT_B);
	} else if(((instr == INSTR_LH) || (instr == INSTR_SH))) {
		return(MT_H);
	} else if(((instr == INSTR_LW) || (instr == INSTR_SW))) {
		return(MT_W);
	} else if(((instr == INSTR_LBU))) {
		return(MT_BU);
	} else if(((instr == INSTR_LHU))) {
		return(MT_HU);
	} else {
		return(MT_X);
	} 
}

ap_uint<32> getRdAddr(ap_uint<32> encodedInstr) {
	if (((encodedInstr.range(6, 0) == 51) || (encodedInstr.range(6, 0) == 19) || (encodedInstr.range(6, 0) == 3) || (encodedInstr.range(6, 0) == 103) || (encodedInstr.range(6, 0) == 55) || (encodedInstr.range(6, 0) == 23) || (encodedInstr.range(6, 0) == 111))) {
		return(encodedInstr.range(11, 7));
	} else {
		return(0);
	} 
}

ap_uint<32> getRs1Addr(ap_uint<32> encodedInstr) {
	if (((encodedInstr.range(6, 0) == 51) || (encodedInstr.range(6, 0) == 19) || (encodedInstr.range(6, 0) == 3) || (encodedInstr.range(6, 0) == 103) || (encodedInstr.range(6, 0) == 35) || (encodedInstr.range(6, 0) == 99))) {
		return(encodedInstr.range(19, 15));
	} else {
		return(0);
	} 
}

ap_uint<32> getRs2Addr(ap_uint<32> encodedInstr) {
	if (((encodedInstr.range(6, 0) == 51) || (encodedInstr.range(6, 0) == 35) || (encodedInstr.range(6, 0) == 99))) {
		return(encodedInstr.range(24, 20));
	} else {
		return(0);
	} 
}

ap_uint<32> readRegfile(ap_uint<32> regfile_reg_file_01, ap_uint<32> regfile_reg_file_02, ap_uint<32> regfile_reg_file_03, ap_uint<32> regfile_reg_file_04, ap_uint<32> regfile_reg_file_05, ap_uint<32> regfile_reg_file_06, ap_uint<32> regfile_reg_file_07, ap_uint<32> regfile_reg_file_08, ap_uint<32> regfile_reg_file_09, ap_uint<32> regfile_reg_file_10, ap_uint<32> regfile_reg_file_11, ap_uint<32> regfile_reg_file_12, ap_uint<32> regfile_reg_file_13, ap_uint<32> regfile_reg_file_14, ap_uint<32> regfile_reg_file_15, ap_uint<32> regfile_reg_file_16, ap_uint<32> regfile_reg_file_17, ap_uint<32> regfile_reg_file_18, ap_uint<32> regfile_reg_file_19, ap_uint<32> regfile_reg_file_20, ap_uint<32> regfile_reg_file_21, ap_uint<32> regfile_reg_file_22, ap_uint<32> regfile_reg_file_23, ap_uint<32> regfile_reg_file_24, ap_uint<32> regfile_reg_file_25, ap_uint<32> regfile_reg_file_26, ap_uint<32> regfile_reg_file_27, ap_uint<32> regfile_reg_file_28, ap_uint<32> regfile_reg_file_29, ap_uint<32> regfile_reg_file_30, ap_uint<32> regfile_reg_file_31, ap_uint<32> src) {
	if (((src == 0))) {
		return(0);
	} else if(((src == 1))) {
		return(regfile_reg_file_01);
	} else if(((src == 2))) {
		return(regfile_reg_file_02);
	} else if(((src == 3))) {
		return(regfile_reg_file_03);
	} else if(((src == 4))) {
		return(regfile_reg_file_04);
	} else if(((src == 5))) {
		return(regfile_reg_file_05);
	} else if(((src == 6))) {
		return(regfile_reg_file_06);
	} else if(((src == 7))) {
		return(regfile_reg_file_07);
	} else if(((src == 8))) {
		return(regfile_reg_file_08);
	} else if(((src == 9))) {
		return(regfile_reg_file_09);
	} else if(((src == 10))) {
		return(regfile_reg_file_10);
	} else if(((src == 11))) {
		return(regfile_reg_file_11);
	} else if(((src == 12))) {
		return(regfile_reg_file_12);
	} else if(((src == 13))) {
		return(regfile_reg_file_13);
	} else if(((src == 14))) {
		return(regfile_reg_file_14);
	} else if(((src == 15))) {
		return(regfile_reg_file_15);
	} else if(((src == 16))) {
		return(regfile_reg_file_16);
	} else if(((src == 17))) {
		return(regfile_reg_file_17);
	} else if(((src == 18))) {
		return(regfile_reg_file_18);
	} else if(((src == 19))) {
		return(regfile_reg_file_19);
	} else if(((src == 20))) {
		return(regfile_reg_file_20);
	} else if(((src == 21))) {
		return(regfile_reg_file_21);
	} else if(((src == 22))) {
		return(regfile_reg_file_22);
	} else if(((src == 23))) {
		return(regfile_reg_file_23);
	} else if(((src == 24))) {
		return(regfile_reg_file_24);
	} else if(((src == 25))) {
		return(regfile_reg_file_25);
	} else if(((src == 26))) {
		return(regfile_reg_file_26);
	} else if(((src == 27))) {
		return(regfile_reg_file_27);
	} else if(((src == 28))) {
		return(regfile_reg_file_28);
	} else if(((src == 29))) {
		return(regfile_reg_file_29);
	} else if(((src == 30))) {
		return(regfile_reg_file_30);
	} else {
		return(regfile_reg_file_31);
	} 
}

#endif //FUNCTIONS_H