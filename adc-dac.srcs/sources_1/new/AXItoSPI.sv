`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2022 01:49:19 AM
// Design Name: 
// Module Name: AXItoSPI
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moduł definiujący konwerter AXI-Stream - SPI
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AXItoSPI(
    input logic AXI_valid,  // linia protokołu AXI-Stream informująca, czy dane na wyjściu są ważne
    output logic AXI_ready, // linia protokołu AXI-Stream informująca, czy moduł jest gotowy do przyjęcia kolejnej danej
    input logic [11:0] digital_in, // 12-bitowe wejście dla sygnału cyfrowego
    
    output logic SCK = 0,  // zegar protokołu SPI
    output logic CSn = 1, // linia protokołu SPI informująca, czy dane są wysyłane
    output logic MOSI, // linia danych protokołu SPI w kierunku od master do slave
    input logic MISO, // linia danych protokołu SPI w kierunku od slave do master
    
    output logic counter_en = 0, // włącznik wewnętrznego licznika
    output logic [3:0] counter = 15 // licznik koordynujący przepływ szeregowej 16-bitowej danej
    );
    logic [15:0] buffer; // bufor modułu
    
    assign buffer = {4'b0000, digital_in}; // zdefiniowanie bufora, 4 najstarsze bity wynikają z dokumentacji przetwaornika
    assign AXI_ready = CSn; // niniejsze linie są równoważne
    
    always #10 SCK = ~SCK; // licznik protokołu SPI
    
    // moduł odpowiadający za rozpoczęcie czytanie danych z wejścia. W przypadku spełnienia
    // warunku następuje włączenie licznika koordunującego szeregową transmisję danych
    always_ff @(posedge SCK) begin
        if (AXI_valid && AXI_ready)
            counter_en <= 1;
    end
    
    // moduł odpowiadający za działanie i reset licznika. Licznik pozostaje w stanie 15,
    // gdy jest wyłączony
    always_ff @(negedge SCK) begin
        if (counter_en)
            counter <= counter - 1;
        else
            counter <= 15;
    end
    
     // proces odpowiadający za wysterowanie linii CSn. Dane są wysyłane, gdy działa licznik.
    always_ff @(negedge SCK) begin
        if (counter_en)
            CSn <= 0;
        else
            CSn <= 1;
    end
    
    // proces odpowiadający za wysterowanie linii danych MOSI. Na linię MOSI wystawiany jest
    // bit z bufora, na który aktualnie wskazuje licznik
    always_ff @(negedge SCK) begin
        if (counter_en)
            MOSI <= buffer[counter];
        else
            MOSI <= 'X; // dla odróżnienia
    end
    
    // proces odpowiadający za wyłączenie licznika.
    always_ff @(negedge SCK) begin
        if (counter == 0)
            counter_en <= 0;
    end
    
endmodule
