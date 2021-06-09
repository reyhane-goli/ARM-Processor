`timescale 1ps/1ps
module IF_ID_Reg(input clk,input rst,input freeze,input flush,input [31:0]pc_in,input [31:0]instr_in,
output reg [31:0]pc_out,output reg [31:0]instr_out);
	
	always@(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			pc_out	<= 32'b0;
			instr_out <= 32'b0;
		end
		else if(~freeze)
		begin
			pc_out	<= pc_in;
			instr_out <= instr_in;
		end
		else if(flush)
		begin
			pc_out	<= 32'b0;
			instr_out <= 32'b0;
		end
	end
endmodule

