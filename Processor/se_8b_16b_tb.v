`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:29:14 10/29/2017
// Design Name:   se_8b_16b
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/se_8b_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: se_8b_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module se_8b_16b_tb;

	// Inputs
	reg [7:0] in;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	se_8b_16b uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 11;

		// Wait 100 ns for global reset to finish
		#100;
		
		if ($signed(out) == $signed(in)) $display("SE positive: PASS");
		else $display("SE positive: FAIL");
		
		in = -8;
		#5;
		if ($signed(out) == $signed(in)) $display("SE negative: PASS");
      else $display("SE negative: FAIL");

	end
      
endmodule

