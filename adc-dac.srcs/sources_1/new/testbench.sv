`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 02:44:35 AM
// Design Name: 
// Module Name: testbench
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


module testbench;
    logic AXI_valid;
    logic AXI_ready;
    logic [11:0] digital_in;
    
    logic SCK_dac;
    logic CSn_dac;
    logic MOSI_dac;
    
//    logic counter_en_asconv;
//    logic [3:0] counter_asconv;
    
//    logic [3:0] counter_dac;
//    logic [15:0] buffer_dac;
    logic [11:0] analog;
    
    logic SCK_adc;
    logic CSn_adc;
    logic MISO_adc;
//    logic [3:0] counter_adc;
//    logic [15:0] buffer_adc;
    
//    logic [4:0] counter_spconv;
//    logic [15:0] buffer_spconv;
    logic [11:0] digital_out;
    
    DigitalSineGen #(.BITS(12)) generator(.out(digital_in), .AXI_valid(AXI_valid));
    AXItoSPI axi_spi_conv(.AXI_valid(AXI_valid), .AXI_ready(AXI_ready), .SCK(SCK_dac), .CSn(CSn_dac), .MOSI(MOSI_dac), .digital_in(digital_in));
    PmodDA2 dac(.SCK(SCK_dac), .CSn(CSn_dac), .analog_out(analog), .MOSI(MOSI_dac));
    PmodAD1 adc(.SCK(SCK_adc), .CSn(CSn_adc), .MISO(MISO_adc), .analog_in(analog));
    SPItoDigital spi_parallel_conv(.SCK(SCK_adc), .CSn(CSn_adc), .MISO(MISO_adc), .digital_out(digital_out));

//    DigitalSineGen #(.BITS(12)) generator(.out(digital_in));
//    AXItoSPI axi_spi_conv(.counter_en(counter_en_asconv), .AXI_valid(AXI_valid), .AXI_ready(AXI_ready), .SCK(SCK_dac), .CSn(CSn_dac), .MOSI(MOSI_dac), .digital_in(digital_in), .counter(counter_asconv));
//    PmodDA2 dac(.SCK(SCK_dac), .CSn(CSn_dac), .analog_out(analog), .MOSI(MOSI_dac), .counter(counter_dac), .buffer(buffer_dac));
//    PmodAD1 adc(.SCK(SCK_adc), .CSn(CSn_adc), .MISO(MISO_adc), .analog_in(analog), .counter(counter_adc), .buffer(buffer_adc));
//    SPItoDigital spi_parallel_conv(.SCK(SCK_adc), .CSn(CSn_adc), .MISO(MISO_adc), .counter(counter_spconv), .buffer(buffer_spconv), .digital_out(digital_out));
    
    initial begin
    end
    
endmodule
