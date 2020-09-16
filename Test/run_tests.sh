#!/bin/bash

OLS_TEST_HOME="/import/home/deutschmann/Operation-Level-Synthesis/Test"

DESCAM="/import/home/deutschmann/DeSCAM/bin/DESCAM"
ONESPIN="/import/public/common/onespin/latest/bin/onespin"
VIVADO_HLS="/import/public/common/Xilinx/Vivado/2018.2/bin/vivado_hls"

cd $OLS_TEST_HOME

 Synthesize Framer as SCO
$DESCAM -f ../Designs/Framer/PPA/Framer.h -o . -PrintITL --hls-sco
$DESCAM -f ../Designs/Framer/PPA/Framer.h -o . -PrintHLS --sco
cd PrintHLS
$VIVADO_HLS Framer_run_hls.tcl
cd ..
$ONESPIN run_properties.tcl
rm -rf PrintHLS
rm -rf PrintITL

read -r result<"test_result.txt"
rm -f test_result.txt
if [[ $result -eq 1 ]]
then
  echo "Test passed"
else
  echo "Test failed"
fi
