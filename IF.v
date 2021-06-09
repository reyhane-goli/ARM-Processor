`timescale 1ps/1ps
module IF(input clk, input rst,input freeze,input [31:0] Branch_adr,input Branch_taken,
output [31:0] pc,output [31:0] instr);

	wire [31:0] pc_in;
	wire [31:0] pc_out;

	Mux_2_to_1 mux(pc,Branch_adr,Branch_taken,pc_in);

	Register pc_reg(clk,rst,~freeze,pc_in,pc_out);
	
	Adder pc_adder(pc_out,32'd4,pc);
	
	Instr_mem instr_mem(rst,pc_out,instr);
	
endmodule
