`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2022 07:02:27 PM
// Design Name: 
// Module Name: AdcDacDriver
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


module AdcDacDriver #(
    parameter NUM_OF_BITS = 4'd12)
    (
    input logic Clk,
    input logic Rst_n,
    
    output logic SCLK_DAC,
    output logic SYNCn,
    output logic DIN,
    
    input logic SDATA,
    output logic SCLK_ADC,
    output logic CSn
    
//    output logic [NUM_OF_BITS-1 : 0]   DATAOUT
    );
    
    logic [NUM_OF_BITS-1 : 0]   DATAIN;
    logic [NUM_OF_BITS-1 : 0]   DATAOUT;
    
    DigitalSineGen gen(.Clk(Clk), .Rst_n(Rst_n), .data(DATAIN));
    Serializer ser(.Clk(Clk), .Rst_n(Rst_n), .DATAIN(DATAIN), .SCLK(SCLK_DAC), .SYNCn(SYNCn), .DIN(DIN));
    Deserializer des(.Clk(Clk), .Rst_n(Rst_n), .SDATA(SDATA), .SCLK(SCLK_ADC), .CSn(CSn), .DATAOUT(DATAOUT));
    ILA debug(.clk(SCLK_ADC), .probe0(DATAOUT));
    
endmodule