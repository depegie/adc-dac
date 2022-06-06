`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2022 08:46:43 PM
// Design Name: 
// Module Name: Clk1Hz
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


module Clk1Hz #(
    parameter DIVISOR = 27'd100_000_000)
    (
    input logic clk_100MHz,
    output logic clk_1Hz
    );
    logic [26:0] counter = 27'd0;
    
    always @(posedge clk_100MHz) begin
        if (counter >= DIVISOR - 1) begin
            counter <= 27'd0;
        end
        else begin
            counter <= counter + 27'd1;
        end
    end
    
    always @(posedge clk_100MHz) begin
        if (counter < DIVISOR/2) begin
            clk_1Hz <= 1'b1;
        end
        else begin
            clk_1Hz <= 1'b0;
        end
    end
endmodule
