`timescale 1ps/1ps
module Register_file(input clk,input rst,input wb_en,
input [3:0]src1,input [3:0]src2,input [3:0]dst,
input  [31:0]wb_val,
output [31:0]val_Rn,output [31:0]val_Rm);

	reg [31:0] reg_file[0:14];
	integer i;
	always@(negedge clk) begin
		if (rst) begin
			for (i=0; i<15; i = i+1)
				reg_file[i] <= 32'b0;
		end
		else if (wb_en)
				reg_file[dst] <= wb_val;
	end
	assign val_Rn = reg_file[src1];
	assign val_Rm = reg_file[src2];
endmodule

