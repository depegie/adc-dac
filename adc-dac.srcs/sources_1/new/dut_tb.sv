`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 11:18:41 PM
// Design Name: 
// Module Name: dut_tb
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


module dut_tb;
    logic [11:0] digital_in;
    
    logic SPI_SCK_dac;
    logic SPI_CSn_dac;
    logic SPI_MOSI_dac;
    
    logic [11:0] analog;
    
    logic SPI_SCK_adc;
    logic SPI_CSn_adc;
    logic SPI_MISO_adc;
    
    logic [11:0] digital_out;

    DigitalSineGen #(.BITS(12)) test(.out(digital_in));
    SPI_Serializer spi_serial(.SPI_SCK(SPI_SCK_dac), .SPI_CSn(SPI_CSn_dac), .SPI_MOSI(SPI_MOSI_dac), .digital_in(digital_in));
    PmodDA2 dac(.SPI_SCK(SPI_SCK_dac), .SPI_CSn(SPI_CSn_dac), .analog_out(analog), .SPI_MOSI(SPI_MOSI_dac));
    PmodAD1 adc(.SPI_SCK(SPI_SCK_adc), .SPI_CSn(SPI_CSn_adc), .SPI_MISO(SPI_MISO_adc), .analog_in(analog));
    SPI_Deserializer spi_deserial(.SPI_SCK(SPI_SCK_adc), .SPI_CSn(SPI_CSn_adc), .SPI_MISO(SPI_MISO_adc), .digital_out(digital_out));
    
endmodule
