-makelib xcelium_lib/xpm -sv \
  "/tools/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/tools/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../adc-dac.gen/sources_1/ip/Clk20MHz/Clk20MHz_clk_wiz.v" \
  "../../../../adc-dac.gen/sources_1/ip/Clk20MHz/Clk20MHz.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

