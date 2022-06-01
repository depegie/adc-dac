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
    parameter BITS = 12);
    
    logic Clk_gen_tb;
    logic Clk_tb;
    logic Rst_n_tb;

    logic [BITS-1 : 0] data_tb;
    logic SCLK;
    logic SYNCn;
    logic DIN;
 
    logic counter_ena;
    logic [3:0] counter;
    logic [3:0] help_counter;
    logic [15:0] buffer;
    
//    logic [11:0] analog_out;
    
    SPI_Serializer spi_serial(
        .Clk(Clk_tb),
        .Rst_n(Rst_n_tb),
        .SCLK(SCLK),
        .SYNCn(SYNCn),
        .DIN(DIN),
        .digital_in(data_tb),
        .counter_ena(counter_ena),
        .counter(counter),
//        .help_counter(help_counter)
        .buffer(buffer)
    );
    
    always #1000 Clk_gen_tb = ~Clk_gen_tb;
    always #15 Clk_tb = ~Clk_tb;
    
    initial begin
        Clk_gen_tb = 0;
        Clk_tb = 0;
        Rst_n_tb = 1;
        data_tb = 12'b1100_1001_0011;
    end
endmodule
