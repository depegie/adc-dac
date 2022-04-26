`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 10:01:52 PM
// Design Name: 
// Module Name: AXItoSPI_tb
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


module AXItoSPI_tb;
    logic AXI_valid;
    logic AXI_ready;
    logic [11:0] digital_in;
    logic SCK;
    logic CSn;
    logic MOSI;
    logic MISO;
    
    logic counter_en;
    logic [3:0] counter;

    DigitalSineGen #(.BITS(12)) generator(.out(digital_in), .AXI_valid(AXI_valid));
    AXItoSPI axi_spi_conv(.AXI_valid(AXI_valid), .AXI_ready(AXI_ready), .SCK(SCK), .CSn(CSn), .MOSI(MOSI), .digital_in(digital_in), .counter_en(counter_en), .counter(counter));

endmodule
