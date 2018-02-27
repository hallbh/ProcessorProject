`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:33:30 10/29/2017
// Design Name:   regFile256_16b
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/regFile256_16b_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regFile256_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regFile256_16b_tb;

	// Inputs
	reg [7:0] address;
	reg [15:0] writeData;
	reg write;
	reg reset;
	reg clk = 0;
	integer i;
	integer check;

	// Outputs
	wire [15:0] readData;

	// Instantiate the Unit Under Test (UUT)
	regFile256_16b uut (
		.address(address), 
		.writeData(writeData), 
		.write(write), 
		.readData(readData), 
		.reset(reset), 
		.CLK(clk)
	);
	
	always
		#5 clk = ~clk;

	initial begin
		// Initialize Inputs
		address = 0;
		writeData = 0;
		write = 0;
		reset = 0;
		i = 0;
		check = 0;
		

		// Wait 100 ns for global reset to finish
		#105;
		
		// Test writing to all registers
		
		address = 0;
		writeData = 1;
		write = 1;
		#10;
		
		repeat (255) begin
			address = address + 1;
			writeData = writeData + 1;
			#10;
		end
		
		address = 0;
		writeData = 1;
		write = 0;
		#10;
		
		repeat (255) begin
			if (readData != writeData) begin
				$display("Write to address %d: FAIL", address);
				check = 1;
			end
			address = address + 1;
			writeData = writeData + 1;
			#10;
		end
		if (check == 0) $display("Write to all: PASS");
		
		// Reset all registers
		check = 0;
		reset = 1;
		#10;
		reset = 0;
		
		repeat (256) begin
			if (readData != 0) begin
				$display("Reset: FAIL");
				check = 1;
			end
			address = address + 1;
			#10;
		end
		if (check == 0) $display("Reset: PASS");
		
		
		
		// Testing writing to specific registers
		write = 1;
		address = 69;
		writeData = 420;
		#10;	//Wait for positive clk before changing values
		
		//Test reading from register file
		write = 0;
		writeData = 25;
		#10;
		if (readData == 420) $display("Read and Write: PASS");
		
		//Write 25 to the the 4th address
		address = 4;
		write = 1;
	end
      
endmodule

