`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:00:14 11/01/2017
// Design Name:   subsystem_pcadder
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/subsystem_pcadder_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: subsystem_pcadder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module subsystem_pcadder_tb;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg [1:0] pc_src;
	reg pc_enable;
	reg reset;
	reg CLK = 0;
	
	always
		#5 CLK = ~CLK;

	// Outputs
	wire [15:0] pc;

	// Instantiate the Unit Under Test (UUT)
	subsystem_pcadder uut (
		.a(a), 
		.b(b), 
		.pc_src(pc_src), 
		.pc_enable(pc_enable), 
		.reset(reset), 
		.CLK(CLK), 
		.pc(pc)
	);

	initial begin
		// Initialize Inputs
		a = 1;
		b = 2;
		pc_src = 0;
		pc_enable = 1;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 1;
		#10;
		reset = 0;

	end
      
endmodule

