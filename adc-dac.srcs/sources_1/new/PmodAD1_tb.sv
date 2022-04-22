`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 12:25:38 AM
// Design Name: 
// Module Name: PmodAD1_tb
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


module PmodAD1_tb;
    logic SCK_tb;
    logic CSn_tb;
    logic MOSI_tb;
    logic MISO_tb;
    
    logic [11:0] analog_in_tb;
    logic [3:0] counter_tb;
    
    PmodAD1 adc(.SCK(SCK_tb), .CSn(CSn_tb), .MOSI(MOSI_tb), .MISO(MISO_tb), .analog_in(analog_in_tb), .counter(counter_tb));
    
    always #10 SCK_tb = ~SCK_tb;
    
    initial begin
        SCK_tb = 0;
        CSn_tb = 0;
        analog_in_tb = 12'b110010101011;
    end

endmodule
