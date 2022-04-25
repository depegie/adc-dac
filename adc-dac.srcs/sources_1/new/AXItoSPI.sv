`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 01:49:19 AM
// Design Name: 
// Module Name: AXItoSPI
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


module AXItoSPI(
    input logic AXI_valid,
    output logic AXI_ready,
    input logic [11:0] digital_in,
    
    output logic SCK = 0,
    output logic CSn = 1,
    output logic MOSI,
    input logic MISO,
    
    output logic counter_en = 0,//
    output logic [3:0] counter = 15//
    );
    logic [15:0] buffer;
    
    assign buffer = {4'b0000, digital_in};
    assign AXI_ready = CSn;
    
    always #10 SCK = ~SCK;
    
    always_ff @(posedge SCK) begin
        if (AXI_valid && AXI_ready)
            counter_en <= 1;
    end
    
    always_ff @(negedge SCK) begin
        if (counter_en)
            counter <= counter - 1;
        else
            counter <= 15;
    end
    
    always_ff @(negedge SCK) begin
        if (counter_en)
            CSn <= 0;
        else
            CSn <= 1;
    end
    
    always_ff @(negedge SCK) begin
        if (counter_en)
            MOSI <= buffer[counter];
        else
            MOSI <= 'X; // dla odróżnienia
    end
    
    always_ff @(negedge SCK) begin
        if (counter == 0)
            counter_en <= 0;
    end
    
endmodule
