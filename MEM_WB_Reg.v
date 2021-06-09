`timescale 1ps/1ps
module MEM_WB_Reg(input clk,rst,wb_en_in,mem_r_en_in,
input [31:0]alu_res_in,mem_r_val_in,input [3:0]dst_in,
output reg wb_en_out,mem_r_en_out,
output reg [31:0]alu_res_out,mem_r_val_out,output reg [3:0]dst_out);

  always@(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			wb_en_out <= 1'b0;
      mem_r_en_out <= 1'b0;
      alu_res_out <= 32'b0;
      mem_r_val_out <= 32'b0;
      dst_out <= 4'b0;
		end
		else begin
      wb_en_out <= wb_en_in;
      mem_r_en_out <= mem_r_en_in;
      alu_res_out <= alu_res_in;
      mem_r_val_out <= mem_r_val_in;
      dst_out <= dst_in;
		end
	end	
endmodule
