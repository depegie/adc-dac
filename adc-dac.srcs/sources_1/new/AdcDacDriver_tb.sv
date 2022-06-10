`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2022 07:01:40 PM
// Design Name: 
// Module Name: AdcDacDriver_tb
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


module AdcDacDriver_tb #(
    parameter NUM_OF_BITS = 4'd12);
    
    // sys
    logic Clk;
    logic Rst_n;
    
    // od strony DA
    logic SCLK_DAC;
    logic SYNCn;
    logic DIN;
    
    // analog
    logic [NUM_OF_BITS-1 : 0] V;
    
    // od strony AD
    logic SDATA;
    logic SCLK_ADC;
    logic CSn;
    logic [NUM_OF_BITS-1 : 0]   DATAOUT;
    
    AdcDacDriver dut(
        .Clk(Clk),
        .Rst_n(Rst_n),
        .SCLK_DAC(SCLK_DAC),
        .SYNCn(SYNCn),
        .DIN(DIN),
        .SDATA(SDATA),
        .SCLK_ADC(SCLK_ADC),
        .CSn(CSn),
        .DATAOUT(DATAOUT)
    );

    PmodDA2 dac(
        .SCLK(SCLK_DAC),
        .SYNCn(SYNCn),
        .DIN(DIN),
        .VOUT(V)
    );
    
    PmodAD1 adc(
        .VIN(V),
        .SCLK(SCLK_DAC),
        .CSn(CSn),
        .SDATA(SDATA)
    );
    
    always #4 Clk = ~Clk;
    
    initial begin
        Clk = 0;
        Rst_n = 1;
    end
    
endmodule