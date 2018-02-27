`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:12:18 10/31/2017
// Design Name:   ss_tr_16b
// Module Name:   C:/Users/evardl/Documents/Classes/CSSE 232/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/ss_tr_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ss_tr_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ss_tr_16b_tb;

	// Inputs
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
	wire [15:0] tr_o;

	// Instantiate the Unit Under Test (UUT)
	ss_tr_16b uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.tr_write(tr_write), 
		.tr_src(tr_src), 
		.reset(reset), 
		.CLK(CLK), 
		.tr(tr_o)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 1;
		c = 2;
		d = 3;
		e = 4;
		tr_write = 1;
		tr_src = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		repeat (5) begin
			#10;
			if (tr_src == 0 && tr_o == 0) $display("MUX a to TR: PASS");
			else if (tr_src == 1 && tr_o == 1) $display("MUX b to TR: PASS");
			else if (tr_src == 2 && tr_o == 2) $display("MUX c to TR: PASS");
			else if (tr_src == 3 && tr_o == 3) $display("MUX d to TR: PASS");
			else if (tr_src == 4 && tr_o == 4) $display("MUX e to TR: PASS");
			else $display("FAIL");
			
			if (tr_src < 4)
				tr_src = tr_src + 1;
		end

	end
      
endmodule

