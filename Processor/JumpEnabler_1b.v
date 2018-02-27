`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:22:08 11/06/2017 
// Design Name: 
// Module Name:    JumpEnabler_1b 
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
module JumpEnabler_1b(
	input pc_write,
	input jump,
	input jump_cond,
	input isZero,
	output pc_enable
   );
	
	assign pc_enable = (pc_write || (jump && (jump_cond ~^ isZero)));

endmodule
