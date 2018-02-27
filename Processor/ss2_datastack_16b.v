`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:15 10/31/2017 
// Design Name: 
// Module Name:    ss2_datastack_16b 
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
module ss2_datastack_16b(
	input [1:0]  dp_inc,
	input regWrite,
	input [15:0] a,
	input [15:0] b,
	input [15:0] c,
	input [15:0] d,
	input [15:0] e,
	input tr_write,
	input [2:0] tr_src,
	input reset,
	input CLK,
	output [15:0] read_data
	);
	
	wire [15:0] dp;
	wire [15:0] tr;
	wire [15:0] reg_out;
	
	ss_tr_16b ss_tr (
	.a(a),
	.b(b),
	.c(c),
	.d(d),
	.e(reg_out),
	.tr_write(tr_write),
	.tr_src(tr_src),
	.reset(reset),
	.CLK(CLK),
	.tr(tr)
	);
	
	subsystem_dpadder ss_dp (
	.dp_inc(dp_inc),
	.reset(reset),
	.CLK(CLK),
	.dp(dp)
	);
	
	regFile256_16b regFile (
	.address(dp[7:0]),
	.writeData(tr),
	.write(regWrite),
	.reset(reset),
	.CLK(CLK),
	.readData(reg_out)
	);

	assign read_data = reg_out;

endmodule
