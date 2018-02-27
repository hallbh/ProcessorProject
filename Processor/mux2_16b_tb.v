`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:17:54 10/29/2017
// Design Name:   mux2_16b
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/mux2_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux2_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux2_16b_tb;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg sel;

	// Outputs
	wire [15:0] o;

	// Instantiate the Unit Under Test (UUT)
	mux2_16b uut (
		.a(a), 
		.b(b), 
		.sel(sel), 
		.o(o)
	);

	initial begin
		// Initialize Inputs
		a = 1;
		b = 2;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		repeat (2) begin
			#5;
			if (sel == 0 && o == a) $display("Mux A: PASS");
			else if (sel == 1 && o == b) $display("Mux B: PASS");
			else $display("FAIL");
			sel = sel + 1;
		end
	end
      
endmodule

