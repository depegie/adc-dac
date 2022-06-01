`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 01:49:19 AM
// Design Name: 
// Module Name: SPI_Serializer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moduł definiujący konwerter wejścia równoległego na wyjście szeregowe SPI
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SPI_Serializer #(
    parameter NUM_OF_BITS           = 12,
    parameter INITIAL_SYNCN         = 1'b1,
    parameter INITIAL_DIN           = 1'b0,
    parameter INITIAL_COUNTER_ENA   = 1'b1,
    parameter INITIAL_COUNTER       = 15,
    parameter INITIAL_BUFFER        = 16'b0000_0000_0000_0000)
    (
    input logic                     Clk,
    input logic                     Rst_n,
    input logic [NUM_OF_BITS-1 : 0] DATAIN,
    output logic                    SCLK,
    output logic                    SYNCn       = INITIAL_SYNCN,
    output logic                    DIN         = INITIAL_DIN
    );
    logic                           counter_ena = INITIAL_COUNTER_ENA;
    logic [3:0]                     counter     = INITIAL_COUNTER;
    logic [NUM_OF_BITS+3 : 0]       buffer      = INITIAL_BUFFER;
    
    Clk20MHz freq_20MHz(.clk_100MHz(Clk), .clk_20MHz(SCLK));

    always_ff @(posedge SCLK) begin
        if (!Rst_n || counter == 0) begin
            counter <= INITIAL_COUNTER;
        end
        else if (counter_ena) begin
            counter <= counter - 1;
        end
        else begin
            counter <= counter;
        end
    end
    
    always_ff @(posedge SCLK) begin
        if (!Rst_n) begin
            counter_ena <= INITIAL_COUNTER_ENA;
        end
        else if (counter == 0) begin
            counter_ena <= 0;
        end
        else if (counter == 15) begin
            counter_ena <= 1;
        end
        else begin
            counter_ena <= counter_ena;
        end
    end
    
    always_ff @(posedge SCLK) begin
        if (!Rst_n) begin
            SYNCn <= INITIAL_SYNCN;
        end
        else if (counter == 15) begin
            SYNCn <= ~SYNCn;
        end
        else begin
            SYNCn <= SYNCn;
        end
    end
    
    always_ff @(posedge SCLK) begin
        if (!Rst_n) begin
            DIN <= INITIAL_DIN;
        end
        else begin
            DIN <= buffer[counter];
        end
    end
    
    always_ff @(posedge SCLK) begin
        if (!Rst_n) begin
            buffer <= INITIAL_BUFFER;
        end
        else if (SYNCn) begin
            buffer <= {4'b0000, DATAIN};
        end
        else begin
            buffer <= buffer;
        end
    end
endmodule
