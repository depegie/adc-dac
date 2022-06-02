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
    input logic SCLK, // zegar
    input logic SYNCn, // linia informująca, czy dane są wysyłane, stanowi jednocześnie włącznik licznika
    input logic DIN, // linia danych szeregowych
    output logic [11:0] VOUT // wyjście przetwornika symulujące sygnał analogowy, które w praktyce jest magistralą
    );
    logic [3:0] counter = 15; // licznik koordynujący zapisanie szeregowych danych do bufora
    logic [15:0] buffer; // bufor modułu
    
    // proces odpowiadający za działanie i reset licznika. Licznik pozostaje w stanie 15,
    // gdy jest wyłączony
    always_ff @(posedge SCLK) begin
        if (!SYNCn)
            counter <= counter - 1;
        else
            counter <= 15;
    end

    // proces odpowiadający za zapis danej linii danych do bufora
    always_ff @(negedge SCLK) begin
        if (!SYNCn)
            buffer[counter] <= DIN;
    end
    
    // proces odpowiadający za powielenie na wyjście przetwornika, gdy kompletna dana (16-bitowa)
    // zostanie odebrana. Jeśli dana nie będzie kompletna, zostanie potraktowana jak śmieć
    // i usunięta z bufora.
    always_ff @(posedge SYNCn) begin
        if (counter == 15)
            VOUT <= buffer[11:0];
        else
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end

    // proces odpowiadający za czyszczenie bufora ze starej danej przed przyjmowaniem nowej
    always_ff @(negedge SYNCn) begin
        if (!SYNCn)
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end

endmodule
