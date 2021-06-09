`timescale 1ps/1ps
module Data_Memory(input clk,rst,mem_w_en,mem_r_en,input [31:0]in,adr,output [31:0]out);

  reg [7:0] data[0:255];
  wire [31:0] new_adr,aligned_adr;

  assign new_adr   = (adr >= 1024) ? adr - 1024 : adr;
  assign aligned_adr = {new_adr[31:2], 2'b00};

  integer i;
	always@(posedge clk)
	begin
		if(rst)
		begin
			for(i = 0; i < 256; i = i + 1)
				data[i] <= 8'b0;
		end
		else if(mem_w_en)
			{data[aligned_adr],data[aligned_adr+1],data[aligned_adr+2],data[aligned_adr+3]} <= in;
	end
	
	assign out = (mem_r_en) ? {data[aligned_adr],data[aligned_adr+1],data[aligned_adr+2],data[aligned_adr+3]} : 32'b0;	
endmodule
