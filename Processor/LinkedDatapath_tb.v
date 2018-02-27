`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:29:58 11/05/2017
// Design Name:   LinkedDatapath
// Module Name:   C:/Users/evardl/Documents/Classes/CSSE 232/2C-chanck-evardl-graziodj-hallbh-hilliara/Implementation/Processor/LinkedDatapath_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LinkedDatapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LinkedDatapath_tb;

	// Inputs
	reg [1:0] pc_src;
	reg [1:0] rp_inc;
	reg pc_enable;
	reg [1:0] mem_addr;
	reg mem_data;
	reg mem_write;
	reg ir_write;
	reg [2:0] tr_src;
	reg [1:0] dp_inc;
	reg reg_write;
	reg tr_write;
	reg [2:0] b_src;
	reg b_write;
	reg alu_src;
	reg [3:0] alu_op;
	reg reset;
	reg CLK = 0;
	reg mem_CLK = 1;
	
	always
		#10 CLK = ~CLK;
		
	always
		#5 mem_CLK = ~mem_CLK;

	// Outputs
	wire opcode;
	wire isZero;
	wire ovfl;

	// Instantiate the Unit Under Test (UUT)
	LinkedDatapath uut (
		.pc_src(pc_src), 
		.rp_inc(rp_inc), 
		.pc_enable(pc_enable), 
		.mem_addr(mem_addr), 
		.mem_data(mem_data), 
		.mem_write(mem_write), 
		.ir_write(ir_write), 
		.tr_src(tr_src), 
		.dp_inc(dp_inc), 
		.reg_write(reg_write), 
		.tr_write(tr_write), 
		.b_src(b_src), 
		.b_write(b_write), 
		.alu_src(alu_src), 
		.alu_op(alu_op), 
		.reset(reset), 
		.CLK(CLK),
		.mem_CLK(mem_CLK),
		.opcode(opcode), 
		.isZero(isZero), 
		.ovfl(ovfl)
	);

	initial begin
		// Initialize Inputs
		pc_src = 0;
		rp_inc = 0;
		pc_enable = 0;
		mem_addr = 0;
		mem_data = 0;
		mem_write = 0;
		ir_write = 0;
		tr_src = 0;
		dp_inc = 0;
		reg_write = 0;
		tr_write = 0;
		b_src = 0;
		b_write = 0;
		alu_src = 0;
		alu_op = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#110;
        
		// Add stimulus here
		
		// RESET
		reset = 1;
		#20;
		reset = 0;
		#20;
		
		// PUSH 1
		/*
		// FETCH
		mem_addr = 2'b00; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 1; tr_src = 0; 
		tr_write = 0; pc_src = 2'b00; pc_enable = 1; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		// DECODE
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 3'b000; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		// ODPP
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b01; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 0; b_write = 0; alu_op = 0;
		reset = 0;
		#20;
		
		// PUSH
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 1; ir_write = 0; tr_src = 3'b011; 
		tr_write = 1; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		// PUSH 2
		
		// FETCH
		mem_addr = 2'b00; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 1; tr_src = 0; 
		tr_write = 0; pc_src = 2'b00; pc_enable = 1; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		// DECODE
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 3'b000; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		// ODPP
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b01; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 0; b_write = 0; alu_op = 0;
		reset = 0;
		#20;
		
		// PUSH
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 1; ir_write = 0; tr_src = 3'b011; 
		tr_write = 1; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		// ADD 1 + 2
		
		// FETCH
		mem_addr = 2'b00; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 1; tr_src = 0; 
		tr_write = 0; pc_src = 2'b00; pc_enable = 1; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		// DECODE
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 3'b000; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		// ADD
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 3'b001; 
		tr_write = 1; pc_src = 0; pc_enable = 0; alu_src = 1; b_src = 0; b_write = 1; alu_op = 4'b0001;
		reset = 0;
		#20;
		
		// Setting Controls Back to 0
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#20;
		
		/*
		// PUSH 3
		
		// FETCH
		mem_addr = 2'b00; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 1; tr_src = 0; 
		tr_write = 0; pc_src = 2'b00; pc_enable = 1; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#10;
		
		// DECODE
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 3'b000; b_write = 1; alu_op = 0;
		reset = 0;
		#10;
		
		// ODPP
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b01; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 0; b_write = 0; alu_op = 0;
		reset = 0;
		#10;
		
		// PUSH
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 1; ir_write = 0; tr_src = 3'b011; 
		tr_write = 1; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#10;
		
		
		// ADD 3 + 3
		
		// FETCH
		mem_addr = 2'b00; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 1; tr_src = 0; 
		tr_write = 0; pc_src = 2'b00; pc_enable = 1; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#10;
		
		// DECODE
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 3'b000; b_write = 1; alu_op = 0;
		reset = 0;
		#10;
		
		// ADD
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 3'b001; 
		tr_write = 1; pc_src = 0; pc_enable = 0; alu_src = 1; b_src = 0; b_write = 1; alu_op = 4'b0001;
		reset = 0;
		#10;
		
		
		// Setting Controls Back to 0
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_enable = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;
		#10;
		*/
		

	end
      
endmodule

