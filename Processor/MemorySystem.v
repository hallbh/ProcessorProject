`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:50:54 11/01/2017 
// Design Name: 
// Module Name:    MemorySystem 
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
module MemorySystem(
	input [15:0] addr_a,
	input [15:0] addr_b,
	input [15:0] addr_c,
	input [15:0] addr_d,
	input [15:0] data_a,
	input [15:0] data_b,
	input [1:0] mem_addr,
	input mem_data, 
	input mem_write,
	input CLK,
	output [15:0] read_data
   );
	
	wire [15:0] address;
	wire [15:0] write_data;
	
	mux4_16b address_mux(
		.a(addr_a),
		.b(addr_b),
		.c(addr_c),
		.d(addr_d),
		.sel(mem_addr),
		.o(address)
	);
	
	mux2_16b data_mux(
		.a(data_a),
		.b(data_b),
		.sel(mem_data),
		.o(write_data)
	);
	
	memory16384_16b mem(
		.clka(CLK),
		.wea(mem_write),
		.addra(address[13:0]),
		.dina(write_data),
		.douta(read_data)
	);

endmodule
