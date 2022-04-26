`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 02:50:22 PM
// Design Name: 
// Module Name: SPI_Deserializer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moduł zamieniający szeregowe dane SPI na dane równoległe
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SPI_Deserializer(
    output logic SPI_SCK = 0,  // zegar protokołu SPI                                 
    output logic SPI_CSn = 1, // linia protokołu SPI informująca, czy dane są wysyłane
    output logic SPI_MOSI, // linia danych protokołu SPI w kierunku od master do slave
    input logic SPI_MISO, // linia danych protokołu SPI w kierunku od slave do master
    
    output logic [11:0] digital_out, // wyjście cyfrowe
    
    output logic [4:0] counter = 16, // licznik koordynujący deserializację danych, ustawiony przerwotnie w stanie IDLE, czyli 16
    output logic [15:0] buffer // bufor modułu
    );
    
    always #25 SPI_SCK = ~SPI_SCK; // licznik protokołu SPI
        
   // proces odpowiadający za nieskończone działanie licznika w zakresie [16 : 0]
    always_ff @(negedge SPI_SCK) begin
        if (counter == 0)
            counter <= 16;
        else
            counter <= counter - 1;
    end
    
    // proces odpowiadający za zapisanie do odpowiedniego miejsca w buforze danej z wejścia
    always_ff @(posedge SPI_SCK) begin
        buffer[counter] <= SPI_MISO;
    end
    
    // proces odpowiadający za przekazanie na wyjście zawartości bufora
    always_ff @(posedge SPI_CSn) begin
        if (SPI_CSn)
            digital_out <= buffer[11:0];
    end
    
    // proces odpowiadający za wysterowanie linią CSn, robi to licznik
    always_ff @(negedge SPI_SCK) begin
        if (counter == 16)
            SPI_CSn <= 0;
        else if (counter == 0)
            SPI_CSn <= 1;
    end
    
    // proces odpowiadający za wyczyszczenie bufora przed przyjmowaniem kolejnej danej
    always_ff @(negedge SPI_CSn) begin
        if (!SPI_CSn)
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end
    
endmodule
