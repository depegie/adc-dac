`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 12:15:09 AM
// Design Name: 
// Module Name: PmodAD1
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


module PmodAD1(
    input logic [11:0] analog_in,

    input logic SCK,
    input logic CSn,
    input logic MOSI,
    output logic MISO,
    
    output logic [3:0] counter = 15,
    output logic [15:0] buffer
    );
    
    assign buffer = {4'b0000, analog_in};
    
    always_ff @(negedge SCK) begin
        if (!CSn)
            counter <= counter - 1;
        else
            counter <= 15;
    end
    
    always_ff @(negedge SCK) begin
        MISO <= buffer[counter-1];
    end
    
endmodule
