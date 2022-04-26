`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2022 01:50:25 PM
// Design Name: 
// Module Name: DigitalSineGen_tb
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


module DigitalSineGen_tb #(
    parameter BITS = 12
    );
    logic clk;
    logic [BITS-1 : 0] digital_out;
    logic direction;
    
    DigitalSineGen #(.BITS(BITS)) test(.CLK(clk), .out(digital_out), .direction(direction));
    
endmodule
