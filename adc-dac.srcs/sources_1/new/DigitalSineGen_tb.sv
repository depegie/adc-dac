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
    parameter NUM_OF_BITS = 4'd12);
    
    logic Clk_tb;
    logic Rst_tb;
    logic [NUM_OF_BITS-1 : 0] data_tb;
    
    DigitalSineGen #(.NUM_OF_BITS(NUM_OF_BITS)) dut(
        .Clk(Clk_tb),
        .Rst(Rst_tb),
        .data(data_tb)
    );
    
    always #4 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
        Rst_tb = 0;
        
        #20 Rst_tb = 1;
        #30 Rst_tb = 0;
    end
    
endmodule
