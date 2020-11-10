config_rtl -reset all -reset_async -reset_level high
config_schedule -effort high -relax_ii_for_timing=0 -verbose=0
config_bind -effort high
config_interface -trim_dangling_port
set_directive_latency -max=0 MasterAgent_operations
set_directive_interface -mode ap_ctrl_none MasterAgent_operations
set_directive_interface -mode ap_none MasterAgent_operations agent_to_bus_sig
set_directive_interface -mode ap_none MasterAgent_operations agent_to_master_notify
set_directive_interface -mode ap_none MasterAgent_operations master_to_agent_notify
set_directive_interface -mode ap_none MasterAgent_operations agent_to_bus_req
set_directive_interface -mode ap_none MasterAgent_operations agent_to_bus_resp
set_directive_interface -mode ap_none MasterAgent_operations section
set_directive_interface -mode ap_none MasterAgent_operations nextsection
