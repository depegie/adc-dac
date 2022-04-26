`timescale 1ns / 1ns
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


module SPI_Serializer(
    input logic [11:0] digital_in, // 12-bitowe wejście dla sygnału cyfrowego
    
    output logic SPI_SCK = 0,  // zegar protokołu SPI
    output logic SPI_CSn = 1, // linia protokołu SPI informująca, czy dane są wysyłane
    output logic SPI_MOSI, // linia danych protokołu SPI w kierunku od master do slave
    input logic SPI_MISO, // linia danych protokołu SPI w kierunku od slave do master
    
    output logic counter_en = 0, // włącznik wewnętrznego licznika
    output logic [3:0] counter = 15, // licznik koordynujący przepływ szeregowej 16-bitowej danej
    output logic [15:0] buffer // bufor modułu
    );
    
    assign buffer = {4'b0000, digital_in}; // zdefiniowanie bufora, 4 najstarsze bity wynikają z dokumentacji przetwaornika
    
    always #25 SPI_SCK = ~SPI_SCK; // licznik protokołu SPI
    
    // moduł odpowiadający za rozpoczęcie czytanie danych z wejścia. W przypadku spełnienia
    // warunku następuje włączenie licznika koordunującego szeregową transmisję danych
    always_ff @(posedge SPI_SCK) begin
        if (SPI_CSn)
            counter_en <= 1;
    end
    
    // moduł odpowiadający za działanie i reset licznika. Licznik pozostaje w stanie 15,
    // gdy jest wyłączony
    always_ff @(negedge SPI_SCK) begin
        if (counter_en)
            counter <= counter - 1;
        else
            counter <= 15;
    end
    
     // proces odpowiadający za wysterowanie linii CSn. Dane są wysyłane, gdy działa licznik.
    always_ff @(negedge SPI_SCK) begin
        if (counter_en)
            SPI_CSn <= 0;
        else
            SPI_CSn <= 1;
    end
    
    // proces odpowiadający za wysterowanie linii danych MOSI. Na linię MOSI wystawiany jest
    // bit z bufora, na który aktualnie wskazuje licznik
    always_ff @(negedge SPI_SCK) begin
        if (counter_en)
            SPI_MOSI <= buffer[counter];
        else
            SPI_MOSI <= 'X; // dla odróżnienia
    end
    
    // proces odpowiadający za wyłączenie licznika.
    always_ff @(negedge SPI_SCK) begin
        if (counter == 0)
            counter_en <= 0;
    end
    
endmodule
