`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:36:33 10/29/2017 
// Design Name: 
// Module Name:    mux4_16b 
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
module mux4_16b(
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    input [15:0] d,
    input [1:0] sel,
    output [15:0] o
    );

	//00 -> a, 01 -> b, 10 -> c, 11 -> d
	assign o = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);

endmodule
