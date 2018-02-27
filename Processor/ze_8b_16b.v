`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:54:59 10/29/2017 
// Design Name: 
// Module Name:    ze_8b_16b 
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
module ze_8b_16b(
   input [7:0] in,
   output [15:0] out
   );

	assign out = {8'h00, in};

endmodule
