`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2022 05:11:36 PM
// Design Name: 
// Module Name: dut
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


module dut #(
    parameter NUM_OF_BITS = 4'd12)
    (
    input logic Clk,
    input logic Rst_n,
    // ser (DA)
    output logic SCLK_20MHz,
    output logic SYNCn,
    output logic DIN,
    
    // des (AD)
    input logic SDATA,
    output logic SCLK_15MHz,
    output logic CSn,
    output logic [NUM_OF_BITS-1 : 0]   DATAOUT
    );
    
    logic [NUM_OF_BITS-1 : 0]   DATAIN;
//    logic [NUM_OF_BITS-1 : 0]   DATAOUT;
    
    DigitalSineGen gen(.Clk(Clk), .Rst_n(Rst_n), .data(DATAIN), .clk_1kHz(clk_1kHz));
    Serializer ser(.Clk(Clk), .Rst_n(Rst_n), .DATAIN(DATAIN), .SCLK(SCLK_20MHz), .SYNCn(SYNCn), .DIN(DIN));
    Deserializer des(.Clk(Clk), .Rst_n(Rst_n), .SDATA(SDATA), .SCLK(SCLK_15MHz), .CSn(CSn), .DATAOUT(DATAOUT));
    
endmodule
