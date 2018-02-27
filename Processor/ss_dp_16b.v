`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:51:42 10/31/2017 
// Design Name: 
// Module Name:    ss_dp_16b 
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
module ss_dp_16b(
	input [15:0] add,
	input [1:0]  dp_src,
	input reset,
	input CLK,
	output [15:0] dp
	);
	
	wire [15:0] dp_o;
	wire [15:0] add_r;
	
	mux4_16b dp_mux (
	.a(0),
	.b(1),
	.c(-1),
	.sel(dp_src),
	.o(dp_o)
	);
	
	adder_16b dp_adder (
	.a(dp_o),
	.b(add),
	.ci(0),
	.r(add_r)
	);
	
	reg_16b dp_register (
	.D(add_r),
	.write(1),
	.CLK(CLK),
	.reset(reset),
	.Q(dp)
	);


endmodule
