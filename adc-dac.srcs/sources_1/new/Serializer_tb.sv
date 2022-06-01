`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 10:01:52 PM
// Design Name: 
// Module Name: SPI_Serializer_tb
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


module SPI_Serializer_tb #(
    parameter NUM_OF_BITS = 12);

    logic Clk_tb;
    logic Rst_n_tb;
    logic [NUM_OF_BITS-1 : 0] DATAIN_tb;
    logic SCLK_tb;
    logic SYNCn_tb;
    logic DIN_tb;
    
//    logic counter_ena;
//    logic [3:0] counter;
//    logic [NUM_OF_BITS+3:0] buffer;
    
    SPI_Serializer spi_serial(
        .Clk(Clk_tb),
        .Rst_n(Rst_n_tb),
        .DATAIN(DATAIN_tb),
        .SCLK(SCLK_tb),
        .SYNCn(SYNCn_tb),
        .DIN(DIN_tb)
//        .counter_ena(counter_ena),
//        .counter(counter),
//        .buffer(buffer)
    );
    
    always #5 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_tb = 0;
        Rst_n_tb = 1;
        DATAIN_tb = 12'b1100_1001_0011;
    end
endmodule
