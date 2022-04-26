`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 12:15:09 AM
// Design Name: 
// Module Name: PmodAD1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moduł definujący model przetwornika analogowo-cyfrowego.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PmodAD1(
    input logic [11:0] analog_in,  // wejście przetwornika symulujące sygnał analogowy, które w praktyce jest magistralą

    input logic SPI_SCK, // zegar protokołu SPI
    input logic SPI_CSn, // linia protokołu SPI informująca, czy dane są wysyłane, stanowi jeddocześnie włącznik licznika
    input logic SPI_MOSI, // linia danych protokołu SPI w kierunku od master do slave
    output logic SPI_MISO, // linia danych protokołu SPI w kierunku od slave do master
    
    output logic [3:0] counter = 15,  // licznik koordynujący kierowanie danych na szeregowe wyjście
    output logic [15:0] buffer // bufor modułu
    );
    
    assign buffer = {4'b0000, analog_in};  // zdefiniowanie bufora, 4 najstarsze bity wynikają z dokumentacji przetwaornika
    
    // proces odpowiadający za działanie i reset licznika. Licznik pozostaje w stanie 15,
    // gdy jest wyłączony
    always_ff @(negedge SPI_SCK) begin
        if (!SPI_CSn)
            counter <= counter - 1;
        else
            counter <= 15;
    end
    
    // proces odpowiadający za wysterowanie linii danych MISO. Na linię MISO wystawiany jest
    // bit z bufora, na który aktualnie wskazuje licznik
    always_ff @(negedge SPI_SCK) begin
        SPI_MISO <= buffer[counter-1];
    end
    
endmodule
