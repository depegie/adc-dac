`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 10:01:52 PM
// Design Name: 
// Module Name: Serializer_tb
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


module Serializer_tb #(
    parameter NUM_OF_BITS = 4'd12);

    logic Clk_tb;
    logic Rst_tb;
    logic [NUM_OF_BITS-1 : 0] DATAIN_tb;
    logic SCLK_tb;
    logic SYNCn_tb;
    logic DIN_tb;
    
//    logic counter_ena_tb;
//    logic [3:0] counter_tb;
//    logic [NUM_OF_BITS+3:0] buffer_tb;
    
    Serializer serial(
        .Clk(Clk_tb),
        .Rst(Rst_tb),
        .DATAIN(DATAIN_tb),
        .SCLK(SCLK_tb),
        .SYNCn(SYNCn_tb),
        .DIN(DIN_tb)
//        .counter_ena(counter_ena_tb),
//        .counter(counter_tb),
//        .buffer(buffer_tb)
    );
    
    always #5 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
        Rst_tb = 0;
        DATAIN_tb = 12'b1100_1001_0011;
        #5000 DATAIN_tb = 12'b1000_1001_0101;
        #5000 DATAIN_tb = 12'b0101_1000_1001;
    end
endmodule
