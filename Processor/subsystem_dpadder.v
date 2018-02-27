`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:19:20 11/01/2017 
// Design Name: 
// Module Name:    subsystem_dpadder 
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
module subsystem_dpadder(
   input [1:0] dp_inc,
	input CLK,
   input reset,
   output [15:0] dp
   );

	wire [15:0] inc_a;
	wire [15:0] increment;
	wire [15:0] dp_val;

	mux4_16b inc_mux(
		.a(16'b0),
		.b(16'b1),
		.c(-16'sb1),
		.d(16'b0), //GND
		.sel(dp_inc),
		.o(inc_a)
	);

	adder_16b incrementer(
		.a(inc_a),
		.b(dp_val),
		.ci(1'b0),
		.r(increment)
	);

	reg_16b dp_register(
		.D(increment),
		.rstval(-16'sb1),
		.write(1'b1),
		.reset(reset),
		.CLK(CLK),
		.Q(dp_val)
	);
	
	assign dp = dp_val;

endmodule
