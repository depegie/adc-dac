`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 12:25:38 AM
// Design Name: 
// Module Name: PmodAD1_tb
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


module PmodAD1_tb;
    logic SCK_dac;
    logic CSn_dac;
    logic MOSI_dac;

    logic SCK_adc = 0;
    logic CSn_adc = 1;
    logic MOSI_adc;
    logic MISO_adc;
    
    logic [11:0] analog;
    logic [3:0] counter;
    
    DigitalSineGen #(.BITS(12)) generator(.out(digital_in));
    SPI_Serializer spi_serial(.SCK(SCK_dac), .CSn(CSn_dac), .MOSI(MOSI_dac), .digital_in(digital_in));
    PmodDA2 dac(.SCK(SCK_dac), .CSn(CSn_dac), .analog_out(analog), .MOSI(MOSI_dac), .MISO());
    PmodAD1 adc(.SCK(SCK_adc), .CSn(CSn_adc), .MOSI(MOSI_adc), .MISO(MISO_adc), .analog_in(analog), .counter(counter));
    
    always #10 SCK_adc = ~SCK_adc;

    
endmodule
