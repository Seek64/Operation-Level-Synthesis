#!/bin/bash

OLS_TEST_HOME="/import/home/deutschmann/Operation-Level-Synthesis/Test"

DESCAM="/import/home/deutschmann/DeSCAM/bin/DESCAM"
ONESPIN="/import/public/common/onespin/latest/bin/onespin"
VIVADO_HLS="/import/public/common/Xilinx/Vivado/2020.1/bin/vivado_hls"

cd $OLS_TEST_HOME

# Synthesize Framer as SCO
$DESCAM -f ../Designs/Framer/PPA/Framer.h -o . -PrintITL --hls-sco
$DESCAM -f ../Designs/Framer/PPA/Framer.h -o . -PrintHLS --sco
cd PrintHLS
$VIVADO_HLS Framer_run_hls.tcl
cd ..
$ONESPIN run_properties.tcl
rm -rf PrintHLS
rm -rf PrintITL
read -r framer_result<"test_result.txt"
rm -f test_result.txt

# Synthesize UART_TX as SCO
$DESCAM -f ../Designs/UART/PPA/Uart_tx.h -o . -PrintITL --hls-sco
$DESCAM -f ../Designs/UART/PPA/Uart_tx.h -o . -PrintHLS --sco
cd PrintHLS
$VIVADO_HLS Uart_tx_run_hls.tcl
cd ..
$ONESPIN run_properties.tcl
rm -rf PrintHLS
rm -rf PrintITL
read -r Uart_tx_result<"test_result.txt"
rm -f test_result.txt

# Synthesize UART_RX as SCO
$DESCAM -f ../Designs/UART/PPA/Uart_rx.h -o . -PrintITL --hls-sco
$DESCAM -f ../Designs/UART/PPA/Uart_rx.h -o . -PrintHLS --sco
cd PrintHLS
$VIVADO_HLS Uart_rx_run_hls.tcl
cd ..
$ONESPIN run_properties.tcl
rm -rf PrintHLS
rm -rf PrintITL
read -r Uart_rx_result<"test_result.txt"
rm -f test_result.txt

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

if [[ $framer_result -eq 1 ]]
then
  echo "Framer sco test passed"
else
  echo "Framer sco test failed"
fi

if [[ $Uart_tx_result -eq 1 ]]
then
  echo "Uart_tx sco test passed"
else
  echo "Uart_tx sco test failed"
fi

if [[ $Uart_rx_result -eq 1 ]]
then
  echo "Uart_rx sco test passed"
else
  echo "Uart_rx sco test failed"
fi

if [[ $RISCV_result -eq 1 ]]
then
  echo "RISC-V mco test passed"
else
  echo "RISC-V mco test failed"
fi
