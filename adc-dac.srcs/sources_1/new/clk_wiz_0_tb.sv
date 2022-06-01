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
    logic locked_tb;
    logic resetn_tb;
    
    clk_wiz_0 dut(.clk_in1(Clk_tb), .clk_out1(SCLK_tb), .locked(locked_tb), .resetn(resetn_tb));
    
    always #15 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
        resetn_tb = 1;
    end
    
endmodule
