`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:30 11/04/2017 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(
	input [7:0] opcode,
	input reset,
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
	output reg rst,
	output reg out_write
   );

	reg [4:0] state;			//Current State for one-hot encoding
	reg [4:0] next_state;	//Next state for one-hot encoding
	
	parameter [4:0] 	reset_state = 5'd0,
							fetch = 5'd1,
							decode = 5'd2,
							alu = 5'd3,
							burn = 5'd4,
							fromr_1 = 5'd5,
							odpp = 5'd6,	//Over, dup, push, pushu
							swap = 5'd7,
							load_1 = 5'd8,
							store_1 = 5'd9,
							ja = 5'd10,
							shifts_1 = 5'd11,	//Sll, Srl, sra
							jumps_1 = 5'd12,	//jeq, jneq, j
							call_tor = 5'd13,	//Call and tor
							fromr_over = 5'd14,	//Final state for from and over
							dup = 5'd15,	//Final state for dup
							push = 5'd16,
							pushu = 5'd17,
							load = 5'd18,
							store = 5'd19,
							shifts = 5'd20,	//Final state for sll, srl, sra
							jumps_2 = 5'd21,//Second state for jumps
							call = 5'd22,
							tor = 5'd23,
							jeq = 5'd24,
							jneq = 5'd25,
							j_call = 5'd26,
							jeqs = 5'd27,
							in = 5'd28,
							out = 5'd29;

	
	always @(posedge CLK or posedge reset) begin
		if (reset) state <= reset_state;
		else state <= next_state;
	end
	
	always @(state or opcode) begin
		mem_addr = 0; mem_data = 0; mem_write = 0; dp_inc = 0; rp_inc = 0; reg_write = 0; ir_write = 0; tr_src = 0; 
		tr_write = 0; pc_src = 0; pc_write = 0; jump = 0; jump_cond = 0; alu_src = 0; b_src = 0; b_write = 1; alu_op = 0;
		rst = 0;	out_write = 0;
		next_state = fetch;
		
		case (state)
			reset_state: begin
				rst = 1;
				
				next_state = fetch;
			end
			fetch: begin
				ir_write = 1;
				mem_addr = 2'b00;
				pc_write = 1;
				pc_src = 2'b00;
				
				next_state = decode;
			end
			decode: begin
				b_src = 3'b000;
				if (opcode == 8'h00) next_state = fetch;
				else if (opcode[7:4] == 4'h0) next_state = alu;
				else if (opcode[7:4] == 4'hC) next_state = jumps_1;	//jeq
				else if (opcode[7:4] == 4'hD) next_state = jumps_1;	//jneq
				else if (opcode[7:4] == 4'hE) next_state = jumps_1;	//j
				else if (opcode[7:4] == 4'hF) next_state = call_tor;	//call
				else begin
					case (opcode)
						8'h11: next_state = load_1;	//load
						8'h12: next_state = store_1;	//store
						8'h13: next_state = call_tor; 	//tor
						8'h14: next_state = fromr_1; 	//fromr
						8'h21: next_state = burn; 	//burn
						8'h22: next_state = odpp; 	//dup
						8'h23: next_state = odpp; 	//over
						8'h24: next_state = swap; 	//swap
						8'h31: next_state = ja; 	//ja
						8'h80: next_state = odpp; 	//push
						8'h81: next_state = odpp; 	//pushu
						8'h8A: next_state = shifts_1;	//sll
						8'h8B: next_state = shifts_1; 	//srl
						8'h8C: next_state = shifts_1; 	//sra
						8'h25: next_state = out;	//out
						8'h26: next_state = odpp;	//in
					endcase
				end
			end
			alu: begin
				dp_inc = 2'b10;
				alu_src = 1;
				alu_op = opcode[3:0];
				tr_src = 3'b001;
				tr_write = 1;
				
				next_state = fetch;
			end
			burn: begin
				tr_src = 3'b000;
				dp_inc = 2'b10;
				tr_write = 1;
				
				next_state = fetch;
			end
			fromr_1: begin
				b_src = 3'b001;
				mem_addr = 2'b10;
				rp_inc = 2'b01;
				dp_inc = 2'b01;
				
				next_state = fromr_over;
			end
			odpp: begin
				dp_inc = 2'b01;
				b_write = 0;
				
				case (opcode)
					8'h22: next_state = dup; 	//dup
					8'h23: next_state = fromr_over; 	//over
					8'h80: next_state = push; 	//push
					8'h81: next_state = pushu; 	//pushu
					8'h26: next_state = in;	//in
				endcase
			end
			swap: begin
				tr_src = 3'b000;
				tr_write = 1;
				reg_write = 1;
				
				next_state = fetch;
			end
			load_1: begin
				mem_addr = 2'b11;
				b_src = 3'b001;
				
				next_state = load;
			end
			store_1: begin
				dp_inc = 2'b10;
				b_write = 0;
				
				next_state = store;
			end
			ja: begin
				pc_write = 1;
				pc_src = 2'b10;
				tr_src = 3'b000;
				tr_write = 1;
				dp_inc = 2'b10;
				
				next_state = fetch;
			end
			shifts_1: begin	//Sll, Srl, sra
				b_src = 3'b011;
				
				next_state = shifts;
			end
			jumps_1: begin	//jeq, jneq, j
				b_src = 3'b100;
				
				next_state = jumps_2;
			end
			call_tor: begin	//Call and tor
				rp_inc = 2'b10;
				b_src = 3'b100;
				
				if (opcode == 8'h13) next_state = tor;
				else next_state = call;
			end
			fromr_over: begin	//Final state for from and over
				 reg_write = 1;
				 tr_src = 3'b000;
				 tr_write = 1;
				 
				 next_state = fetch;
			end
			dup: begin
				reg_write = 1;
				
				next_state = fetch;
			end
			push: begin
				reg_write = 1;
				tr_src = 3'b011;
				tr_write = 1;
				
				next_state = fetch;
			end
			pushu: begin
				reg_write = 1;
				tr_src = 3'b010;
				tr_write = 1;
				
				next_state = fetch;
			end
			load: begin
				tr_src = 3'b000;
				tr_write = 1;
				
				next_state = fetch;
			end
			store: begin
				mem_write = 1;
				mem_addr = 2'b01;
				mem_data = 1;
				tr_src = 3'b100;
				tr_write = 1;
				dp_inc = 2'b10;
				
				next_state = fetch;
			end
			shifts: begin	//Final state for sll, srl, sra
				tr_src = 3'b001;
				tr_write = 1;
				alu_src = 1;
				alu_op = opcode[3:0];
				
				next_state = fetch;
			end
			jumps_2: begin //Second state for jumps
				alu_op = 4'b0001;
				alu_src = 0;
				b_src = 3'b000;
				
				if (opcode[7:4] == 4'hC) next_state = jeq;	//jeq
				else if (opcode[7:4] == 4'hD) next_state = jneq;	//jneq
				else if (opcode[7:4] == 4'hE) next_state = j_call;	//j 
			end
			call: begin
				mem_data = 0;
				mem_addr = 2'b10;
				mem_write = 1;
				alu_op = 4'b0001;
				
				next_state = j_call;
			end
			tor: begin
				mem_write = 1;
				mem_addr = 2'b10;
				tr_src = 3'b100;
				tr_write = 1;
				mem_data = 1;
				dp_inc = 2'b10;
				
				next_state = fetch;
			end
			jeq: begin
				jump_cond = 1;
				jump = 1;
				pc_src = 2'b01;
				dp_inc = 2'b10;
				
				alu_src = 1;
				alu_op = 4'b0010;
				
				next_state = jeqs;
			end
			jneq: begin
				jump_cond = 0;
				jump = 1;
				pc_src = 2'b01;
				dp_inc = 2'b10;
				
				alu_src = 1;
				alu_op = 4'b0010;
				
				next_state = jeqs;
			end
			j_call: begin
				pc_src = 2'b01;
				pc_write = 1;
				
				next_state = fetch;
			end
			jeqs: begin
				tr_src = 3'b100;
				tr_write = 1;
				dp_inc = 2'b10;
				
				next_state = fetch;
			end
			in: begin
				reg_write = 1;
				tr_write = 1;
				tr_src = 3'b101;
				
				next_state = fetch;
			end
			out: begin
				out_write = 1;
				tr_write = 1;
				tr_src = 3'b100;
				dp_inc = 2'b10;
				
				next_state = fetch;
			end
			default: begin
				next_state = reset_state;
			end
		endcase
	end

endmodule
