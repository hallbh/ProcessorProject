`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:44 10/29/2017 
// Design Name: 
// Module Name:    mux2_16b 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: N/A
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux2_16b(
   input [15:0] a,
   input [15:0] b,
   input sel,
   output [15:0] o
	);
	
	//0 -> a, 1 -> b
	assign o = sel ? b : a;
	
endmodule
