`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:52:30 11/01/2017 
// Design Name: 
// Module Name:    subsystem_pcadder 
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
module subsystem_pcadder(
   input [15:0] a,
	input [15:0] b,
   input [1:0] pc_src,
   input pc_enable,
   input reset,
   input CLK,
   output [15:0] pc
   );
	
	wire [15:0] new_pc;
	wire [15:0] pc_out;
	wire [15:0] pc_plus1;
	
	adder_16b plus1(
		.a(pc_out),
		.b(16'b1),
		.ci(1'b0),
		.r(pc_plus1)
	);
	
	mux4_16b pc_mux(
		.a(pc_plus1),
		.b(a),
		.c(b),
		.d(16'b0),	//GND
		.sel(pc_src),
		.o(new_pc)
	);
	
	reg_16b pc_register(
		.D(new_pc),
		.rstval(16'b0),
		.write(pc_enable),
		.reset(reset),
		.CLK(CLK),
		.Q(pc_out)
	);
	
	assign pc = pc_out;

endmodule
