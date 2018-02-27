`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:29:35 11/03/2017
// Design Name:   ALUSystem
// Module Name:   C:/Users/hallbh/Documents/Rose/CSSE/232 Computer Architecture/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/ALUSystem_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALUSystem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALUSystem_tb;

	// Inputs
	reg [15:0] ALUSrc_a; //PC
	reg [15:0] ALUSrc_b;	//TR
	reg [15:0] B;			//From B Mux
	reg alu_src;			//alu_src_1 on datapath
	reg [3:0] alu_op;		
	reg reset;				//
	reg CLK = 0;
	
	always begin
			CLK = ~CLK;
			#5;
	end

	// Outputs
	wire [15:0] R;
	wire [15:0] br;
	wire isZero;
	wire ovfl;

	// Instantiate the Unit Under Test (UUT)
	ALUSystem uut (
		.ALUSrc_a(ALUSrc_a), 
		.ALUSrc_b(ALUSrc_b), 
		.B(B), 
		.alu_src(alu_src), 
		.alu_op(alu_op), 
		.reset(reset), 
		.CLK(CLK), 
		.R(R), 
		.br(br), 
		.isZero(isZero), 
		.ovfl(ovfl)
	);

	initial begin
		// Initialize Inputs
		ALUSrc_a = 16'b0;
		ALUSrc_b = 16'b0;
		B = 16'b0;
		alu_src = 1'b0;
		alu_op = 4'b0000;
		reset = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add test, no overflow
		alu_op = 4'b0001;
		ALUSrc_a = 16'd1;
		ALUSrc_b = 16'd2;
		B = 16'd4;
		#5 //wait for var values
		if (R != 16'd5 && ovfl != 0) $display("Fail add without overflow");
		
		alu_src = 1'b1;
		#5
		if (R != 16'd6 && ovfl != 0) $display("Fail add without overflow");
		
		ALUSrc_b = 16'b0;
		#5
		if (R != 16'd4 && ovfl != 0) $display("Fail add without overflow");
		
		B = 16'b0;
		#5
		if (R != 0 && ovfl != 0 && isZero == 1) $display("Fail add without overflow zero text");
		
		// Add overflow test
		ALUSrc_b = 16'b0111111111111111;
		B = 16'b1;
		#5
		if (R != 16'b1000000000000000 && ovfl != 1) $display("Fail add with overflow");

		// Sub test, no overflow,
		alu_op = 4'b0010;
		ALUSrc_a = 16'd10;
		ALUSrc_b = 16'd6;
		B = 16'd4;
		alu_src = 1'b0;
		
		#5
		if (R != -16'd6 && ovfl != 0) $display("Fail sub without underflow");
		
		alu_src = 1'b1;
		#5
		if (R != -16'd4 && ovfl != 0) $display("Fail sub without underflow");
		// Sub overflow test
		// 0 1 1 >> Subtracting a negative
		ALUSrc_b = 16'b1000000000000000;
		B = 16'b0000000000000001;
		#5
		if (R != 16'b0000000011111111 && ovfl != 1 && isZero == 1) $display("Fail sub with underflow subtracting a negative");
		// 1 0 0 >> Subtracting a positive
		ALUSrc_b = 16'b100000000000000;
		B = 16'b1100000000000000;
		#5
		if (R != 16'b1000000000000000 && ovfl != 1 && isZero == 0) $display("Fail sub with underflow subtracting a positive"); 
		
		// Logical AND test
		alu_op = 4'b0011;
		ALUSrc_a = 16'b1010101010101010;
		ALUSrc_b = 16'b0;
		B = 16'b1111111111111111;
		alu_src = 1'b0;
		#5
		if (R != 16'b1) $display("Fail logical and");
		alu_src = 1'b1;
		#5
		if (R != 16'b0) $display("Fail logical and");
		
		// Logical OR test
		alu_op = 4'b0100;
		ALUSrc_a = 16'b1010101010101010;
		ALUSrc_b = 16'b0;
		B = 16'b1111111111111111;
		alu_src = 1'b0;
		#5
		if (R != 16'b1) $display("Fail logical or");
		alu_src = 1'b1;
		B = 16'b0;
		#5
		if (R != 16'b0) $display("Fail logical or");
		
		// SLT test
		alu_op = 4'b0101;
		ALUSrc_a = 16'b0111111111111111;//largest possible number
		ALUSrc_b = 16'b1000000000000000;//smallest possible number
		B = 16'b0;
		alu_src = 0;
		#5
		if (R != 1) $display("Fail SLT 1");
		alu_src = 1;
		#5
		if (R != 0) $display("Fail SLT 2");

		// Bitwise AND test
		alu_op = 4'b0110;
		ALUSrc_a = 16'b1010101010101010;
		ALUSrc_b = 16'b0101010101010101;
		B = 16'b1111111111111111;
		alu_src = 0;
		#5
		if (R != 16'b1010101010101010) $display("Fail bitwise and");
		alu_src = 1;
		#5
		if (R != 16'b0101010101010101) $display("Fail bitwise and");
		
		// Bitwise OR test
		alu_op = 4'b0111;
		ALUSrc_a = 0;
		ALUSrc_b = 16'b1111111111111111;
		B = 16'b1010101010101010;
		alu_src = 0;
		#5
		if (R != 16'b1010101010101010) $display("Fail bitwise or");
		alu_src = 1;
		#5
		if (R != 16'b1111111111111111) $display("Fail bitwise or");
		// Bitwise NOR test
		alu_op = 4'b1000;
		ALUSrc_a = 0;
		ALUSrc_b = 16'b1111111111111111;
		B = 16'b1010101010101010;
		alu_src = 0;
		#5
		if (R != 16'b010101010101010101) $display("Fail bitwise nor");
		alu_src = 1;
		#5
		if (R != 16'b0) $display("Fail bitwise nor");
		
		// Bitwise XOR test
		alu_op = 4'b1001;
		ALUSrc_a = 0;
		ALUSrc_b = 16'b1111111111111111;
		B = 16'b1010101010101010;
		alu_src = 0;
		#5
		if (R != 16'b1010101010101010) $display("Fail bitwise xor");
		alu_src = 1;
		#5
		if (R != 16'b0101010101010101) $display("Fail bitwise xor");
		
		// SLL test
		alu_op = 4'b1010;
		
		ALUSrc_b = 16'b0000111100001111;
		B = 16'd2;
		#5
		if (R != 16'b0011110000111100) $display("Fail sll");
		// SRL test
		alu_op = 4'b1011;
		
		ALUSrc_b = 16'b1111000011110000;
		B = 16'd2;
		#5
		if (R != 16'b0011110000111100) $display("Fail srl");
		
		// SRA test
		alu_op = 4'b1100;
		
		ALUSrc_b = 16'b1111000011110000;
		B = 16'd2;
		#5
		if (R != 16'b1111110000111100) $display("Fail sra");
	end
      
endmodule

