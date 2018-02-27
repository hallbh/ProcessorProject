`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:35:39 11/01/2017
// Design Name:   DataStackSystem
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/DataStackSystem_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DataStackSystem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DataStackSystem_tb;

	// Inputs
	reg [15:0] tr_src_a;
	reg [15:0] tr_src_b;
	reg [15:0] tr_src_c;
	reg [15:0] tr_src_d;
	reg [2:0] tr_src;
	reg tr_write;
	reg [1:0] dp_inc;
	reg reg_write;
	reg reset;
	reg CLK = 0;
	
	always
		#5 CLK = ~CLK;

	// Outputs
	wire [15:0] TR;
	wire [15:0] read_data;

	// Instantiate the Unit Under Test (UUT)
	DataStackSystem uut (
		.tr_src_a(tr_src_a), 
		.tr_src_b(tr_src_b), 
		.tr_src_c(tr_src_c), 
		.tr_src_d(tr_src_d),  
		.tr_src(tr_src), 
		.tr_write(tr_write), 
		.dp_inc(dp_inc), 
		.reg_write(reg_write), 
		.reset(reset), 
		.CLK(CLK), 
		.TR(TR), 
		.read_data(read_data)
	);

	initial begin
		// Initialize Inputs
		tr_src_a = 1;
		tr_src_b = 2;
		tr_src_c = 3;
		tr_src_d = 4;
		tr_src = 0;
		tr_write = 0;
		dp_inc = 0;
		reg_write = 0;
		reset = 0;

		// Wait 105 ns for global reset to finish
		#105;
        
		// Add stimulus here
		reset = 1;
		#10;
		reset = 0;
		
		//Write 4 to TR register
		tr_src = 3;
		tr_write = 1;
		#10;
		
		if (TR == 4) $display("Write 4 to TR: PASS");
		else $display("Write 4 to TR: FAIL");
		
		//Write 2 to TR, which pushed 5 into the register file
		tr_src = 1;
		reg_write = 1;
		#10;
		
		reg_write = 0;
		tr_write = 0;
		
		if (TR == 2 && read_data == 4) $display("Write 2 to TR: PASS");
		else $display("Write 2 to TR: FAIL");
		
		//Increment DP to put TR into the register file
		dp_inc = 1;
		#10;
		
		dp_inc = 0;
		#10;
		
		reg_write = 1;
		tr_src = 2;
		tr_write = 1;
		#10;
		
		reg_write = 0;
		tr_write = 0;
		
		if (TR == 3 && read_data == 2) $display("Write 3 to TR: PASS");
		else $display("Write 3 to TR: FAIL");

	end
      
endmodule

