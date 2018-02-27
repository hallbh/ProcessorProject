`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:19:53 11/01/2017 
// Design Name: 
// Module Name:    BSystem 
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
module BSystem(
	input [15:0] a,
	input [15:0] b,
	input [15:0] c,
	input [15:0] d,
	input [15:0] e,
	input [2:0] b_src,
	input b_write,
	input reset,
	input CLK,
	output [15:0] B_out
   );
	
	wire [15:0] to_B;
	
	mux8_16b b_src_mux(
		.a(a),
		.b(b),
		.c(c),
		.d(d),
		.e(e),
		.f(16'b0), //GND
		.sel(b_src),
		.o(to_B)
	);
	
	reg_16b B_register(
		.D(to_B),
		.rstval(16'b0),
		.write(b_write),
		.reset(reset),
		.CLK(CLK),
		.Q(B_out)
	);


endmodule
