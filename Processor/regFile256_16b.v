`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:12 10/29/2017 
// Design Name: 
// Module Name:    regFile256_16b 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module regFile256_16b(
   input [7:0] address,
   input [15:0] writeData,
   input write,
	output [15:0] readData,
   input reset,
	input CLK
   );
	 
	reg [15:0] regfile[255:0];
	
	assign readData = regfile[address];
	
	integer i;
	always @(posedge CLK) begin
		if (reset) begin	//Reset the entire register file
			for (i = 0; i < 255; i = i + 1) begin
				regfile[i] <= 0;
			end
		end else if (write) regfile[address] <= writeData;
	end

endmodule
