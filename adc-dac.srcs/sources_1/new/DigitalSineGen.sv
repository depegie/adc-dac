`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2022 01:31:44 PM
// Design Name: 
// Module Name: DigitalSineGen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moduł definiujący generator 12-bitowego sygnału cyfrowego sinusoidalnego.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DigitalSineGen #(
    parameter BITS = 12, // parametr określający liczbę bitów sygnału
    parameter INITIAL_DATA_VAL = 2**BITS/2, // początkowa wartość wyjścia
    parameter INITIAL_DIRECTION = 1, // początkowy kierunek zliczania
    parameter MIN_DATA_VAL = 0, // minimum sygnału
    parameter MAX_DATA_VAL = 2**BITS - 1) // maksimum sygnału
    (
    output logic direction = INITIAL_DIRECTION, // kierunek zliczania - 1:rosnąco, 0:malejąco
    output logic [BITS-1 : 0] data = INITIAL_DATA_VAL, // wyjście generatora (domyślnie 12-bitowe)
    input logic Clk, // wejście zegara
    input logic Rst_n // wejście resetu
    );
    
    // proces odpowiadający za zmianę wielkości na wyjściu generatora
    always_ff @(posedge Clk) begin
        if (!Rst_n) begin
            data <= INITIAL_DATA_VAL;
        end
        else if (direction) begin
            data <= data + 1;
        end
        else if (!direction) begin
            data <= data - 1;
        end
    end
    
    // proces odpowiadający za decyzję, czy licznik ma rosnąć, czy maleć. Przed
    // rozpoczęciem skrajnej wartości następuje zmiana kireunku licznika. tym
    // sposobem wartość licznika znajduje się w przedziale 
    // [MIN_OUTPUT_VAL ; MAX_OUTPUT_VAL], czyli domyślnie [0 ; 4095]
    always_ff @(posedge Clk) begin
        if (!Rst_n) begin
            direction <= INITIAL_DIRECTION;
        end
        else if (data == MAX_DATA_VAL-1) begin
            direction <= 0;
        end
        else if (data == MIN_DATA_VAL+1) begin
            direction <= 1;
        end
        else begin
            direction <= direction;
        end
    end
    
endmodule
