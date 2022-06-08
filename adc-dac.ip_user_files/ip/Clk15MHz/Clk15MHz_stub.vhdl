-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.2 (lin64) Build 3367213 Tue Oct 19 02:47:39 MDT 2021
-- Date        : Fri Jun  3 22:12:44 2022
-- Host        : laptop running 64-bit Ubuntu 20.04.4 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top Clk15MHz -prefix
--               Clk15MHz_ Clk15MHz_stub.vhdl
-- Design      : Clk15MHz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Clk15MHz is
  Port ( 
    clk_15MHz : out STD_LOGIC;
    clk_100MHz : in STD_LOGIC
  );

end Clk15MHz;

architecture stub of Clk15MHz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_15MHz,clk_100MHz";
begin
end;
