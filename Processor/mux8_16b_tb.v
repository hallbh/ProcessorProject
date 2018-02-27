`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:26:12 10/29/2017
// Design Name:   mux8_16b
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/mux8_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux8_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mux8_16b_tb;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg [15:0] c;
	reg [15:0] d;
	reg [15:0] e;
	reg [15:0] f;
	reg [15:0] g;
	reg [15:0] h;
	reg [2:0] sel;

	// Outputs
	wire [15:0] o;

	// Instantiate the Unit Under Test (UUT)
	mux8_16b uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.f(f), 
		.g(g), 
		.h(h), 
		.sel(sel), 
		.o(o)
	);

	initial begin
		// Initialize Inputs
		a = 1;
		b = 2;
		c = 3;
		d = 4;
		e = 5;
		f = 6;
		g = 7;
		h = 8;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		repeat (8) begin
			#5;
			if (sel == 0 && o == a) $display("Mux A: PASS");
			else if (sel == 1 && o == b) $display("Mux B: PASS");
			else if (sel == 2 && o == c) $display("Mux C: PASS");
			else if (sel == 3 && o == d) $display("Mux D: PASS");
			else if (sel == 4 && o == e) $display("Mux E: PASS");
			else if (sel == 5 && o == f) $display("Mux F: PASS");
			else if (sel == 6 && o == g) $display("Mux G: PASS");
			else if (sel == 7 && o == h) $display("Mux H: PASS");
			else $display("FAIL");
			sel = sel + 1;
		end

	end
      
endmodule

