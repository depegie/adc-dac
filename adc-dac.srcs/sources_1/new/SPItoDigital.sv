`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 02:50:22 PM
// Design Name: 
// Module Name: SPItoDigital
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


module SPItoDigital(
    output logic SCK = 0,  // zegar protokołu SPI                                 
    output logic CSn = 1, // linia protokołu SPI informująca, czy dane są wysyłane
    output logic MOSI, // linia danych protokołu SPI w kierunku od master do slave
    input logic MISO, // linia danych protokołu SPI w kierunku od slave do master
    
    output logic [11:0] digital_out, // wyjście cyfrowe
    
    output logic [4:0] counter = 16, // licznik koordynujący deserializację danych, ustawiony przerwotnie w stanie IDLE, czyli 16
    output logic [15:0] buffer // bufor modułu
    );
    
    always #10 SCK = ~SCK; // licznik protokołu SPI
        
   // proces odpowiadający za nieskończone działanie licznika w zakresie [16 : 0]
    always_ff @(negedge SCK) begin
        if (counter == 0)
            counter <= 16;
        else
            counter <= counter - 1;
    end
    
    // proces odpowiadający za zapisanie do odpowiedniego miejsca w buforze danej z wejścia
    always_ff @(posedge SCK) begin
        buffer[counter] <= MISO;
    end
    
    // proces odpowiadający za przekazanie na wyjście zawartości bufora
    always_ff @(posedge CSn) begin
        if (CSn)
            digital_out <= buffer[11:0];
    end
    
    // proces odpowiadający za wysterowanie linią CSn, robi to licznik
    always_ff @(negedge SCK) begin
        if (counter == 16)
            CSn <= 0;
        else if (counter == 0)
            CSn <= 1;
    end
    
    // proces odpowiadający za wyczyszczenie bufora przed przyjmowaniem kolejnej danej
    always_ff @(negedge CSn) begin
        if (!CSn)
            buffer <= 16'bXXXXXXXXXXXXXXXX;
    end
    
endmodule
