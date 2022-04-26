`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 07:16:21 PM
// Design Name: 
// Module Name: DigitalToAXI
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


module DigitalToAXI(
    input [11:0] digital_in,
    input ACLK,
    input ARESETn,
    input TREADY,
    output TVALID,
    output [11:0] TDATA
    );
endmodule
