`timescale 1ps/1ps
module ID_EXE_Reg(input clk, input rst,input flush,
input wb_en_in,input mem_r_en_in,input mem_w_en_in,input branch_in,input s_in,
input [3:0] exe_cmd_in,input [31:0]val_Rn_in,input [31:0]val_Rm_in,
input [31:0] pc_in,
input imm_in,input [23:0]imm24_in,input [11:0]shifter_op_in,
input [3:0] dst_in,input [3:0]status_reg_in,
output reg wb_en_out,output reg mem_r_en_out,output reg mem_w_en_out,output reg branch_out,output reg s_out,
output reg [3:0] exe_cmd_out,output reg [31:0]val_Rn_out,output reg [31:0]val_Rm_out,
output reg [31:0] pc_out,
output reg imm_out,output reg [23:0]imm24_out,output reg [11:0]shifter_op_out,
output reg [3:0] dst_out,output reg [3:0]status_reg_out);
	
	always@(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			wb_en_out <= 1'b0;
      mem_r_en_out <= 1'b0;
      mem_w_en_out <= 1'b0;
      branch_out <= 1'b0;
      s_out <= 1'b0;
      exe_cmd_out <= 4'b0;
      val_Rn_out <= 32'b0;
      val_Rm_out <= 32'b0;
      pc_out <= 32'b0;
      imm_out <= 1'b0;
      imm24_out <= 24'b0;
      shifter_op_out <= 12'b0; 
      dst_out <= 4'b0;
      status_reg_out <= 4'b0;
		end
		else begin
      if(flush) begin
        wb_en_out <= 1'b0;
        mem_r_en_out <= 1'b0;
        mem_w_en_out <= 1'b0;
        branch_out <= 1'b0;
        s_out <= 1'b0;
        exe_cmd_out <= 4'b0;
        val_Rn_out <= 32'b0;
        val_Rm_out <= 32'b0;
        pc_out <= 32'b0;      
        imm_out <= 1'b0;
        imm24_out <= 24'b0;
        shifter_op_out <= 12'b0;       
        dst_out <= 4'b0;
        status_reg_out <= 4'b0;
      end 
      else begin
        wb_en_out <= wb_en_in;
        mem_r_en_out <= mem_r_en_in;
        mem_w_en_out <= mem_w_en_in;
        branch_out <= branch_in;
        s_out <= s_in;
        exe_cmd_out <= exe_cmd_in;
        val_Rn_out <= val_Rn_in;
        val_Rm_out <= val_Rm_in;
        pc_out <= pc_in;     
        imm_out <= imm_in;
        imm24_out <= imm24_in;
        shifter_op_out <= shifter_op_in;       
        dst_out <= dst_in;
        status_reg_out <= status_reg_in;
      end
		end
	end	
endmodule

