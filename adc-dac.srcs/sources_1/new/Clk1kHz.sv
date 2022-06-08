`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2022 08:46:43 PM
// Design Name: 
// Module Name: Clk1kHz
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


module Clk1kHz #(
    parameter DIVISOR = 17'd100_000)
    (
    input logic clk_100MHz,
    output logic clk_1kHz = 1'b0
    );
    logic [16:0] counter = 17'd0;
    
    always_ff @(posedge clk_100MHz) begin
        if (counter >= DIVISOR - 1) begin
            counter <= 17'd0;
        end
        else begin
            counter <= counter + 17'd1;
        end
    end
    
    always_ff @(posedge clk_100MHz) begin
        if (counter < DIVISOR/2) begin
            clk_1kHz <= 1'b0;
        end
        else begin
            clk_1kHz <= 1'b1;
        end
    end
endmodule
