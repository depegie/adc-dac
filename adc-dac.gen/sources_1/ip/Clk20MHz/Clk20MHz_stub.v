// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (lin64) Build 3367213 Tue Oct 19 02:47:39 MDT 2021
// Date        : Wed Jun  1 21:56:44 2022
// Host        : laptop running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top Clk20MHz -prefix
//               Clk20MHz_ Clk20MHz_stub.v
// Design      : Clk20MHz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module Clk20MHz(clk_20MHz, clk_100MHz)
/* synthesis syn_black_box black_box_pad_pin="clk_20MHz,clk_100MHz" */;
  output clk_20MHz;
  input clk_100MHz;
endmodule
