`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:27 11/01/2017 
// Design Name: 
// Module Name:    eight_leftshift 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module eight_leftshift(
    input [7:0] in,
    output [15:0] out
    );
	 
	assign out = in << 8;

endmodule
