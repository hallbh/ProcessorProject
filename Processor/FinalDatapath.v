`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:12 11/01/2017 
// Design Name: 
// Module Name:    FinalDatapath 
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
module FinalDatapath(
	input CLK
	);
	
	wire [7:0] opcode;
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
	wire reset;
	
	wire pc_enable;
	wire isZero;
	
	control control_unit(
		.opcode(opcode),
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
		.reset(reset)
	);
	
	LinkedDatapath datapath(
		.opcode(opcode),
		.CLK(CLK),
		.reset(reset),
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
		.pc_enable(pc_enable),
		.alu_src(alu_src),
		.b_src(b_src),
		.b_write(b_write),
		.alu_op(alu_op),
		.isZero(isZero)
	);
	
	assign pc_enable = (pc_write || (jump && (jump_cond ~^ isZero)));

endmodule
