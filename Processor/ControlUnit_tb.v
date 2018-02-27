`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:51:57 11/05/2017
// Design Name:   ControlUnit
// Module Name:   C:/Users/hilliara/Documents/School/CSSE/CSSE232/Processor/Repo/Implementation/Processor/ControlUnit_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ControlUnit_tb;

	// Inputs
	reg [7:0] opcode;
	reg reset;
	
	reg CLK = 0;
	always
		#5 CLK = ~CLK;

	// Outputs
	wire [1:0] mem_addr;
	wire mem_data;
	wire mem_write;
	wire [1:0] dp_inc;
	wire [1:0] rp_inc;
	wire reg_write;
	wire ir_write;
	wire [2:0] tr_src;
	wire tr_write;
	wire [1:0] pc_src;
	wire pc_write;
	wire jump;
	wire jump_cond;
	wire alu_src;
	wire [2:0] b_src;
	wire b_write;
	wire [3:0] alu_op;
	wire rst;

	// Instantiate the Unit Under Test (UUT)
	ControlUnit uut (
		.opcode(opcode), 
		.reset(reset), 
		.CLK(CLK), 
		.mem_addr(mem_addr), 
		.mem_data(mem_data), 
		.mem_write(mem_write), 
		.dp_inc(dp_inc), 
		.rp_inc(rp_inc), 
		.reg_write(reg_write), 
		.ir_write(ir_write), 
		.tr_src(tr_src), 
		.tr_write(tr_write), 
		.pc_src(pc_src), 
		.pc_write(pc_write), 
		.jump(jump), 
		.jump_cond(jump_cond), 
		.alu_src(alu_src), 
		.b_src(b_src), 
		.b_write(b_write), 
		.alu_op(alu_op), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		opcode = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 1;
		#10;
		reset = 0;
		
		// ADD
		#10;
		
		// ADD C1
		opcode = 8'h01;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("ADD C1: PASS");
		else $display("ADD C1: FAIL");
		
		#10;
		
		// ADD C2
		if (b_src == 3'b000) $display("ADD C2: PASS");
		else $display("ADD C2: FAIL");
		
		#10;
		
		// ADD C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b0001 && tr_src == 3'b001 && tr_write == 1'b1) $display("ADD C3: PASS");
		else $display("ADD C3: FAIL");
		
		// SUB
		#10;
		
		// SUB C1
		opcode = 8'h02;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("SUB C1: PASS");
		else $display("SUB C1: FAIL");
		
		#10;
		
		// SUB C2
		if (b_src == 3'b000) $display("SUB C2: PASS");
		else $display("SUB C2: FAIL");
		
		#10;
		
		// SUB C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b0010 && tr_src == 3'b001 && tr_write == 1'b1) $display("SUB C3: PASS");
		else $display("SUB C3: FAIL");
		
		// AND
		#10;
		
		// AND C1
		opcode = 8'h03;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("AND C1: PASS");
		else $display("AND C1: FAIL");
		
		#10;
		
		// AND C2
		if (b_src == 3'b000) $display("AND C2: PASS");
		else $display("AND C2: FAIL");
		
		#10;
		
		// AND C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b0011 && tr_src == 3'b001 && tr_write == 1'b1) $display("AND C3: PASS");
		else $display("AND C3: FAIL");
		
		// OR
		#10;
		
		// OR C1
		opcode = 8'h04;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("OR C1: PASS");
		else $display("OR C1: FAIL");
		
		#10;
		
		// OR C2
		if (b_src == 3'b000) $display("OR C2: PASS");
		else $display("OR C2: FAIL");
		
		#10;
		
		// OR C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b0100 && tr_src == 3'b001 && tr_write == 1'b1) $display("OR C3: PASS");
		else $display("OR C3: FAIL");
		
		// SLT
		#10;
		
		// SLT C1
		opcode = 8'h05;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("SLT C1: PASS");
		else $display("SLT C1: FAIL");
		
		#10;
		
		//SLT C2
		if (b_src == 3'b000) $display("SLT C2: PASS");
		else $display("SLT C2: FAIL");
		
		#10;
		
		// SLT C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b0101 && tr_src == 3'b001 && tr_write == 1'b1) $display("SLT C3: PASS");
		else $display("SLT C3: FAIL");
		
		// BAND
		#10;
		
		// BAND C1
		opcode = 8'h06;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("BAND C1: PASS");
		else $display("BAND C1: FAIL");
		
		#10;
		
		//BAND C2
		if (b_src == 3'b000) $display("BAND C2: PASS");
		else $display("BAND C2: FAIL");
		
		#10;
		
		// BAND C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b0110 && tr_src == 3'b001 && tr_write == 1'b1) $display("BAND C3: PASS");
		else $display("BAND C3: FAIL");
		
		// BOR
		#10;
		
		// BOR C1
		opcode = 8'h07;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("BOR C1: PASS");
		else $display("BOR C1: FAIL");
		
		#10;
		
		//BOR C2
		if (b_src == 3'b000) $display("BOR C2: PASS");
		else $display("BOR C2: FAIL");
		
		#10;
		
		// BOR C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b0111 && tr_src == 3'b001 && tr_write == 1'b1) $display("BOR C3: PASS");
		else $display("BOR C3: FAIL");
		
		// BNOR
		#10;
		
		// BNOR C1
		opcode = 8'h08;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("BNOR C1: PASS");
		else $display("BNOR C1: FAIL");
		
		#10;
		
		//BNOR C2
		if (b_src == 3'b000) $display("BNOR C2: PASS");
		else $display("BNOR C2: FAIL");
		
		#10;
		
		// BNOR C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b1000 && tr_src == 3'b001 && tr_write == 1'b1) $display("BNOR C3: PASS");
		else $display("BNOR C3: FAIL");
		
		// BXOR
		#10;
		
		// BXOR C1
		opcode = 8'h09;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("BXOR C1: PASS");
		else $display("BXOR C1: FAIL");
		
		#10;
		
		//BXOR C2
		if (b_src == 3'b000) $display("BXOR C2: PASS");
		else $display("BXOR C2: FAIL");
		
		#10;
		
		// BXOR C3
		if (dp_inc == 2'b10 && alu_src == 1'b1 && alu_op == 4'b1001 && tr_src == 3'b001 && tr_write == 1'b1) $display("BXOR C3: PASS");
		else $display("BXOR C3: FAIL");
		
		// LOAD
		#10;
		
		// LOAD C1
		opcode = 8'h11;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("LOAD C1: PASS");
		else $display("LOAD C1: FAIL");
		
		#10;
		
		//LOAD C2
		if (b_src == 3'b000) $display("LOAD C2: PASS");
		else $display("LOAD C2: FAIL");
		
		#10;
		
		// LOAD C3
		if (mem_addr == 2'b11 && b_src == 3'b001) $display("LOAD C3: PASS");
		else $display("LOAD C3: FAIL");
		
		#10;
		
		// LOAD C4
		if (tr_src == 3'b000 && tr_write == 1'b1) $display("LOAD C4: PASS");
		else $display("LOAD C4: FAIL");
		
		// STORE
		#10;
		
		// STORE C1
		opcode = 8'h12;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("STORE C1: PASS");
		else $display("STORE C1: FAIL");
		
		#10;
		
		//STORE C2
		if (b_src == 3'b000) $display("STORE C2: PASS");
		else $display("STORE C2: FAIL");
		
		#10;
		
		// STORE C3
		if (dp_inc == 2'b10 && b_write == 1'b0) $display("STORE C3: PASS");
		else $display("STORE C3: FAIL");
		
		#10;
		
		// STORE C4
		if (mem_write == 1'b1 && mem_addr == 2'b01 && tr_src == 3'b100 && tr_write == 1'b1 && dp_inc == 2'b10) $display("STORE C4: PASS");
		else $display("STORE C4: FAIL");
		
		// TOR
		#10;
		
		// TOR C1
		opcode = 8'h13;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("TOR C1: PASS");
		else $display("TOR C1: FAIL");
		
		#10;
		
		//TOR C2
		if (b_src == 3'b000) $display("TOR C2: PASS");
		else $display("TOR C2: FAIL");
		
		#10;
		
		// TOR C3
		if (rp_inc == 2'b10 && b_src == 3'b100) $display("TOR C3: PASS");
		else $display("TOR C3: FAIL");
		
		#10;
		
		// TOR C4
		if (mem_write == 1'b1 && mem_addr == 2'b10 && tr_src == 3'b100 && tr_write == 1'b1 && mem_data == 1'b1) $display("TOR C4: PASS");
		else $display("TOR C4: FAIL");
		
		// FROMR
		#10;
		
		// FROMR C1
		opcode = 8'h14;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("FROMR C1: PASS");
		else $display("FROMR C1: FAIL");
		
		#10;
		
		// FROMR C2
		if (b_src == 3'b000) $display("FROMR C2: PASS");
		else $display("FROMR C2: FAIL");
		
		#10;
		
		// FROMR C3
		if (b_src == 3'b001 && mem_addr == 2'b10 && rp_inc == 2'b01 && dp_inc == 2'b01) $display("FROMR C3: PASS");
		else $display("FROMR C3: FAIL");
		
		#10;
		
		// FROMR C4
		if (reg_write == 1'b1 && tr_src == 3'b000 && tr_write == 1'b1) $display("FROMR C4: PASS");
		else $display("FROMR C4: FAIL");
		
		// BURN
		#10;
		
		// BURN C1
		opcode = 8'h21;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("BURN C1: PASS");
		else $display("BURN C1: FAIL");
		
		#10;
		
		// BURN C2
		if (b_src == 3'b000) $display("BURN C2: PASS");
		else $display("BURN C2: FAIL");
		
		#10;
		
		// BURN C3
		if (tr_src == 3'b000 && dp_inc == 2'b10) $display("BURN C3: PASS");
		else $display("BURN C3: FAIL");
		
		// DUP
		#10;
		
		// DUP C1
		opcode = 8'h22;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("DUP C1: PASS");
		else $display("DUP C1: FAIL");
		
		#10;
		
		// DUP C2
		if (b_src == 3'b000) $display("DUP C2: PASS");
		else $display("DUP C2: FAIL");
		
		#10;
		
		// DUP C3
		if (dp_inc == 2'b01 && b_write == 1'b0) $display("DUP C3: PASS");
		else $display("DUP C3: FAIL");
		
		#10;
		
		// DUP C4
		if (reg_write == 1'b1) $display("DUP C4: PASS");
		else $display("DUP C4: FAIL");
		
		// OVER
		#10;
		
		// OVER C1
		opcode = 8'h23;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("OVER C1: PASS");
		else $display("OVER C1: FAIL");
		
		#10;
		
		// OVER C2
		if (b_src == 3'b000) $display("OVER C2: PASS");
		else $display("OVER C2: FAIL");
		
		#10;
		
		// OVER C3
		if (dp_inc == 2'b01 && b_write == 1'b0) $display("OVER C3: PASS");
		else $display("OVER C3: FAIL");
		
		#10;
		
		// OVER C4
		if (reg_write == 1'b1 && tr_src == 3'b000 && tr_write == 1'b1) $display("OVER C4: PASS");
		else $display("OVER C4: FAIL");
		
		// SWAP
		#10;
		
		// SWAP C1
		opcode = 8'h24;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("SWAP C1: PASS");
		else $display("SWAP C1: FAIL");
		
		#10;
		
		// SWAP C2
		if (b_src == 3'b000) $display("SWAP C2: PASS");
		else $display("SWAP C2: FAIL");
		
		#10;
		
		// SWAP C3
		if (tr_src == 3'b000 && tr_write == 1'b1 && reg_write == 1'b1) $display("SWAP C3: PASS");
		else $display("SWAP C3: FAIL");
		
		// JA
		#10;
		
		// JA C1
		opcode = 8'h31;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("JA C1: PASS");
		else $display("JA C1: FAIL");
		
		#10;
		
		// JA C2
		if (b_src == 3'b000) $display("JA C2: PASS");
		else $display("JA C2: FAIL");
		
		#10;
		
		// JA C3
		if (pc_write == 1'b1 && pc_src == 2'b10 && tr_src == 3'b000 && tr_write == 1'b1 && dp_inc == 2'b10) $display("JA C3: PASS");
		else $display("JA C3: FAIL");
		
		// PUSH
		#10;
		
		// PUSH C1
		opcode = 8'h80;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("PUSH C1: PASS");
		else $display("PUSH C1: FAIL");
		
		#10;
		
		// PUSH C2
		if (b_src == 3'b000) $display("PUSH C2: PASS");
		else $display("PUSH C2: FAIL");
		
		#10;
		
		// PUSH C3
		if (dp_inc == 2'b01 && b_write == 1'b0) $display("PUSH C3: PASS");
		else $display("PUSH C3: FAIL");
		
		#10;
		
		// PUSH C4
		if (reg_write == 1'b1 && tr_write == 1'b1 && tr_src == 2'b11) $display("PUSH C4: PASS");
		else $display("PUSH C4: FAIL");
		
		// PUSHU
		#10;
		
		// PUSHU C1
		opcode = 8'h81;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("PUSHU C1: PASS");
		else $display("PUSHU C1: FAIL");
		
		#10;
		
		// PUSHU C2
		if (b_src == 3'b000) $display("PUSHU C2: PASS");
		else $display("PUSHU C2: FAIL");
		
		#10;
		
		// PUSHU C3
		if (dp_inc == 2'b01 && b_write == 1'b0) $display("PUSHU C3: PASS");
		else $display("PUSHU C3: FAIL");
		
		#10;
		
		// PUSHU C4
		if (reg_write == 1'b1 && tr_src == 2'b10 && tr_write == 1'b1) $display("PUSHU C4: PASS");
		else $display("PUSHU C4: FAIL");
		
		// SLL
		#10;
		
		// SLL C1
		opcode = 8'h8A;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("SLL C1: PASS");
		else $display("SLL C1: FAIL");
		
		#10;
		
		// SLL C2
		if (b_src == 3'b000) $display("SLL C2: PASS");
		else $display("SLL C2: FAIL");
		
		#10;
		
		// SLL C3
		if (b_src == 3'b011) $display("SLL C3: PASS");
		else $display("SLL C3: FAIL");
		
		#10;
		
		// SLL C4
		if (tr_src == 3'b001 && tr_write == 1'b1 && alu_op == 4'b1010) $display("SLL C4: PASS");
		else $display("SLL C4: FAIL");
		
		// SRL
		#10;
		
		// SRL C1
		opcode = 8'h8B;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("SRL C1: PASS");
		else $display("SRL C1: FAIL");
		
		#10;
		
		// SRL C2
		if (b_src == 3'b000) $display("SRL C2: PASS");
		else $display("SRL C2: FAIL");
		
		#10;
		
		// SRL C3
		if (b_src == 3'b011) $display("SRL C3: PASS");
		else $display("SRL C3: FAIL");
		
		#10;
		
		// SRL C4
		if (tr_src == 3'b001 && tr_write == 1'b1 && alu_op == 4'b1011) $display("SRL C4: PASS");
		else $display("SRL C4: FAIL");
		
		// SRA
		#10;
		
		// SRA C1
		opcode = 8'h8C;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("SRA C1: PASS");
		else $display("SRA C1: FAIL");
		
		#10;
		
		// SRA C2
		if (b_src == 3'b000) $display("SRA C2: PASS");
		else $display("SRA C2: FAIL");
		
		#10;
		
		// SRA C3
		if (b_src == 3'b011) $display("SRA C3: PASS");
		else $display("SRA C3: FAIL");
		
		#10;
		
		// SRA C4
		if (tr_src == 3'b001 && tr_write == 1'b1 && alu_op == 4'b1100) $display("SRA C4: PASS");
		else $display("SRA C4: FAIL");
		
		// JEQ
		#10;
		
		// JEQ C1
		opcode = 8'hC0;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("JEQ C1: PASS");
		else $display("JEQ C1: FAIL");
		
		#10;
		
		// JEQ C2
		if (b_src == 3'b000) $display("JEQ C2: PASS");
		else $display("JEQ C2: FAIL");
		
		#10;
		
		// JEQ C3
		if (b_src == 3'b100) $display("JEQ C3: PASS");
		else $display("JEQ C3: FAIL");
		
		#10;
		
		// JEQ C4
		if (alu_op == 4'b0001 && alu_src == 0) $display("JEQ C4: PASS");
		else $display("JEQ C4: FAIL");
		
		#10;
		
		// JEQ C5
		if (dp_inc == 2'b10 && jump_cond == 1'b1 && jump == 1'b1 && pc_src == 2'b01) $display("JEQ C5: PASS");
		else $display("JEQ C5: FAIL");
		
		// JNEQ
		#10;
		
		// JNEQ C1
		opcode = 8'hD0;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("JNEQ C1: PASS");
		else $display("JNEQ C1: FAIL");
		
		#10;
		
		// JNEQ C2
		if (b_src == 3'b000) $display("JNEQ C2: PASS");
		else $display("JNEQ C2: FAIL");
		
		#10;
		
		// JNEQ C3
		if (b_src == 3'b100) $display("JNEQ C3: PASS");
		else $display("JNEQ C3: FAIL");
		
		#10;
		
		// JNEQ C4
		if (alu_op == 4'b0001 && alu_src == 0) $display("JNEQ C4: PASS");
		else $display("JNEQ C4: FAIL");
		
		#10;
		
		// JNEQ C5
		if (dp_inc == 2'b10 && jump_cond == 1'b0 && jump == 1'b1 && pc_src == 2'b01) $display("JNEQ C5: PASS");
		else $display("JNEQ C5: FAIL");
		
		// JNEQ
		#10;
		
		// J C1
		opcode = 8'hE0;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("J C1: PASS");
		else $display("J C1: FAIL");
		
		#10;
		
		// J C2
		if (b_src == 3'b000) $display("J C2: PASS");
		else $display("J C2: FAIL");
		
		#10;
		
		// J C3
		if (b_src == 3'b100) $display("J C3: PASS");
		else $display("J C3: FAIL");
		
		#10;
		
		// J C4
		if (alu_op == 4'b0001 && alu_src == 0) $display("J C4: PASS");
		else $display("J C4: FAIL");
		
		#10;
		
		// J C5
		if (pc_src == 2'b01 && pc_write == 1'b1) $display("J C5: PASS");
		else $display("J C5: FAIL");
		
		// JNEQ
		#10;
		
		// CALL C1
		opcode = 8'hF0;
		if (ir_write == 1'b1 && mem_addr == 2'b00 && pc_write == 1'b1 && pc_src == 1'b0) $display("CALL C1: PASS");
		else $display("CALL C1: FAIL");
		
		#10;
		
		// CALL C2
		if (b_src == 3'b000) $display("CALL C2: PASS");
		else $display("CALL C2: FAIL");
		
		#10;
		
		// CALL C3
		if (rp_inc == 2'b10 && b_src == 3'b100) $display("CALL C3: PASS");
		else $display("CALL C3: FAIL");
		
		#10;
		
		// CALL C4
		if (mem_data == 1'b0 && mem_addr == 2'b10 && mem_write == 1'b1 && alu_op == 4'b0001) $display("CALL C4: PASS");
		else $display("CALL C4: FAIL");
		
		#10;
		
		// CALL C5
		if (pc_src == 2'b01 && pc_write == 1'b1) $display("CALL C5: PASS");
		else $display("CALL C5: FAIL");
	end
      
endmodule

