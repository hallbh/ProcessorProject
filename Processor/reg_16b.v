`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:45 10/29/2017 
// Design Name: 
// Module Name:    reg_16b 
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
module reg_16b(
   input [15:0] D,
	input [15:0] rstval,
	input write,
   input reset,
   input CLK,
   output reg [15:0] Q
   );

	always @(posedge CLK or posedge reset) begin	//Only change on positive clock edge
		if (reset) Q <= rstval;
		else if (write) Q <= D;
	end

endmodule
