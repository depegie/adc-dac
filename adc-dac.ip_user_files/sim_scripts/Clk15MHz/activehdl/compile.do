vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../ipstatic" \
"/tools/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"/tools/Xilinx/Vivado/2021.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../adc-dac.gen/sources_1/ip/Clk15MHz/Clk15MHz_clk_wiz.v" \
"../../../../adc-dac.gen/sources_1/ip/Clk15MHz/Clk15MHz.v" \

vlog -work xil_defaultlib \
"glbl.v"

