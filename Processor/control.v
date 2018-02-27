`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:46 10/29/2017 
// Design Name: 
// Module Name:    control 
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
module control(
   input [7:0] opcode,
	input CLK,
	output reg [1:0] mem_addr,
	output reg mem_data,
	output reg mem_write,
	output reg [1:0] dp_inc,
	output reg [1:0] rp_inc,
	output reg reg_write,
	output reg ir_write,
	output reg [2:0] tr_src,
	output reg tr_write,
	output reg [1:0] pc_src,
	output reg pc_write,
	output reg jump,
	output reg jump_cond,
	output reg alu_src,
	output reg [2:0] b_src,
	output reg b_write,
	output reg [3:0] alu_op,
	output reg reset
   );
	
	reg [4:0] state;	//State of the control unit
	
	initial begin
		state <= 0;
	end
	
	//Change state on next cycle
	always @(posedge CLK) begin
		case (state)
			0: state <= 1;	//Reset state
			1: state <= 2;	//Inst Fetch -> Decode
			2: begin //Decode ->
					if (opcode == 8'h00) state <= 1;	//No opcode, go back to the instruction fetch
					else if (opcode[7:4] == 4'h0) state <= 3;		//add, sub, and, or, slt, band, bor, bnor, bxor
					else if (opcode[7:4] == 4'hC) state <= 12;	//jeq
					else if (opcode[7:4] == 4'hD) state <= 12;	//jneq
					else if (opcode[7:4] == 4'hE) state <= 12;	//j
					else if (opcode[7:4] == 4'hF) state <= 13;	//call
					else begin
						case (opcode)
							8'h11: state <= 8;	//load
							8'h12: state <= 9;	//store
							8'h13: state <= 13; 	//tor
							8'h14: state <= 5; 	//fromr
							8'h21: state <= 4; 	//burn
							8'h22: state <= 6; 	//dup
							8'h23: state <= 6; 	//over
							8'h24: state <= 7; 	//swap
							8'h31: state <= 10; 	//ja
							8'h80: state <= 6; 	//push
							8'h81: state <= 6; 	//pushu
							8'h8A: state <= 11;	//sll
							8'h8B: state <= 11; 	//srl
							8'h8C: state <= 11; 	//sra
						endcase
					end
				end
			5: state <= 14;	//fromr (first state) -> fromr, over (final state)
			6: begin	//over, dup, push, pushu (first state) ->
					case (opcode)
						8'h22: state <= 15; 	//dup
						8'h23: state <= 14; 	//over
						8'h80: state <= 16; 	//push
						8'h81: state <= 17; 	//pushu
					endcase
				end
			8: state <= 18;	//load (first stage) -> (final state)
			9: state <= 19;	//store (first state) -> (final state)
			11: state <= 20;	//sll, srl, sra (first state) -> (final state)
			12: state <= 21;	//jeq, jneq, j (first state) -> (second state)
			13: begin	//call, tor (first state) ->
					if (opcode[7:4] == 4'hF) state <= 22;	//call
					else state <= 23;	//tor
				 end
			21: begin	//jeq, jneq, j (second state) ->
					if (opcode[7:4] == 4'hC) state <= 24;	//jeq
					else if (opcode[7:4] == 4'hD) state <= 25;	//jneq
					else if (opcode[7:4] == 4'hE) state <= 26;	//j
				 end
			22: state <= 26;	//call (second state) -> j, call (final state)
			default: state <= 1;	//instruction (final state) -> Inst Fetch
		endcase
	end
	
	//Change outputs based on state
	always @(state) begin
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		reset = 0;	
		case (state)
		0: begin //Reset state
				mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
				tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
				reset = 1;	
			end
		1: begin	//Start state (Instruction Fetch)
			mem_addr = 2'b00; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 1; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 1; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		2: begin	//Second state (Instruction Decode)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 01; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 3'b000; b_write = 1; alu_op = 0;
			reset = 0;
			end
		3: begin	//add, sub, and, or, slt, band, bor, bnor, bxor (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 3'b001; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 1; b_src = 0; b_write = 1; alu_op = opcode[3:0];
			reset = 0;
			end
		4: begin	//burn (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		5: begin	//fromr (First State)
			mem_addr = 2'b10; mem_data = 0; mem_write = 0; dp_inc = 2'b01; rp_inc = 2'b01; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 3'b001; b_write = 1; alu_op = 0;
			reset = 0;
			end
		6: begin	//over, dup, push, pushu (First State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b01; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 0; alu_op = 0;
			reset = 0;
			end
		7: begin	//swap (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 1; ir_write = 0; tr_src = 3'b000; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		8: begin	//load (First State)
			mem_addr = 2'b11; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 3'b001; b_write = 1; alu_op = 0;
			reset = 0;
			end
		9: begin	//store (First State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 0; alu_op = 0;
			reset = 0;
			end
		10: begin	//ja (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 3'b000; 
			tr_write = 1; pc_src = 2'b10; pc_write = 1; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		11: begin	//sll, srl, sra (First State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 3'b011; b_write = 1; alu_op = 0;
			reset = 0;
			end
		12: begin //jeq, jneq, j (First State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 3'b100; b_write = 1; alu_op = 0;
			reset = 0;
			end
		13: begin //call, tor (First State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 2'b10; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 3'b100; b_write = 1; alu_op = 0;
			reset = 0;
			end
		14: begin	//fromr, over (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 1; ir_write = 0; tr_src = 3'b000; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		15: begin //dup (Final State)	
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 1; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		16: begin //push (Final State)	
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 1; ir_write = 0; tr_src = 3'b011; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		17: begin //pushu (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 1; ir_write = 0; tr_src = 3'b010; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		18: begin //load (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 3'b000; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		19: begin //store (Final State)
			mem_addr = 2'b01; mem_data = 0; mem_write = 1; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 3'b100; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		20: begin //sll, srl, sra (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 3'b001; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = opcode[3:0];
			reset = 0;
			end
		21: begin //jeq, jneq, j (Second State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 3'b000; b_src = 0; b_write = 1; alu_op = 4'b0001;
			reset = 0;
			end
		22: begin //call (Second State)
			mem_addr = 2'b10; mem_data = 0; mem_write = 1; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 4'b0001;
			reset = 0;
			end
		23: begin //tor (Final State)
			mem_addr = 2'b10; mem_data = 1; mem_write = 1; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 3'b100; 
			tr_write = 1; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		24: begin //jeq (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 2'b01; pc_write = 0; jump = 1; jump_cond = 1; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		25: begin //jneq (Final State)
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 2'b10; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 2'b01; pc_write = 0; jump = 1; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		26: begin //j, call (Final State)	
			mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
			tr_write = 0; pc_src = 2'b01; pc_write = 1; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
			reset = 0;
			end
		default: begin //Any other state can be treated as a reset state
				mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
				tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
				reset = 1;	
			end
		endcase
	end

endmodule
