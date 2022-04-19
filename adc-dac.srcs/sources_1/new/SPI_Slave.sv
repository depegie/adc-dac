`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 01:49:19 AM
// Design Name: 
// Module Name: SPI_Slave
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


module SPI_Slave(
    input logic SCK,
    input logic CSn,
    input logic MOSI,
    output logic MISO,
    output logic [11:0] output_data,
    output logic c_ena = 0,//
    output logic [3:0] c = 15,//
    output logic [15:0] buffer//
    );
    
    //logic c_ena = 0;
    //logic [15:0] buffer;
    //assign output_data = MOSI;
    
    always_ff @(negedge SCK) begin
        if (!CSn)
            c <= c - 1;
        else
            c <= 15;
    end

    always_ff @(posedge SCK) begin
        if (!CSn)
            buffer[c] <= MOSI;
    end
    
    always_ff @(posedge CSn) begin
        if (c == 15)
            output_data <= buffer[11:0];
        else
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end

    always_ff @(negedge CSn) begin
        if (!CSn)
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end

endmodule
