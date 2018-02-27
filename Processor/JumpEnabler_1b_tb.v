`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:32:13 11/08/2017
// Design Name:   JumpEnabler_1b
// Module Name:   C:/Users/evardl/Documents/Classes/CSSE 232/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/JumpEnabler_1b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: JumpEnabler_1b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module JumpEnabler_1b_tb;

	// Inputs
	reg pc_write;
	reg jump;
	reg jump_cond;
	reg isZero;

	// Outputs
	wire pc_enable;

	// Instantiate the Unit Under Test (UUT)
	JumpEnabler_1b uut (
		.pc_write(pc_write), 
		.jump(jump), 
		.jump_cond(jump_cond), 
		.isZero(isZero), 
		.pc_enable(pc_enable)
	);

	initial begin
		// Initialize Inputs
		pc_write = 0;
		jump = 0;
		jump_cond = 0;
		isZero = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		pc_write = 1;
		jump = 0;
		jump_cond = 0;
		isZero = 0;
		#10;
		
		if (pc_enable == 1) $display("pc_write = 1: PASS");
		else $display("pc_write = 1: FAIL");
		
		pc_write = 1;
		jump = 0;
		jump_cond = 0;
		isZero = 0;
		#10;
		
		if (pc_enable == 1) $display("pc_write = 1: PASS");
		else $display("pc_write = 1: FAIL");
		
		pc_write = 0;
		jump = 1;
		jump_cond = 0;
		isZero = 0;
		#10;
		
		if (pc_enable == 1) $display("jump = 1: PASS");
		else $display("jump = 1: FAIL");
		
		pc_write = 0;
		jump = 0;
		jump_cond = 0;
		isZero = 0;
		#10;
		
		if (pc_enable == 0) $display("all = 0: PASS");
		else $display("all = 0: FAIL");
		
		pc_write = 0;
		jump = 1;
		jump_cond = 1;
		isZero = 0;
		#10;
		
		if (pc_enable == 0) $display("jump cond = 1: PASS");
		else $display("jump cond = 1: FAIL");
		
		pc_write = 0;
		jump = 1;
		jump_cond = 1;
		isZero = 1;
		#10;
		
		if (pc_enable == 1) $display("jumps = 1: PASS");
		else $display("jumps = 1: FAIL");

	end
      
endmodule

