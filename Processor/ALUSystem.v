`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:02:52 11/01/2017 
// Design Name: 
// Module Name:    ALUSystem 
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
module ALUSystem(
	input [15:0] ALUSrc_a,
	input [15:0] ALUSrc_b,
	input [15:0] B,
	input alu_src,
	input [3:0] alu_op,
	input reset,
	input CLK,
	output [15:0] R,
	output [15:0] br,
	output isZero,
	output ovfl
   );
	
	wire [15:0] A;
	wire [15:0] result;
	
	mux2_16b alusrc_mux(
		.a(ALUSrc_a),
		.b(ALUSrc_b),
		.sel(alu_src),
		.o(A)
	);
	
	alu_16b ALU(
		.a(A),
		.b(B),
		.op(alu_op),
		.r(result),
		.zero(isZero),
		.ovfl(ovfl)
	);
	
	reg_16b br_register(
		.D(result),
		.rstval(16'b0),
		.write(1'b1),
		.reset(reset),
		.CLK(CLK),
		.Q(br)
	);
	
	assign R = result;

endmodule
