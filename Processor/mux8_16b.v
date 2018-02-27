`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:44:07 10/29/2017 
// Design Name: 
// Module Name:    mux8_16b 
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
module mux8_16b(
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    input [15:0] d,
    input [15:0] e,
    input [15:0] f,
    input [15:0] g,
    input [15:0] h,
    input [2:0] sel,
    output [15:0] o
    );

	//000 -> a, 001 -> b, 010 -> c, 011 -> d, 100 -> e, 101 -> f, 110 -> g, 111 -> h
	assign o = sel[2] ? (sel[1] ? (sel[0] ? h : g) : (sel[0] ? f : e)) : (sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a));

endmodule
