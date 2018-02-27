`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:34:32 10/29/2017
// Design Name:   ze_8b_16b
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/ze_8b_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ze_8b_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ze_8b_16b_tb;

	// Inputs
	reg [7:0] in;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	ze_8b_16b uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 8'h0F;

		// Wait 100 ns for global reset to finish
		#100;
        
		if (out == in) $display("ZE positive: PASS");
		else $display("ZE positve: FAIL");
		
		in = 8'hF0;
		#5;
		if ($unsigned(out) == $unsigned(in)) $display("ZE negative: PASS");
		else $display("ZE negative: FAIL");

	end
      
endmodule

