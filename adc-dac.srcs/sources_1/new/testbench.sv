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
    logic [11:0] input_data;
    logic [11:0] output_data;
    
    logic ena;
    logic AXI_valid;
    logic AXI_ready;
    logic SCK;
    logic CSn;
    logic MISO;
    //logic [15:0] data;
    logic MOSI;
    logic [3:0] bit_counter;
    
    logic [3:0] c = 15;
    logic [15:0] buffer;
    
    DigitalSineGen #(.BITS(12)) generator(.out(input_data));
    SPI_Master master(.ena(ena), .AXI_valid(AXI_valid), .AXI_ready(AXI_ready), .SCK(SCK), .CSn(CSn), .MISO(MISO), .input_data(input_data), .MOSI(MOSI), .bit_counter(bit_counter));
    SPI_Slave slave(.SCK(SCK), .CSn(CSn), .MISO(MISO), .output_data(output_data), .MOSI(MOSI), .c(c), .buffer(buffer));
    
    initial begin
        AXI_valid = 1;
    end
    
endmodule
