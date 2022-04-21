`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2022 01:31:44 PM
// Design Name: 
// Module Name: DigitalSineGen
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


module DigitalSineGen #(
    parameter BITS = 5,
    parameter MIN = 0,
    parameter MAX = 2**BITS - 1)
    (
    output logic direction = 1,
    output logic [BITS-1 : 0] out
    );
   
    logic clk = 1;
    //logic direction = 1;
    logic [BITS-1 : 0] counter = 1;
    
    assign out = counter;
    
    always #170 clk = ~clk;
    
    always_ff @(posedge clk) begin
        if (direction)
            counter <= counter + 1;
        else
            counter <= counter - 1;     
    end
    
    always_ff @(negedge clk) begin
        if (counter == MIN || counter == MAX)
            direction <= ~direction;
        else
            direction <= direction;
    end
    
endmodule
