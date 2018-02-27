`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:59:23 11/08/2017
// Design Name:   se_12b_16b
// Module Name:   C:/Users/evardl/Documents/Classes/CSSE 232/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/se_12b_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: se_12b_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module se_12b_16b_tb;

	// Inputs
	reg [11:0] in;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	se_12b_16b uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here
		in = 12'h123;
		#10;
		if ($signed(out) == $signed(in)) $display("SE positive: PASS");
		else $display("SE positive: FAIL");
		
		in = 12'hFE1;
		#10;
		if ($signed(out) == $signed(in)) $display("SE negative: PASS");
      else $display("SE negative: FAIL");

	end
      
endmodule

