`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 02:44:35 AM
// Design Name: 
// Module Name: SPI_Deserializer_tb
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


module SPI_Deserializer_tb;
    logic [11:0] digital_in;
    
    logic SPI_SCK_dac;
    logic SPI_CSn_dac;
    logic SPI_MOSI_dac;
    
//    logic counter_en_serial;
//    logic [3:0] counter_serial;
    
//    logic [3:0] counter_dac;
//    logic [15:0] buffer_dac;
    logic [11:0] analog;
    
    logic SPI_SCK_adc;
    logic SPI_CSn_adc;
    logic SPI_MISO_adc;
    logic [3:0] counter_adc;
    logic [15:0] buffer_adc;
    
    logic [4:0] counter_deserial;
    logic [15:0] buffer_deserial;
    logic [11:0] digital_out;
    
    DigitalSineGen #(.BITS(12)) generator(.out(digital_in));
    SPI_Serializer spi_serial(.SPI_SCK(SPI_SCK_dac), .SPI_CSn(SPI_CSn_dac), .SPI_MOSI(SPI_MOSI_dac), .digital_in(digital_in));
    PmodDA2 dac(.SPI_SCK(SPI_SCK_dac), .SPI_CSn(SPI_CSn_dac), .analog_out(analog), .SPI_MOSI(SPI_MOSI_dac));
    PmodAD1 adc(.SPI_SCK(SPI_SCK_adc), .SPI_CSn(SPI_CSn_adc), .SPI_MISO(SPI_MISO_adc), .analog_in(analog), .counter(counter_adc), .buffer(buffer_adc));
    SPI_Deserializer spi_deserial(.SPI_SCK(SPI_SCK_adc), .SPI_CSn(SPI_CSn_adc), .SPI_MISO(SPI_MISO_adc), .digital_out(digital_out), .counter(counter_deserial), .buffer(buffer_deserial));
    
endmodule
