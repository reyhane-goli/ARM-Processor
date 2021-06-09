`timescale 1ps/1ps
module MEM(input clk,rst,input mem_r_en,input mem_w_en,input [31:0]in,input [31:0]adr,output [31:0]out);

  Data_Memory d_mem(clk,rst,mem_w_en,mem_r_en,in,adr,out);

endmodule


