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
    
    logic [11:0] V_tb;
    
    logic SCLK_tb;
    logic CSn_tb;
    logic SDATA_tb;
    
    logic [11:0] DATAOUT_tb;
    
    PmodAD1 adc(
        .SCLK(SCLK_tb),
        .CSn(CSn_tb),
        .SDATA(SDATA_tb),
        .VIN(V_tb)
    );
    
    Deserializer deserial(
        .Clk(Clk_tb),
        .Rst(Rst_tb),
        .SCLK(SCLK_tb),
        .CSn(CSn_tb),
        .SDATA(SDATA_tb),
        .DATAOUT(DATAOUT_tb)
    );
    
    always #4 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
        Rst_tb = 0;
        V_tb = 12'b1100_1001_0011;
        #10000 V_tb = 12'b1000_1001_0101;
        #10000 V_tb = 12'b0101_1000_1001;
        #10000 V_tb = 12'b1010_1010_1010;
        #10000 V_tb = 12'b1111_1101_1111;
        #10000 V_tb = 12'b1101_1011_1111;
        #12000 Rst_tb = 1;
        #13100 Rst_tb = 0;
    end
    
endmodule
