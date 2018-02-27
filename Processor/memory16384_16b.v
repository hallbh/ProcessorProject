`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:51:55 11/01/2017
// Design Name:   memory16384_16b
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/memory16384_16b.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory16384_16b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module memory16384_16b;

	// Inputs
	reg clka = 0;
	reg rsta;
	reg [0:0] wea;
	reg [13:0] addra;
	reg [15:0] dina;
	
	always
		#10 clka = ~clka;

	// Outputs
	wire [15:0] douta;

	// Instantiate the Unit Under Test (UUT)
	memory16384_16b uut (
		.clka(clka), 
		.rsta(rsta), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta)
	);

	initial begin
		// Initialize Inputs
		rsta = 0;
		wea = 1;
		addra = 0;
		dina = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#20;
		addra = 2;
		dina = 420;
		#40;
		
		addra = 4;
		dina = 69;
		#40;
		
		wea = 0;
		addra = 2;
		if (douta == 420) $display("Write and Read 1: PASS");
		else $display("Write and Read 1: FAIL");
		#40;

	end
      
endmodule

