`timescale 1ps/1ps
module Register #(parameter size=32)(input clk,input rst,input ld,input [size-1:0]in,
output reg [size-1:0]out);

	always@(posedge clk)
	begin
		if(rst)
      out <= {size{1'b0}};
		else if(ld)
      out <= in;
	end
	
endmodule