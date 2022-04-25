`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 01:49:19 AM
// Design Name: 
// Module Name: PmodDA2
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


module PmodDA2(
    input logic SCK,
    input logic CSn,
    input logic MOSI,
    output logic MISO,
    
    output logic [11:0] analog_out,
    
//    output logic counter_en = 0,
    output logic [3:0] counter = 15,//
    output logic [15:0] buffer//
    );
    
    always_ff @(negedge SCK) begin
        if (!CSn)
            counter <= counter - 1;
        else
            counter <= 15;
    end

    always_ff @(posedge SCK) begin
        if (!CSn)
            buffer[counter] <= MOSI;
    end
    
    always_ff @(posedge CSn) begin
        if (counter == 15)
            analog_out <= buffer[11:0];
        else
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end

    always_ff @(negedge CSn) begin
        if (!CSn)
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end

endmodule
