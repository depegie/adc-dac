`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2022 09:42:25 PM
// Design Name: 
// Module Name: clk_wiz_0_tb
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


module clk_wiz_0_tb;
    logic Clk_tb;
    logic SCLK_tb;
    
    Clk20MHz dut(.clk_100MHz(Clk_tb), .clk_20MHz(SCLK_tb));
    
    always #5 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
    end
    
endmodule
