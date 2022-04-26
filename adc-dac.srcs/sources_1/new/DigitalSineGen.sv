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
    parameter MIN = 0, // minimum sygnału
    parameter MAX = 2**BITS - 1) // maksimum sygnału
    (
    output logic direction = 1, // kierunek zliczania - 1 : rosnąco, 0 : malejąco
    output logic [BITS-1 : 0] out, // wyjście generatora (domyślnie 12-bitowe)
    output logic CLK = 1 // wewnętrzny zegar
    );
   
    logic [BITS-1 : 0] counter = 1; // licznik, który oznacza tyle, co wartość na wyjściu
    
    assign out = counter; // przekierowanie licznika na wyjście generatora
    
    always #425 CLK = ~CLK; // przemiatanie zegara dostosowane do szybkości przetworników
    
    // proces odpowiadający za zmianę wielkości na wyjściu generatora
    always_ff @(posedge CLK) begin
        if (direction)
            counter <= counter + 1;
        else
            counter <= counter - 1;     
    end
    
    // proces odpowiadający za decyzję, czy licznik ma rosnąć, czy maleć. W środku trwania
    // skrajnej wartości następuje zmiana kireunku licznika. tym sposobem wartość licznika
    // znajduje się w przedziale [MIN ; MAX], czyli domyślnie [0 ; 4095]
    always_ff @(negedge CLK) begin
        if (counter == MIN || counter == MAX)
            direction <= ~direction;
        else
            direction <= direction;
    end
    
endmodule
