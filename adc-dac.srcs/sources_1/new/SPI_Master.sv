`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 01:49:19 AM
// Design Name: 
// Module Name: SPI_Master
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


module SPI_Master(
    input logic MISO,
    input logic [15:0] input_data,
    input logic AXI_valid,
    output logic AXI_ready = 1,
    output logic SCK = 0,
    output logic CSn = 1,
    output logic MOSI,
    
    output logic ena = 0,//
    output logic [3:0] bit_counter = 15//
    );
    
    always #10 SCK = ~SCK;
    
    always_ff @(posedge SCK) begin
        if (AXI_valid && AXI_ready)
            ena <= 1;
    end
    
    always_ff @(negedge SCK) begin
        if (ena)
            bit_counter <= bit_counter - 1;
        else
            bit_counter <= 15;
    end
    
    always_ff @(negedge SCK) begin
        if (ena) begin
            CSn <= 0;
            AXI_ready <= 0;
        end else begin
            CSn <= 1;
            AXI_ready <= 1;
        end
    end
    
    always_ff @(negedge SCK) begin
        if (ena)
            MOSI <= input_data[bit_counter];
        else
            MOSI <= 'X; // dla odróżnienia
    end
    
    always_ff @(negedge SCK) begin
        if (bit_counter == 0)
            ena <= 0;
    end
    
endmodule
