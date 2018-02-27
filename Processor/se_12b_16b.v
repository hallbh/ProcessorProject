`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:10 11/01/2017 
// Design Name: 
// Module Name:    se_12b_16b 
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
module se_12b_16b(
    input [11:0] in,
    output [15:0] out
    );
	 
	assign out = {{4{in[7]}}, in};
	 
endmodule
