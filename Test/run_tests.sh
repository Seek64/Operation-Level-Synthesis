#!/bin/bash

OLS_TEST_HOME="/import/home/deutschmann/Operation-Level-Synthesis/Test"

DESCAM="/import/home/deutschmann/DeSCAM/bin/DESCAM"
ONESPIN="/import/public/common/onespin/latest/bin/onespin"
VIVADO_HLS="/import/public/common/Xilinx/Vivado/2018.2/bin/vivado_hls"

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
$DESCAM -f ../Designs/UART/Uart_tx.h -o . -PrintITL --hls-sco
$DESCAM -f ../Designs/UART/Uart_tx.h -o . -PrintHLS --sco
cd PrintHLS
$VIVADO_HLS Uart_tx_run_hls.tcl
cd ..
$ONESPIN run_properties.tcl
rm -rf PrintHLS
rm -rf PrintITL
read -r Uart_tx_result<"test_result.txt"
rm -f test_result.txt

# Synthesize UART_RX as SCO
$DESCAM -f ../Designs/UART/Uart_rx.h -o . -PrintITL --hls-sco
$DESCAM -f ../Designs/UART/Uart_rx.h -o . -PrintHLS --sco
cd PrintHLS
$VIVADO_HLS Uart_rx_run_hls.tcl
cd ..
$ONESPIN run_properties.tcl
rm -rf PrintHLS
rm -rf PrintITL
read -r Uart_rx_result<"test_result.txt"
rm -f test_result.txt

if [[ $framer_result -eq 1 ]]
then
  echo "Framer test passed"
else
  echo "Framer test failed"
fi

if [[ $Uart_tx_result -eq 1 ]]
then
  echo "Uart_rx test passed"
else
  echo "Uart_rx test failed"
fi

if [[ $Uart_rx_result -eq 1 ]]
then
  echo "Uart_rx test passed"
else
  echo "Uart_rx test failed"
fi
