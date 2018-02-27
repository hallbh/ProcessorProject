`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:00:51 10/31/2017
// Design Name:   ss_pc_16b
// Module Name:   C:/Users/evardl/Documents/Classes/CSSE 232/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/ss_pc_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ss_pc_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ss_pc_16b_tb;

	// Inputs
	reg [15:0] add;
	reg [15:0] b;
	reg pc_src;
	reg pc_write;
	reg reset;
	
	reg clk = 0;
	
	always
		#5 clk = ~clk;

	// Outputs
	wire [15:0] pc;

	// Instantiate the Unit Under Test (UUT)
	ss_pc_16b uut (
		.add(add), 
		.b(b), 
		.pc_src(pc_src), 
		.pc_write(pc_write), 
		.reset(reset), 
		.CLK(clk), 
		.pc(pc)
	);

	initial begin
		// Initialize Inputs
		add = 0;
		b = 15;
		pc_src = 0;
		pc_write = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		repeat (2) begin
			#10;
			if (pc_src == 0 && pc_write == 0 && pc == 0) $display("No change to PC: PASS");
			else if (pc_src == 1 && pc_write == 0 && pc == 0) $display("No change to PC: PASS");
			else $display("FAIL");
			
			pc_src = pc_src + 1;
		end
		
		pc_write = 1;
		pc_src = 0;
		
		repeat (2) begin
			#10;
			if (pc_src == 0 && pc == 1) $display("ADD 0 to DP: PASS");
			else if (pc_src == 1 && pc == 15) $display("ADD 1 to DP: PASS");
			else $display("FAIL");
			
			pc_src = pc_src + 1;
		end

	end
      
endmodule

