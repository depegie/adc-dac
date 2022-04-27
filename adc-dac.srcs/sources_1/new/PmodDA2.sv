`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 01:49:19 AM
// Design Name: 
// Module Name: PmodDA2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moduł definujący model przetwornika cyfrowo-analogowego.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PmodDA2(
    input logic SPI_SCK, // zegar protokołu SPI
    input logic SPI_CSn, // linia protokołu SPI informująca, czy dane są wysyłane, stanowi jednocześnie włącznik licznika
    input logic SPI_MOSI, // linia danych protokołu SPI w kierunku od master do slave
    output logic SPI_MISO, // linia danych protokołu SPI w kierunku od slave do master
    
    output logic [11:0] analog_out, // wyjście przetwornika symulujące sygnał analogowy, które w praktyce jest magistralą
    
    output logic [3:0] counter = 15, // licznik koordynujący zapisanie szeregowych danych do bufora
    output logic [15:0] buffer // bufor modułu
    );
    
    
    // proces odpowiadający za działanie i reset licznika. Licznik pozostaje w stanie 15,
    // gdy jest wyłączony
    always_ff @(negedge SPI_SCK) begin
        if (!SPI_CSn)
            counter <= counter - 1;
        else
            counter <= 15;
    end

    // proces odpowiadający za zapis danej linii danych do bufora
    always_ff @(posedge SPI_SCK) begin
        if (!SPI_CSn)
            buffer[counter] <= SPI_MOSI;
    end
    
    // proces odpowiadający za powielenie na wyjście przetwornika, gdy kompletna dana (16-bitowa)
    // zostanie odebrana. Jeśli dana nie będzie kompletna, zostanie potraktowana jak śmieć
    // i usunięta z bufora.
    always_ff @(posedge SPI_CSn) begin
        if (counter == 15)
            analog_out <= buffer[11:0];
        else
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end

    // proces odpowiadający za czyszczenie bufora ze starej danej przed przyjmowaniem nowej
    always_ff @(negedge SPI_CSn) begin
        if (!SPI_CSn)
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end

endmodule
