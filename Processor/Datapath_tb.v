`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:33:27 11/06/2017
// Design Name:   Datapath
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/Datapath_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Datapath_tb;

	// Inputs
	reg reset;
	reg CLK = 0;
	reg mem_CLK = 1;
	reg [15:0] in_data = 'h0906;
	
	always
		#2 mem_CLK = ~mem_CLK;
	
	always
		#4 CLK = ~CLK;

	// Outputs
	wire ovfl;

	// Instantiate the Unit Under Test (UUT)
	Datapath uut (
		.reset(reset), 
		.CLK(CLK), 
		.mem_CLK(mem_CLK), 
		.ovfl(ovfl),
		.in_data(in_data)
	);

	initial begin
		// Initialize Inputs
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 1;
		#8;
		reset = 0;

	end
      
endmodule

