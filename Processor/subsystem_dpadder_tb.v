`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:30:09 11/01/2017
// Design Name:   subsystem_dpadder
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/subsystem_dpadder_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: subsystem_dpadder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module subsystem_dpadder_tb;

	// Inputs
	reg [1:0] dp_inc;
	reg CLK = 0;
	reg reset;
	
	always
		#5 CLK = ~CLK;

	// Outputs
	wire [15:0] dp;

	// Instantiate the Unit Under Test (UUT)
	subsystem_dpadder uut (
		.dp_inc(dp_inc), 
		.CLK(CLK), 
		.reset(reset), 
		.dp(dp)
	);

	initial begin
		// Initialize Inputs
		dp_inc = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#105;
        
		// Add stimulus here
		reset = 1;
		#10;
		reset = 0;
		dp_inc = 1;
		
		#20;
		dp_inc = 0;
		
		#10;
		if (dp == 2) $display("Increment DP by 2: PASS");
		else $display("Increment DP by 2: FAIL");
		dp_inc = 2;
		
		#10;
		dp_inc = 0;
		
		#10;
		if (dp == 1) $display("Decrement DP by 1: PASS");
		else $display("Decrement DP by 1: FAIL");
		dp_inc = 1;
		
		#20;
		dp_inc = 0;
		
		#10;
		if (dp == 3) $display("Increment DP by 2: PASS");
		else $display("Increment DP by 2: FAIL");
		
		#20;
		if (dp == 3) $display("DP remains the same: PASS");
		else $display("DP remains the same: FAIL");
		dp_inc = 2;
		
		#20;
		dp_inc = 0;
		
		#10;
		if (dp == 1) $display("Decrement DP by 2: PASS");
		else $display("Decrement DP by 2: FAIL");
		

	end
      
endmodule

