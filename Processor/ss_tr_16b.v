`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:49:56 10/30/2017 
// Design Name: 
// Module Name:    trsubsystem 
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
module ss_tr_16b(
	input [15:0] a,
	input [15:0] b,
	input [15:0] c,
	input [15:0] d,
	input [15:0] e,
	input tr_write,
	input [2:0] tr_src,
	input reset,
	input CLK,
	output [15:0] tr
	);

	wire [15:0] tr_o;

	mux8_16b tr_mux (
	.a(a),
	.b(b),
	.c(c),
	.d(d),
	.e(e),
	.sel(tr_src),
	.o(tr_o)
	);
	
	reg_16b top_register (
	.D(tr_o),
	.write(tr_write),
	.CLK(CLK),
	.reset(reset),
	.rstval(16'b0),
	.Q(tr)
	);

endmodule
