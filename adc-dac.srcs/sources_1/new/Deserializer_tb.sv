`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 02:44:35 AM
// Design Name: 
// Module Name: Deserializer_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Deserializer_tb;
    logic Clk_tb;
    logic Rst_tb;
    
    logic [11:0] DATAIN_tb;
    
    logic SCLK_dac_tb;
    logic SYNCn_dac_tb;
    logic DIN_dac_tb;
    
    logic [11:0] V_tb;
    
    logic SCLK_adc_tb;
    logic CSn_adc_tb;
    logic SDATA_adc_tb;
    
    logic [11:0] DATAOUT_tb;
    
//    DigitalSineGen #(.BITS(12)) generator(.out(digital_in));
    Serializer serial(.Clk(Clk_tb), .Rst(Rst_tb), .DATAIN(DATAIN_tb), .SCLK(SCLK_dac_tb), .SYNCn(SYNCn_dac_tb), .DIN(DIN_dac_tb));
    PmodDA2 dac(.SCLK(SCLK_dac_tb), .SYNCn(SYNCn_dac_tb), .DIN(DIN_dac_tb), .VOUT(V_tb));
    PmodAD1 adc(.SCLK(SCLK_adc_tb), .CSn(CSn_adc_tb), .SDATA(SDATA_adc_tb), .VIN(V_tb));
    Deserializer deserial(.Clk(Clk_tb), .Rst(Rst_tb), .SCLK(SCLK_adc_tb), .CSn(CSn_adc_tb), .SDATA(SDATA_adc_tb), .DATAOUT(DATAOUT_tb));
    
    always #5 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
        Rst_tb = 0;
        DATAIN_tb = 12'b1100_1001_0011;
        #10000 DATAIN_tb = 12'b1000_1001_0101;
        #10000 DATAIN_tb = 12'b0101_1000_1001;
        #10000 DATAIN_tb = 12'b1010_1010_1010;
        #10000 DATAIN_tb = 12'b1111_1101_1111;
        #10000 DATAIN_tb = 12'b1101_1011_1111;
    end
    
endmodule
