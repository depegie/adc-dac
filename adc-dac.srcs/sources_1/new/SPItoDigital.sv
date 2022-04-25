`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 02:50:22 PM
// Design Name: 
// Module Name: SPItoDigital
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


module SPItoDigital(
    output logic SCK = 0,
    output logic CSn = 1,
    output logic MOSI,
    input logic MISO,
    
    output logic [11:0] digital_out,
    
    output logic [4:0] counter = 16,
    output logic [15:0] buffer
    );
    
    always #10 SCK = ~SCK;
        
    always_ff @(negedge SCK) begin
        if (counter == 0)
            counter <= 16;
        else
            counter <= counter - 1;
    end
    
    always_ff @(posedge SCK) begin
        buffer[counter] <= MISO;
    end
    
    always_ff @(posedge CSn) begin
        if (CSn)
            digital_out <= buffer[11:0];
    end
    
    always_ff @(negedge SCK) begin
        if (counter == 16)
            CSn <= 0;
        else if (counter == 0)
            CSn <= 1;
    end
    
    always_ff @(negedge CSn) begin
        if (!CSn)
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end
    
endmodule
