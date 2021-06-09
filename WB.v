`timescale 1ps/1ps
module WB(input [31:0]mem_res,alu_res,input mem_r_en,output [31:0]out);

	Mux_2_to_1 wb_mux(alu_res,mem_res,mem_r_en,out);

endmodule
