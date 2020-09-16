read_vhdl -golden  -pragma_ignore {}  -version 93 "./PrintHLS/*.vhd"
read_vhdl -golden  -pragma_ignore {}  -version 93 "./PrintHLS/synthesis/solution1/syn/vhdl/*.vhd"

elaborate -golden
set_mode mv

set_check_option -local_processes 4

read_itl  "./PrintITL/*.vhi"

check  -stop_on_first_fail [get_properties]

set properties_hold 1
foreach property [get_properties] {
    set property_status [get_check_info -status $property]
    if {$property_status != "hold" && $property_status != "vacuous"} {set properties_hold 0}
}

set outputFile "./test_result.txt"
set outputFileId [open $outputFile "w"]
puts $outputFileId $properties_hold
close $outputFileId
