`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:47:57 10/31/2017 
// Design Name: 
// Module Name:    ss_rp_16b 
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
module ss_rp_16b(
	input [15:0] add,
	input [1:0]  rp_src,
	input reset,
	input CLK,
	output [15:0] rp
	);
	
	wire [15:0] rp_o;
	wire [15:0] add_r;
	 
	mux4_16b rp_mux (
	.a(0),
	.b(1),
	.c(-1),
	.sel(rp_src),
	.o(rp_o)
	);
	
	adder_16b rp_adder (
	.a(rp_o),
	.b(add),
	.ci(0),
	.r(add_r)
	);
	
	reg_16b rp_register (
	.D(add_r),
	.write(1),
	.CLK(CLK),
	.reset(reset),
	.Q(rp)
	);


endmodule
