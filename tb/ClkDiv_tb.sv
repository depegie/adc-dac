`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2022 09:42:25 PM
// Design Name: 
// Module Name: ClkDiv_tb
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


module ClkDiv_tb;
    logic Clk_tb;
    logic clk_1kHz_tb;
    logic clk_15MHz_tb;
    logic clk_20MHz_tb;

    Clk1kHz freq_1kHz(.clk_125MHz(Clk_tb), .clk_1kHz(clk_1kHz_tb));    
    Clk15MHz freq_15MHz(.clk_125MHz(Clk_tb), .clk_15MHz(clk_15MHz_tb));
    Clk20MHz freq_20MHz(.clk_125MHz(Clk_tb), .clk_20MHz(clk_20MHz_tb));
    
    always #4 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
    end
    
endmodule
