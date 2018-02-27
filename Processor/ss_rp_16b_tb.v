`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:49:35 10/31/2017
// Design Name:   ss_rp_16b
// Module Name:   C:/Users/evardl/Documents/Classes/CSSE 232/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/ss_rp_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ss_rp_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ss_rp_16b_tb;

	// Inputs
	reg [15:0] add;
	reg [1:0] rp_src;
	reg reset;
	
	reg clk = 0;
	
	always
		#5 clk = ~clk;

	// Outputs
	wire [15:0] rp;

	// Instantiate the Unit Under Test (UUT)
	ss_rp_16b uut (
		.add(add), 
		.rp_src(rp_src), 
		.reset(reset), 
		.CLK(clk), 
		.rp(rp)
	);

	initial begin
		// Initialize Inputs
		add = 1;
		rp_src = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		repeat (3) begin
			#10;
			if (rp_src == 0 && rp == 1) $display("ADD 0 to RP: PASS");
			else if (rp_src == 1 && rp == 2) $display("ADD 1 to RP: PASS");
			else if (rp_src == 2 && rp == 0) $display("ADD -1 to RP: PASS");
			else $display("FAIL");
			
			rp_src = rp_src + 1;
		end

	end
      
endmodule

