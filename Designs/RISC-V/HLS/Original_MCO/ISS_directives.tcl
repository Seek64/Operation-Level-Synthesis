config_rtl -reset all -reset_async -reset_level high
config_schedule -effort high -relax_ii_for_timing=0 -verbose=0
config_bind -effort high
config_interface -trim_dangling_port
set_directive_interface -mode ap_ctrl_hs operations
set_directive_interface -mode ap_vld ISS_operations toMemoryPort_sig
set_directive_interface -mode ap_vld ISS_operations toRegsPort_sig
set_directive_interface -mode ap_vld ISS_operations fromMemoryPort_notify
set_directive_interface -mode ap_vld ISS_operations toMemoryPort_notify
set_directive_interface -mode ap_vld ISS_operations toRegsPort_notify
set_directive_interface -mode ap_vld ISS_operations out_regfileWrite
set_directive_interface -mode ap_vld ISS_operations out_pcReg
set_directive_allocation -limit 1 -type function ISS_operations branchPCcalculation
set_directive_allocation -limit 1 -type function ISS_operations getALUfunc
set_directive_allocation -limit 1 -type function ISS_operations getALUresult
set_directive_allocation -limit 1 -type function ISS_operations getEncType
set_directive_allocation -limit 1 -type function ISS_operations getEncUALUresult
set_directive_allocation -limit 1 -type function ISS_operations getImmediate
set_directive_allocation -limit 1 -type function ISS_operations getInstrType
set_directive_allocation -limit 1 -type function ISS_operations getMemoryMask
set_directive_allocation -limit 1 -type function ISS_operations getRdAddr
set_directive_allocation -limit 1 -type function ISS_operations getRs1Addr
set_directive_allocation -limit 1 -type function ISS_operations getRs2Addr
set_directive_allocation -limit 1 -type function ISS_operations readRegfile
