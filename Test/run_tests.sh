#!/bin/bash

OLS_TEST_HOME="/import/home/deutschmann/Operation-Level-Synthesis/Test"

DESCAM="/import/home/deutschmann/DeSCAM/bin/DESCAM"
ONESPIN="/import/public/common/onespin/latest/bin/onespin"
VIVADO_HLS="/import/public/common/Xilinx/Vivado/2020.1/bin/vivado_hls"

cd $OLS_TEST_HOME

function CheckSCO {
  $DESCAM -f ../Designs/${1}/PPA/${2}.h -o . -PrintITL --hls-sco
  $DESCAM -f ../Designs/${1}/PPA/${2}.h -o . -PrintHLS --sco
  cd PrintHLS
  $VIVADO_HLS ${2}_run_hls.tcl
  cd ..
  $ONESPIN run_properties.tcl
  rm -rf PrintHLS
  rm -rf PrintITL
  read -r ${2}_result<"test_result.txt"
  rm -f test_result.txt
}

function PrintResult {
  if [[ $1 -eq 1 ]]
  then
    echo "$1 $2 test passed"
  else
    echo "$1 $2 test failed"
  fi
}

# Synthesize Framer as SCO
CheckSCO Framer Framer

# Synthesize UART_TX as SCO
CheckSCO UART Uart_tx

# Synthesize UART_RX as SCO
CheckSCO UART Uart_rx

# Synthesize Wishbone Interconnect as SCO
CheckSCO Wishbone Interconnect

# Synthesize Wishbone MasterAgent as SCO
CheckSCO Wishbone MasterAgent

# Synthesize Wishbone SlaveAgent as SCO
CheckSCO Wishbone SlaveAgent

# Synthesize RISC-V as MCO
$DESCAM -f ../Designs/RISC-V/PPA/ISS.h -o . -PrintITL --hls-mco
cd PrintITL
echo -e "\nmacro t_min : unsigned := 2; end macro;\nmacro t_max : unsigned := 7; end macro;" >> ISS_macros.vhi
cd ..
$DESCAM -f ../Designs/RISC-V/PPA/ISS.h -o . -PrintHLS --mco
cd PrintHLS
$VIVADO_HLS ISS_run_hls.tcl
cd ..
$ONESPIN run_properties.tcl
rm -rf PrintHLS
rm -rf PrintITL
read -r RISCV_result<"test_result.txt"
rm -f test_result.txt

PrintResult Framer_result sco

PrintResult Uart_tx_result sco

PrintResult Uart_rx_result sco

PrintResult Interconnect_result sco

PrintResult MasterAgent_result sco

PrintResult SlaveAgent_result sco

PrintResult RISCV_result mco
