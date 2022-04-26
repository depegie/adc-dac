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
    logic SCK;
    logic CSn;
    logic MOSI;
    logic MISO;
    logic [11:0] digital_in;
    logic [11:0] analog_out;
    
    logic [3:0] counter;
    
    DigitalSineGen #(.BITS(12)) generator(.out(digital_in), .AXI_valid(AXI_valid));
    AXItoSPI axi_spi_conv(.AXI_valid(AXI_valid), .AXI_ready(AXI_ready), .SCK(SCK), .CSn(CSn), .MOSI(MOSI), .digital_in(digital_in));
    PmodDA2 dac(.SCK(SCK), .CSn(CSn), .analog_out(analog_out), .MOSI(MOSI), .MISO(), .counter(counter));
    
endmodule
