`timescale 1ps/1ps
module ID(input clk,input rst,input freeze,input [31:0]instr_out,
input [3:0]wb_dst,input [31:0]wb_val,input wb_en_in,input [3:0] status_bits,
output wb_en_out,output mem_r_en,output mem_w_en,output branch,output s,output [3:0]exe_cmd,
output [31:0]val_Rn,output [31:0]val_Rm,output imm,output [11:0] shift_operand,
output [3:0] dst,output [23:0] imm24,
output [3:0]src1,output [3:0]src2,output two_src);

  wire [3:0] src2_regfile;
  wire wb_enable,mem_r_enable,mem_w_enable,branch_out,s_out;
  wire [3:0]exe_cmd_out;
  wire or_condition;
  wire check_condition;

  assign or_condition = (~check_condition)|freeze;

  assign two_src = (~instr_out[25])|mem_w_enable;

	Mux_2_to_1 #(4) regfile_src2_mux(instr_out[3:0],instr_out[15:12],mem_w_enable,src2_regfile);

  Mux_2_to_1 #(9) control_unit_mux({wb_enable,mem_r_enable,mem_w_enable,branch_out,s_out,exe_cmd_out},9'b0,or_condition,
                            {wb_en_out,mem_r_en,mem_w_en,branch,s,exe_cmd});

	Register_file reg_file(clk,rst,wb_en_in,instr_out[19:16],src2_regfile,wb_dst,wb_val,val_Rn,val_Rm);

  Control_unit cu(instr_out[24:21],instr_out[27:26],instr_out[20],wb_enable,mem_r_enable,mem_w_enable,branch_out,s_out,exe_cmd_out);

  Condition_check condition(instr_out[31:28],status_bits,check_condition);

    assign src1 = instr_out[19:16];
    assign src2 = src2_regfile;
    assign dst = instr_out[15:12];
    assign imm = instr_out[25];
    assign imm24 = instr_out[23:0];
    assign shift_operand = instr_out[11:0];
        	
endmodule

