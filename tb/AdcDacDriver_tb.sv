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


module AdcDacDriver_tb;
    // sys
    logic Clk_tb;
    logic Rst_tb;
    
    // od strony DA
    logic SCLK_DAC_tb;
    logic SYNCn_tb;
    logic DIN_tb;
    
    // analog
    logic [11 : 0] V_tb;
    
    // od strony AD
    logic SDATA_tb;
    logic SCLK_ADC_tb;
    logic CSn_tb;
    logic [11 : 0]   DATAOUT_tb;
    
    AdcDacDriver dut(
        .Clk(Clk_tb),
        .Rst(Rst_tb),
        .SCLK_DAC(SCLK_DAC_tb),
        .SYNCn(SYNCn_tb),
        .DIN(DIN_tb),
        .SDATA(SDATA_tb),
        .SCLK_ADC(SCLK_ADC_tb),
        .CSn(CSn_tb)
    );

    PmodDA2 dac(
        .SCLK(SCLK_DAC_tb),
        .SYNCn(SYNCn_tb),
        .DIN(DIN_tb),
        .VOUT(V_tb)
    );
    
    PmodAD1 adc(
        .VIN(V_tb),
        .SCLK(SCLK_DAC_tb),
        .CSn(CSn_tb),
        .SDATA(SDATA_tb)
    );
    
    always #4 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
        Rst_tb = 0;
        
        #200000 Rst_tb = 1;
        #200005 Rst_tb = 0;
    end
    
endmodule