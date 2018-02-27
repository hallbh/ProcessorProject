`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:53:46 10/31/2017 
// Design Name: 
// Module Name:    ss_pc_16b 
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
module ss_pc_16b(
	input [15:0] add,
	input [15:0] b,
	input pc_src,
	input pc_write,
	input reset,
	input CLK,
	output [15:0] pc
	);
	
	wire [15:0] pc_o;
	wire [15:0] add_r;
	
	adder_16b pc_adder (
	.a(add),
	.b(1),
	.ci(0),
	.r(add_r)
	);
	
	mux2_16b pc_mux (
	.a(add_r),
	.b(b),
	.sel(pc_src),
	.o(pc_o)
	);
	
	reg_16b pc_register (
	.D(pc_o),
	.write(pc_write),
	.CLK(CLK),
	.reset(reset),
	.Q(pc)
	);


endmodule
