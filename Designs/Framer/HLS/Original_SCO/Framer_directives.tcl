config_rtl -reset all -reset_async -reset_level high
config_schedule -effort high -relax_ii_for_timing=0 -verbose=0
config_bind -effort high
config_interface -trim_dangling_port
set_directive_latency -max=0 Framer_operations
set_directive_interface -mode ap_ctrl_none Framer_operations
set_directive_interface -mode ap_none Framer_operations oof_sig
set_directive_interface -mode ap_none Framer_operations frame_pulse_sig
set_directive_interface -mode ap_none Framer_operations frame_pulse_notify
set_directive_interface -mode ap_none Framer_operations out_nextphase
set_directive_interface -mode ap_none Framer_operations out_frm_cnt
set_directive_interface -mode ap_none Framer_operations out_align
