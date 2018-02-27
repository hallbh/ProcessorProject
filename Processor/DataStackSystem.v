`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:24 11/01/2017 
// Design Name: 
// Module Name:    DataStackSystem 
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
module DataStackSystem(
	input [15:0] tr_src_a,
	input [15:0] tr_src_b,
	input [15:0] tr_src_c,
	input [15:0] tr_src_d,
	input [15:0] tr_src_f,
	input [2:0] tr_src,
	input tr_write,
	input [1:0] dp_inc,
	input reg_write,
	input reset,
	input CLK,
	output [15:0] TR,
	output [15:0] read_data
   );
	
	wire [15:0] tr_out;
	wire [15:0] address;
	
	TRSystem tr(
		.a(tr_src_a),
		.b(tr_src_b),
		.c(tr_src_c),
		.d(tr_src_d),
		.e(read_data),
		.f(tr_src_f),
		.tr_src(tr_src),
		.tr_write(tr_write),
		.reset(reset),
		.CLK(CLK),
		.TR(tr_out)
	);
	
	subsystem_dpadder dp(
		.dp_inc(dp_inc),
		.CLK(CLK),
		.reset(reset),
		.dp(address)
	);
	
	regFile256_16b regfile(
		.address(address[7:0]),
		.writeData(tr_out),
		.write(reg_write),
		.reset(reset),
		.CLK(CLK),
		.readData(read_data)
	);
	
	assign TR = tr_out;

endmodule
