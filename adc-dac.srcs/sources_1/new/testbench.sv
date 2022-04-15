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
    logic [15:0] input_data;
    logic output_data;
    
    logic SCK;
    logic CSn;
    logic MISO;
    //logic [15:0] data;
    logic MOSI;
    logic [3:0] bit_counter;
    
    SPI_Master master(.SCK(SCK), .CSn(CSn), .MISO(MISO), .input_data(input_data), .MOSI(MOSI), .bit_counter(bit_counter));
    SPI_Slave slave(.SCK(SCK), .CSn(CSn), .MISO(MISO), .output_data(output_data), .MOSI(MOSI));
    
    initial input_data = 16'b0000101011110110;
    
endmodule
