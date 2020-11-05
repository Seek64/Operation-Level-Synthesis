#include "ap_int.h"
#include "ISS_functions.h"
#include "ISS_data_types.h"

void ISS_operations(
	RegfileType fromRegsPort_sig,
	MEtoCU_IF fromMemoryPort_sig,
	CUtoME_IF &toMemoryPort_sig,
	RegfileWriteType in_regfileWrite,
	ap_uint<32> in_pcReg,
	RegfileWriteType &out_regfileWrite,
	ap_uint<32> &out_pcReg,
	bool &fromMemoryPort_notify,
	bool &toMemoryPort_notify,
	bool &toRegsPort_notify,
	operation active_operation
)
{
	switch (active_operation) {
	case state_1_1:
		fromMemoryPort_notify = true;
		toMemoryPort_notify = false;
		toRegsPort_notify = false;
		break;
	case state_2_10:
		toMemoryPort_sig.addrIn = in_pcReg;
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = false;
		break;
	case state_2_2:
		out_pcReg = ((ap_uint<32>)4 + in_pcReg);
		out_regfileWrite.dst = getRdAddr(fromMemoryPort_sig.loadedData);
		out_regfileWrite.dstData = getALUresult(getALUfunc(getInstrType(fromMemoryPort_sig.loadedData)), readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs1Addr(fromMemoryPort_sig.loadedData)), readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs2Addr(fromMemoryPort_sig.loadedData)));
		toMemoryPort_sig.addrIn = ((ap_uint<32>)4 + in_pcReg);
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = true;
		break;
	case state_2_3:
		out_pcReg = branchPCcalculation(getALUresult(getALUfunc(getInstrType(fromMemoryPort_sig.loadedData)), readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs1Addr(fromMemoryPort_sig.loadedData)), readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs2Addr(fromMemoryPort_sig.loadedData))), fromMemoryPort_sig.loadedData, in_pcReg);
		toMemoryPort_sig.addrIn = branchPCcalculation(getALUresult(getALUfunc(getInstrType(fromMemoryPort_sig.loadedData)), readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs1Addr(fromMemoryPort_sig.loadedData)), readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs2Addr(fromMemoryPort_sig.loadedData))), fromMemoryPort_sig.loadedData, in_pcReg);
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = false;
		break;
	case state_2_4:
		toMemoryPort_sig.addrIn = getALUresult(ALU_ADD, readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs1Addr(fromMemoryPort_sig.loadedData)), getImmediate(fromMemoryPort_sig.loadedData));
		toMemoryPort_sig.dataIn = readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs2Addr(fromMemoryPort_sig.loadedData));
		toMemoryPort_sig.mask = getMemoryMask(getInstrType(fromMemoryPort_sig.loadedData));
		toMemoryPort_sig.req = ME_WR;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = false;
		break;
	case state_2_5:
		out_pcReg = ((ap_uint<32>)4 + in_pcReg);
		out_regfileWrite.dst = getRdAddr(fromMemoryPort_sig.loadedData);
		out_regfileWrite.dstData = getEncUALUresult(fromMemoryPort_sig.loadedData, in_pcReg);
		toMemoryPort_sig.addrIn = ((ap_uint<32>)4 + in_pcReg);
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = true;
		break;
	case state_2_6:
		out_pcReg = (in_pcReg + getImmediate(fromMemoryPort_sig.loadedData));
		out_regfileWrite.dst = getRdAddr(fromMemoryPort_sig.loadedData);
		out_regfileWrite.dstData = ((ap_uint<32>)4 + in_pcReg);
		toMemoryPort_sig.addrIn = (in_pcReg + getImmediate(fromMemoryPort_sig.loadedData));
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = true;
		break;
	case state_2_7:
		out_pcReg = ((ap_uint<32>)4 + in_pcReg);
		out_regfileWrite.dst = getRdAddr(fromMemoryPort_sig.loadedData);
		out_regfileWrite.dstData = getALUresult(getALUfunc(getInstrType(fromMemoryPort_sig.loadedData)), readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs1Addr(fromMemoryPort_sig.loadedData)), getImmediate(fromMemoryPort_sig.loadedData));
		toMemoryPort_sig.addrIn = ((ap_uint<32>)4 + in_pcReg);
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = true;
		break;
	case state_2_8:
		out_regfileWrite.dst = getRdAddr(fromMemoryPort_sig.loadedData);
		toMemoryPort_sig.addrIn = getALUresult(ALU_ADD, readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs1Addr(fromMemoryPort_sig.loadedData)), getImmediate(fromMemoryPort_sig.loadedData));
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = getMemoryMask(getInstrType(fromMemoryPort_sig.loadedData));
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = false;
		break;
	case state_2_9:
		out_pcReg = (readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs1Addr(fromMemoryPort_sig.loadedData)) + getImmediate(fromMemoryPort_sig.loadedData));
		out_regfileWrite.dst = getRdAddr(fromMemoryPort_sig.loadedData);
		out_regfileWrite.dstData = ((ap_uint<32>)4 + in_pcReg);
		toMemoryPort_sig.addrIn = (readRegfile(fromRegsPort_sig.reg_file_01, fromRegsPort_sig.reg_file_02, fromRegsPort_sig.reg_file_03, fromRegsPort_sig.reg_file_04, fromRegsPort_sig.reg_file_05, fromRegsPort_sig.reg_file_06, fromRegsPort_sig.reg_file_07, fromRegsPort_sig.reg_file_08, fromRegsPort_sig.reg_file_09, fromRegsPort_sig.reg_file_10, fromRegsPort_sig.reg_file_11, fromRegsPort_sig.reg_file_12, fromRegsPort_sig.reg_file_13, fromRegsPort_sig.reg_file_14, fromRegsPort_sig.reg_file_15, fromRegsPort_sig.reg_file_16, fromRegsPort_sig.reg_file_17, fromRegsPort_sig.reg_file_18, fromRegsPort_sig.reg_file_19, fromRegsPort_sig.reg_file_20, fromRegsPort_sig.reg_file_21, fromRegsPort_sig.reg_file_22, fromRegsPort_sig.reg_file_23, fromRegsPort_sig.reg_file_24, fromRegsPort_sig.reg_file_25, fromRegsPort_sig.reg_file_26, fromRegsPort_sig.reg_file_27, fromRegsPort_sig.reg_file_28, fromRegsPort_sig.reg_file_29, fromRegsPort_sig.reg_file_30, fromRegsPort_sig.reg_file_31, getRs1Addr(fromMemoryPort_sig.loadedData)) + getImmediate(fromMemoryPort_sig.loadedData));
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = true;
		break;
	case state_3_11:
		fromMemoryPort_notify = true;
		toMemoryPort_notify = false;
		toRegsPort_notify = false;
		break;
	case state_4_12:
		out_pcReg = ((ap_uint<32>)4 + in_pcReg);
		toMemoryPort_sig.addrIn = ((ap_uint<32>)4 + in_pcReg);
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = false;
		break;
	case state_5_13:
		fromMemoryPort_notify = true;
		toMemoryPort_notify = false;
		toRegsPort_notify = false;
		break;
	case state_6_14:
		out_pcReg = ((ap_uint<32>)4 + in_pcReg);
		out_regfileWrite.dstData = fromMemoryPort_sig.loadedData;
		toMemoryPort_sig.addrIn = ((ap_uint<32>)4 + in_pcReg);
		toMemoryPort_sig.dataIn = (ap_uint<32>)0;
		toMemoryPort_sig.mask = MT_W;
		toMemoryPort_sig.req = ME_RD;
		out_regfileWrite.dst = in_regfileWrite.dst;
		fromMemoryPort_notify = false;
		toMemoryPort_notify = true;
		toRegsPort_notify = true;
		break;
	}
}