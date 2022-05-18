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
    parameter BITS = 12);
    
    logic Clk_tb;
    logic Rst_n_tb;
    logic [BITS-1 : 0] data_tb;
    logic direction_tb;
    
    DigitalSineGen #(.BITS(BITS)) dut(
        .Clk(Clk_tb),
        .Rst_n(Rst_n_tb),
        .data(data_tb),
        .direction(direction_tb)
    );
    
    always #1 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 1;
        Rst_n_tb = 1;
        
        #20 Rst_n_tb = 0;
        #30 Rst_n_tb = 1;
    end
    
endmodule
