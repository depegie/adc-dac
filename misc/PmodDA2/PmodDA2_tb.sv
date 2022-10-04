`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 10:22:53 PM
// Design Name: 
// Module Name: PmodDA2_tb
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


module PmodDA2_tb;
    logic Clk_tb;
    logic Rst_n_tb;

    logic SCLK_tb;
    logic SYNCn_tb;
    logic DIN_tb;
    logic [11:0] DATAIN_tb;
    logic [11:0] VOUT_tb;
    
//    DigitalSineGen #(.BITS(12)) generator(.out(digital_in));
    Serializer serial(.Clk(Clk_tb), .Rst_n(Rst_n_tb), .DATAIN(DATAIN_tb), .SCLK(SCLK_tb), .SYNCn(SYNCn_tb), .DIN(DIN_tb));
    PmodDA2 dac(.SCLK(SCLK_tb), .SYNCn(SYNCn_tb), .DIN(DIN_tb), .VOUT(VOUT_tb));
    
    always #5 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
        Rst_n_tb = 1;
        DATAIN_tb = 12'b1100_1001_0011;
        #5000 DATAIN_tb = 12'b1000_1001_0101;
        #5000 DATAIN_tb = 12'b0101_1000_1001;
    end
    
endmodule
