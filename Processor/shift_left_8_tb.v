`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:38:21 11/08/2017
// Design Name:   eight_leftshift
// Module Name:   C:/Users/evardl/Documents/Classes/CSSE 232/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/shift_left_8_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: eight_leftshift
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module shift_left_8_tb;

	// Inputs
	reg [7:0] in;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	eight_leftshift uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		in = 8'h37;
		#10;
		if (out == 16'h3700) $display("Shift 16'h0037: PASS");
		else $display("Shift 16'0037: FAIL");
		
		in = 8'h15;
		#10;
		if (out == 16'h1500) $display("Shift 16'h0015: PASS");
		else $display("Shift 16'0015: FAIL");
		
		in = 8'hFF;
		#10;
		if (out == 16'hFF00) $display("Shift 16'h00FF: PASS");
		else $display("Shift 16'00FF: FAIL");

	end
      
endmodule

