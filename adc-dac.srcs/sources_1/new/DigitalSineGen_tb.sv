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
    logic clk_tb;
    logic [BITS-1 : 0] out_tb;
    logic direction_tb;
    
    DigitalSineGen #(.BITS(BITS)) test(.out(out_tb), .direction(direction_tb));
    
    always #1 clk_tb = ~clk_tb;
    
    initial
        clk_tb = 1;
    
endmodule
