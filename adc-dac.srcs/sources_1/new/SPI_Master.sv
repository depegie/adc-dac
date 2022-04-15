`timescale 1ns / 1ps
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
//    input logic AXI_valid,
//    output logic AXI_ready,
    input logic ena,
    output logic SCK = 0,
    output logic CSn,
    input logic MISO,
    input logic [15:0] input_data,
    output logic MOSI,
    output logic [3:0] bit_counter = 15
    );
    
    logic counter_en = 1;
    
    always #10 SCK = ~SCK;
    
    always_ff @(negedge SCK) begin
        MOSI <= input_data[bit_counter];
    end
    
    always_ff @(negedge SCK) begin
        if (counter_en) begin
            if (bit_counter == 0) begin
                //bit_counter <= 15;
            end else begin
                bit_counter <= bit_counter - 1;
            end
        end
    end
    
//    always_ff @(negedge SCK) begin
//        if (bit_counter == 0)
//            counter_en = 0;
//        else
//            counter_en = 1;
//    end

//    always @(counter_en) begin
//        if (counter_en)
//            CSn = 0;
//        else
//            CSn = 1;
//    end
    
endmodule
