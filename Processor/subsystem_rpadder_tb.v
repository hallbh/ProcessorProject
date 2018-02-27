`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:43:02 11/01/2017
// Design Name:   subsystem_rpadder
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/subsystem_rpadder_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: subsystem_rpadder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module subsystem_rpadder_tb;

	// Inputs
	reg [1:0] rp_inc;
	reg CLK = 0;
	reg reset;
	
	always
		#5 CLK = ~CLK;

	// Outputs
	wire [15:0] rp;

	// Instantiate the Unit Under Test (UUT)
	subsystem_rpadder uut (
		.rp_inc(rp_inc), 
		.CLK(CLK), 
		.reset(reset), 
		.rp(rp)
	);

	initial begin
		// Initialize Inputs
		rp_inc = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 1;
		#10;
		reset = 0;
		rp_inc = 1;
		
		#30;
		rp_inc = 0;
		
		#10;
		if (rp == 3) $display("Increment RP by 3: PASS");
		else $display("Increment RP by 3: FAIL");
		rp_inc = 2;
		
		#10;
		rp_inc = 0;
		
		#10;
		if (rp == 2) $display("Decrement RP by 1: PASS");
		else $display("Decrement RP by 1: FAIL");
		rp_inc = 1;
		
		#10;
		rp_inc = 0;
		
		#10;
		
		if (rp == 3) $display("Increment RP by 1: PASS");
		else $display("Increment RP by 1: FAIL");
		
		#20;
		if (rp == 3) $display("RP remains the same: PASS");
		else $display("RP remains the same: FAIL");
		rp_inc = 2;
		
		#30;
		rp_inc = 0;
		
		#10;
		if (rp == 0) $display("Decrement RP by 3: PASS");
		else $display("Decrement RP by 3: FAIL");
	end
      
endmodule

