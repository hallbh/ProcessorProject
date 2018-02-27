`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:14:28 11/01/2017
// Design Name:   ss2_datastack_16b
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/subsystem_gen2_datastack_16_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ss2_datastack_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module subsystem_gen2_datastack_16_tb;

	// Inputs
	reg [1:0] dp_inc;
	reg regWrite;
	reg [15:0] a;
	reg [15:0] b;
	reg [15:0] c;
	reg [15:0] d;
	reg [15:0] e;
	reg tr_write;
	reg [2:0] tr_src;
	reg reset;
	reg CLK = 0;
	
	always
		#5 CLK = ~CLK;

	// Outputs
	wire [15:0] read_data;

	// Instantiate the Unit Under Test (UUT)
	ss2_datastack_16b uut (
		.dp_inc(dp_inc), 
		.regWrite(regWrite), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.tr_write(tr_write), 
		.tr_src(tr_src), 
		.reset(reset), 
		.CLK(CLK), 
		.read_data(read_data)
	);

	initial begin
		// Initialize Inputs
		dp_inc = 0;
		regWrite = 0;
		a = 1;
		b = 2;
		c = 3;
		d = 4;
		e = 5;
		tr_write = 0;
		tr_src = 0;
		reset = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 1;
		#10;
		reset = 0;
		
		tr_src = 2;
		tr_write = 1;
		#10;
		
		tr_write = 0;
		dp_inc = 1;
		regWrite = 1;
		#10;
		
		dp_inc = 0;
		regWrite = 0;
		#10;
		
		tr_src = 4;
		tr_write = 1;
		#10;
		
		tr_write = 0;

	end
      
endmodule

