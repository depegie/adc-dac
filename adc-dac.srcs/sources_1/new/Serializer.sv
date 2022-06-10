`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 01:49:19 AM
// Design Name: 
// Module Name: Serializer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moduł zamieniający wejście równoległe na wyjście szeregowe
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Serializer #(
    parameter NUM_OF_BITS           = 4'd12,                        // parametr określający liczbę bitów sygnału
    parameter INITIAL_SYNCN         = 1'b1,                         // wartość początkowa linii SYNCn
    parameter INITIAL_DIN           = 1'b0,                         // wartość początkowa linii DIN
    parameter INITIAL_COUNTER_ENA   = 1'b1,                         // wartość początkowa włącznika licznika counter
    parameter INITIAL_COUNTER       = 4'd15,                        // wartość początkowa licznika counter
    parameter INITIAL_BUFFER        = 16'b0000_0000_0000_0000)      // wartość początkowa bufora
    (
    input logic                     Clk,                            // wejście zegara systemowego 100MHz
    input logic                     Rst,                            // wejście resetu
    input logic [NUM_OF_BITS-1 : 0] DATAIN,                         // wejście danych równoległych
    output logic                    SCLK,                           // wyjście zegara protokołu 20MHz
    output logic                    SYNCn   = INITIAL_SYNCN,        // wyjście linii SYNCn
    output logic                    DIN     = INITIAL_DIN           // wyjście danych szeregowych DIN
    );
    logic                       counter_ena = INITIAL_COUNTER_ENA;  // włącznik licznika
    logic [3:0]                 counter     = INITIAL_COUNTER;      // licznik kontrolujący wystawianie prawidłowych bitów na wyjście
    logic [NUM_OF_BITS+3 : 0]   buffer      = INITIAL_BUFFER;       // bufor z dodatkowymi 4 zerowymu najstarszymi bitami
    
    Clk15MHz freq_15MHz(.clk_125MHz(Clk), .clk_15MHz(SCLK));        // dzielnik częstotliwości
    
    // proces odpowiadający za działanie licznika i jego reset
    always_ff @(posedge SCLK) begin
        if (Rst) begin
            counter <= INITIAL_COUNTER;
        end
        else if (counter_ena) begin
            counter <= counter - 1;
        end
        else begin
            counter <= counter;
        end
    end
    
    // proces odpowiadający za włącznik licznika i jego reset
    always_ff @(posedge SCLK) begin
        if (Rst) begin
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
    
    // proces odpowiadający za wysterowanie linii SYNCn i jej reset
    always_ff @(posedge SCLK) begin
        if (Rst) begin
            SYNCn <= INITIAL_SYNCN;
        end
        else if (counter == 15) begin
            SYNCn <= ~SYNCn;
        end
        else begin
            SYNCn <= SYNCn;
        end
    end
    
    // proces odpowiadający za wysterowanie linii DIN i jej reset
    always_ff @(posedge SCLK) begin
        if (Rst) begin
            DIN <= INITIAL_DIN;
        end
        else begin
            DIN <= buffer[counter];
        end
    end
    
    // proces odpowiadający za wypełnienie bufora danymi  i jego reset
    always_ff @(posedge SCLK) begin
        if (Rst) begin
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