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
    input logic [11:0] VIN,  // wejście przetwornika symulujące sygnał analogowy, które w praktyce jest magistralą

    input logic SCLK, // zegar protokołu SPI
    input logic CSn, // linia protokołu SPI informująca, czy dane są wysyłane, stanowi jednocześnie włącznik licznika
    output logic SDATA // linia danych protokołu SPI w kierunku od slave do master
    );
    logic [3:0] counter = 15;  // licznik koordynujący kierowanie danych na szeregowe wyjście
    logic counter_ena = 0;
    logic [15:0] buffer; // bufor modułu
    
    assign buffer = {4'b0000, VIN};  // zdefiniowanie bufora, 4 najstarsze bity wynikają z dokumentacji przetwaornika
    
    // proces odpowiadający za działanie i reset licznika. Licznik pozostaje w stanie 15,
    // gdy jest wyłączony
    always_ff @(negedge SCLK) begin
        if (counter_ena)
            counter <= counter - 1;
        else if (CSn)
            counter <= 15;
    end
    
    // proces odpowiadający za wysterowanie linii danych MISO. Na linię MISO wystawiany jest
    // bit z bufora, na który aktualnie wskazuje licznik
    always_ff @(negedge SCLK) begin
        if (counter == 15 && !CSn)
            SDATA <= 1'bZ;
        else
            SDATA <= buffer[counter];
    end
    
    always_ff @(posedge SCLK) begin
//        if (CSn)
//            SDATA <= buffer[counter];
    end
    
    
    always_ff @(negedge SCLK) begin
        if (counter == 0)
            counter_ena <= 0;
    end
    
    always_ff @(negedge CSn) begin
        if (!CSn) begin
            counter_ena <= 1;
        end
    end

    always_ff @(posedge CSn) begin
        if (CSn) begin
            counter_ena <= 1;
            counter <= 15;
        end
    end
endmodule
