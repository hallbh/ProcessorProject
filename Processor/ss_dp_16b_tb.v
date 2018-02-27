`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:21:13 10/31/2017
// Design Name:   ss_dp_16b
// Module Name:   C:/Users/evardl/Documents/Classes/CSSE 232/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/ss_dp_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ss_dp_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ss_dp_16b_tb;

	// Inputs
	reg [15:0] add;
	reg [1:0] dp_src;
	reg reset;
	
	reg clk = 0;
	
	always
		#5 clk = ~clk;

	// Outputs
	wire [15:0] dp;

	// Instantiate the Unit Under Test (UUT)
	ss_dp_16b uut (
		.add(add), 
		.dp_src(dp_src), 
		.reset(reset), 
		.CLK(clk), 
		.dp(dp)
	);

	initial begin
		// Initialize Inputs
		add = 1;
		dp_src = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		repeat (3) begin
			#10;
			if (dp_src == 0 && dp == 1) $display("ADD 0 to DP: PASS");
			else if (dp_src == 1 && dp == 2) $display("ADD 1 to DP: PASS");
			else if (dp_src == 2 && dp == 0) $display("ADD -1 to DP: PASS");
			else $display("FAIL");
			
			dp_src = dp_src + 1;
		end

	end
      
endmodule

