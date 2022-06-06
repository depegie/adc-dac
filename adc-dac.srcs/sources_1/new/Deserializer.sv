`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 02:50:22 PM
// Design Name: 
// Module Name: Deserializer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Moduł zamieniający wejście szeregowe na wyjście równoległe
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Deserializer #(
    parameter NUM_OF_BITS                   = 4'd12,
    parameter INITIAL_CSN                   = 1'b1,
    parameter INITIAL_DATAOUT               = 12'b0000_0000_0000,
    parameter INITIAL_COUNTER_ENA           = 1'b1,
    parameter INITIAL_CSN_DRIVER_COUNTER    = 5'd20,
    parameter INITIAL_DATA_COUNTER          = 4'd15,
    parameter INITIAL_DATA_VALID            = 1'b0,
    parameter INITIAL_BUFFER                = 12'b0000_0000_0000)
    (
    input logic                         Clk,
    input logic                         Rst_n,
    input logic                         SDATA,
    output logic                        SCLK,
    output logic                        CSn     = INITIAL_CSN,
    output logic [NUM_OF_BITS-1 : 0]    DATAOUT = INITIAL_DATAOUT
    );
    logic [4:0]                 CSn_driver_counter = INITIAL_CSN_DRIVER_COUNTER;
    logic [3:0]                 data_counter       = INITIAL_DATA_COUNTER;
    logic                       data_valid         = INITIAL_DATA_VALID;
    logic [NUM_OF_BITS-1 : 0]   buffer             = INITIAL_BUFFER;
    
    Clk15MHz freq_15MHz(.clk_100MHz(Clk), .clk_15MHz(SCLK));
    
    always_ff @(posedge SCLK) begin
        if (!Rst_n || CSn_driver_counter == 0) begin
            CSn_driver_counter <= INITIAL_CSN_DRIVER_COUNTER;
        end
        else begin
            CSn_driver_counter <= CSn_driver_counter - 1;
        end
    end

    always_ff @(posedge SCLK) begin
        if (!Rst_n || CSn_driver_counter == 0) begin
            data_counter <= INITIAL_DATA_COUNTER;
        end
        else if (data_counter > 0) begin
            data_counter <= data_counter - 1;
        end
        else begin
            data_counter <= data_counter;
        end
    end    

    always_ff @(posedge SCLK) begin
        if (!Rst_n) begin
            data_valid <= INITIAL_DATA_VALID;
        end
        else if (data_counter == 12) begin
            data_valid <= 1;
        end
        else if (data_counter == 0) begin
            data_valid <= 0;
        end
        else begin
            data_valid <= data_valid;
        end
    end
    
    always_ff @(posedge SCLK) begin
        if (!Rst_n) begin
            CSn <= INITIAL_CSN;
        end
        else if (CSn_driver_counter == 0) begin
            CSn <= 1;
        end
        else if (CSn_driver_counter == 20) begin
            CSn <= 0;
        end
        else begin
            CSn <= CSn;
        end
    end
    
    always_ff @(posedge SCLK) begin
        if (!Rst_n) begin
            buffer <= INITIAL_BUFFER;
        end
        else if (data_valid) begin
            buffer[data_counter] <= SDATA;
        end
    end
    
    always_ff @(posedge SCLK) begin
        if (!Rst_n) begin
            DATAOUT <= INITIAL_DATAOUT;
        end
        else if (CSn) begin
            DATAOUT <= buffer;
        end
        else begin
            DATAOUT <= DATAOUT;
        end
    end
endmodule
