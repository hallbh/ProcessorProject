`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:35 11/01/2017 
// Design Name: 
// Module Name:    LinkedDatapath 
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
module Datapath(
	/*input [1:0] pc_src,
	input [1:0] rp_inc,
	input pc_enable,
	input [1:0] mem_addr,
	input mem_data,
	input mem_write,
	input ir_write,
	input [2:0] tr_src,
	input [1:0] dp_inc,
	input reg_write,
	input tr_write,
	input [2:0] b_src,
	input b_write,
	input alu_src,
	input [3:0] alu_op,*/
	input reset,
	input CLK,
	input mem_CLK,
	input [15:0] in_data,
	output [15:0] out_data,
	output ovfl
   );
	
	wire [15:0] pc;
	wire [15:0] br;
	wire [15:0] tr;
	wire [15:0] rp;
	wire [15:0] B;
	wire [15:0] mem_read_data;
	wire [15:0] ir;
	wire [15:0] reg_read_data;
	wire [15:0] sign_ext_imm;
	wire [15:0] zero_ext_imm;
	wire [15:0] eight_shift_imm;
	wire [15:0] offset;
	wire [15:0] R;
	wire [15:0] in;
	
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
	wire out_write;
	wire [15:0] outputData;
	
	//Control Unit
	ControlUnit control (
    .opcode(ir[15:8]), 
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
    .rst(rst),
	 .out_write(out_write)
    );
	 
	 JumpEnabler_1b pc_enabler (
    .pc_write(pc_write), 
    .jump(jump), 
    .jump_cond(jump_cond), 
    .isZero(isZero), 
    .pc_enable(pc_enable)
    );
	
	
	//Datapath
	
	subsystem_pcadder pc_loop(
		.a(br),
		.b(tr),
		.pc_src(pc_src),
		.pc_enable(pc_enable),
		.reset(rst),
		.CLK(CLK),
		.pc(pc)
	);
	
	subsystem_rpadder rp_loop(
		.rp_inc(rp_inc),
		.CLK(CLK),
		.reset(rst),
		.rp(rp)
	);
	
	MemorySystem memory(
		.addr_a(pc),
		.addr_b(B),
		.addr_c(rp),
		.addr_d(tr),
		.data_a(pc),
		.data_b(tr),
		.mem_addr(mem_addr),
		.mem_data(mem_data),
		.mem_write(mem_write),
		.CLK(mem_CLK),
		.read_data(mem_read_data)
	);
	
	reg_16b ir_register(
		.D(mem_read_data),
		.rstval(16'b0),
		.write(ir_write),
		.reset(rst),
		.CLK(CLK),
		.Q(ir)
	);
	
	se_8b_16b sign_extend(
		.in(ir[7:0]),
		.out(sign_ext_imm)
	);
	
	se_12b_16b offset_extend(
		.in(ir[11:0]),
		.out(offset)
	);
	
	ze_8b_16b zero_extend(
		.in(ir[7:0]),
		.out(zero_ext_imm)
	);
	
	eight_leftshift shift_left_8(
		.in(ir[7:0]),
		.out(eight_shift_imm)
	);
	
	DataStackSystem datastack(
		.tr_src_a(B),
		.tr_src_b(R),
		.tr_src_c(eight_shift_imm),
		.tr_src_d(sign_ext_imm),
		.tr_src_f(in),
		.tr_src(tr_src),
		.tr_write(tr_write),
		.dp_inc(dp_inc),
		.reg_write(reg_write),
		.reset(rst),
		.CLK(CLK),
		.TR(tr),
		.read_data(reg_read_data)
	);
	
	BSystem b_register(
		.a(reg_read_data),
		.b(mem_read_data),
		.c(sign_ext_imm),
		.d(zero_ext_imm),
		.e(offset),
		.b_src(b_src),
		.b_write(b_write),
		.reset(rst),
		.CLK(CLK),
		.B_out(B)
	);
	
	ALUSystem ALU(
		.ALUSrc_a(pc),
		.ALUSrc_b(tr),
		.B(B),
		.alu_src(alu_src),
		.alu_op(alu_op),
		.reset(rst),
		.CLK(CLK),
		.R(R),
		.br(br),
		.isZero(isZero),
		.ovfl(ovfl)
	);
	
	/*
	reg_16b in_register(
		.D(in_data),
		.rstval(16'b0),
		.write(1),
		.reset(0),
		.CLK(CLK),
		.Q(in)
	);
	*/
	
	reg_16b out_register(
		.D(tr),
		.rstval(16'b0),
		.write(out_write),
		.reset(rst),
		.CLK(CLK),
		.Q(outputData)
	);
	
	assign out_data = outputData;
	assign in = in_data;
	
endmodule
