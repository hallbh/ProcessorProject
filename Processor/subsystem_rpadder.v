`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:38:05 11/01/2017 
// Design Name: 
// Module Name:    subsystem_rpadder 
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
module subsystem_rpadder(
	input [1:0] rp_inc,
	input CLK,
   input reset,
   output [15:0] rp
   );
	
	wire [15:0] inc_a;
	wire [15:0] increment;
	wire [15:0] rp_val;

	mux4_16b inc_mux(
		.a(16'b0),
		.b(16'b1),
		.c(-16'sb1),
		.d(16'b0),
		.sel(rp_inc),
		.o(inc_a)
	);

	adder_16b incrementer(
		.a(inc_a),
		.b(rp_val),
		.ci(16'b0),
		.r(increment)
	);

	reg_16b rp_register(
		.D(increment),
		.rstval(16'd16384),
		.write(1'b1),
		.reset(reset),
		.CLK(CLK),
		.Q(rp_val)
	);
	
	assign rp = rp_val;

endmodule
