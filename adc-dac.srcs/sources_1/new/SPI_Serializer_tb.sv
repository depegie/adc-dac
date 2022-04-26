`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 10:01:52 PM
// Design Name: 
// Module Name: SPI_Serializer_tb
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


module SPI_Serializer_tb;
    logic [11:0] digital_in;
    logic SPI_SCK;
    logic SPI_CSn;
    logic SPI_MOSI;
    logic SPI_MISO;
    
    logic counter_en;
    logic [3:0] counter;
    logic [15:0] buffer;

    DigitalSineGen #(.BITS(12)) generator(.out(digital_in));
    SPI_Serializer spi_serial(.SPI_SCK(SPI_SCK), .SPI_CSn(SPI_CSn), .SPI_MOSI(SPI_MOSI), .digital_in(digital_in), .counter_en(counter_en), .counter(counter), .buffer(buffer));
endmodule
