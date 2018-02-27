`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:06:04 11/01/2017 
// Design Name: 
// Module Name:    TRSystem 
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
module TRSystem(
	input [15:0] a,	// B Reg
	input [15:0] b,	// ALUout
	input [15:0] c,	// Left shifted imm
	input [15:0] d,	// Sign extended imm
	input [15:0] e,	// read_data from datastack
	input [15:0] f,	// User Input
	input [2:0] tr_src,
	input tr_write,
	input reset,
	input CLK,
	output [15:0] TR
   );
	
	wire [15:0] to_TR;
	
	mux8_16b tr_src_mux(
		.a(a),
		.b(b),
		.c(c),
		.d(d),
		.e(e),
		.f(f), //GND
		.g(16'b0),
		.sel(tr_src),
		.o(to_TR)
	);
	
	reg_16b tr_register(
		.D(to_TR),
		.rstval(16'b0),
		.write(tr_write),
		.reset(reset),
		.CLK(CLK),
		.Q(TR)
	);

endmodule
