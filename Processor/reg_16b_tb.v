`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:57:36 10/29/2017
// Design Name:   reg_16b
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/reg_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: reg_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module reg_16b_tb;

	// Inputs
	reg [15:0] D;
	reg write;
	reg reset;
	reg clk = 0;
	reg [15:0] initVal;

	// Outputs
	wire [15:0] Q;

	// Instantiate the Unit Under Test (UUT)
	reg_16b uut (
		.D(D), 
		.write(write), 
		.reset(reset), 
		.CLK(clk), 
		.Q(Q),
		.initVal(initVal)
	);
	
	always
		#10 clk = ~clk;

	initial begin
		// Initialize Inputs
		D = 69;
		initVal <= 'hBEEF;
		write = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		//Write 69 to the register
		write = 1;
		#20; //Wait for clk to change
		
		//Disable write but try writing a new value
		write = 0;
		D = 420;
		#10;	//Wait for clk
		
		//Reset the register
		
		reset = 1;
		#10;	//Wait for clk		
		//Turn reset off and write to the register
		reset = 0;
		write = 1;
	end
      
endmodule

