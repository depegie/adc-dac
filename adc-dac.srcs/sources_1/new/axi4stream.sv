`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2022 06:57:15 PM
// Design Name: 
// Module Name: axi4stream
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axi4stream #(parameter BYTES = 1)(
    input logic ACLK,
    input logic ARESETn,
    input logic TVALID,
    input logic TREADY,
    
    input logic [8*BYTES-1 : 0] mTDATA,
    output logic [8*BYTES-1 : 0] sTDATA
);
    
    always_ff @(posedge ACLK) begin
        if (TVALID & TREADY) begin
            sTDATA[8*BYTES-1 : 0] <= mTDATA[8*BYTES-1 : 0];
        end
    end
    
//    always_latch @(TVALID) begin
        
//    end
    
endmodule