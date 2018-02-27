`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:12 10/29/2017 
// Design Name: 
// Module Name:    alu_16b 
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
module alu_16b(
   input [15:0] a,
   input [15:0] b,
   input [3:0] op,
   output reg [15:0] r,
   output reg zero,
   output reg ovfl
   );
	
	always @(*) begin
		ovfl = 0;
		case (op)
			4'b0001: begin
				//			       ADDITION SIGN BITS
				//    num1sign num2sign sumsign
				//   ---------------------------
				//        0 0 0
				// *OVER* 0 0 1 (adding two positives should be positive)
				//        0 1 0
				//        0 1 1
				//        1 0 0
				//        1 0 1
				// *OVER* 1 1 0 (adding two negatives should be negative)
				//        1 1 1
				r = b + a;			   //ADD
				if (a[15] == b[15] && r[15] != a[15]) ovfl = 1;
			end
			4'b0010: begin
				//						SUBTRACTION SIGN BITS
				//		 num1sign num2sign sumsign
				//	  ---------------------------
				//		  	 0 0 0
				//			 0 0 1
				//			 0 1 0
				//	*OVER* 0 1 1 (subtracting a negative is the same as adding a positive)
				//	*OVER* 1 0 0 (subtracting a positive is the same as adding a negative)
				//			 1 0 1
				//			 1 1 0
				//			 1 1 1
				r = b - a;				//SUB
				if (a[15] == 0 && b[15] == 1 && r[15] == 1) ovfl = 1;
				if (a[15] == 1 && b[15] == 0 && r[15] == 0) ovfl = 1;
			end
			4'b0011: r = (a && b);	//Logical AND
			4'b0100: r = (a || b);	//Logical OR
			4'b0101: r = ($signed(b) < $signed(a));	//Set Less Than
			4'b0110: r = (a & b);	//Bitwise AND
			4'b0111: r = (a | b); 	//Bitwise OR
			4'b1000: r = ~(a | b);	//Bitwise NOR
			4'b1001: r = (a ^ b);	//Bitwise XOR
			4'b1010: r = (a << b);	//Shift left
			4'b1011: r = (a >> b);	//Shift right logical
			4'b1100: r = ($signed(a) >>> b);	//Shift right arithmetic
		endcase
		zero = (r == 0);
	end
	
endmodule
