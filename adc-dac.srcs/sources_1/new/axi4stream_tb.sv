`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2022 07:03:01 PM
// Design Name: 
// Module Name: axi4stream_tb
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


module axi4stream_tb #(parameter BYTES = 1);
    logic ACLK;
    logic ARESETn;
    logic TVALID;
    logic TREADY;
    
    logic [8*BYTES-1 : 0] mTDATA;
    logic [8*BYTES-1 : 0] sTDATA;

    axi4stream dut(ACLK, ARESETn, TVALID, TREADY, mTDATA, sTDATA);

    always begin
        #10 ACLK = ~ACLK;
    end
    
    initial begin
        ACLK = 1'b0;
        ARESETn = 1'b1;
        TVALID = 1'b0;
        TREADY = 1'b0;
        mTDATA = 8'b10110011;
        
        #10 TVALID = 1'b1;
        TREADY = 1'b1;
        
        #10 TVALID = 1'b0;
        TREADY = 1'b0;
    end

endmodule