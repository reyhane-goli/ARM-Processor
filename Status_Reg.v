`timescale 1ps/1ps
module Status_Reg(input clk,input rst,input s,input [3:0]in,output reg [3:0]out);
	
	always@(negedge clk)
	begin
		if(rst)
            out <= {4'b0};
		else if(s)
            out <= in;
	end
	
endmodule

