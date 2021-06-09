module ARM_processor(input clk, rst);
  
    wire freeze,branch_taken;
    wire [31:0] branch_adr,pc,instr;
    wire [3:0] wb_dst,status_bits,exe_cmd,dst,src1,src2;
    wire fulsh;
    wire [31:0] pc_out,instr_out;
    wire [31:0] wb_val,val_Rn,val_Rm;
    wire wb_en_in,wb_en_out,mem_r_en,mem_w_en,branch,s,imm,two_src;
    wire [11:0] shift_operand;
    wire [23:0] imm24;
    wire wb_en_out_reg,mem_r_en_out,mem_w_en_out,s_out,imm_out;
    wire [3:0] exe_cmd_out,dst_out,status_bits_out;
    wire [31:0] val_Rn_out,val_Rm_out,pc_out_exe;
    wire [23:0] imm24_out;
    wire [11:0] shifter_op_out;
    wire [31:0] alu_res;
    wire [3:0] status_bits_exe_out;
    wire wb_en_out_exe,mem_r_en_out_exe,mem_w_en_out_exe;
    wire [31:0] alu_res_out_exe,val_Rm_out_exe;
    wire [3:0] dst_out_exe;
    wire [31:0]mem_out;
    wire mem_r_en_out_mem;
    wire [31:0] alu_res_out_mem,mem_r_val_out;
    
    IF if_stage(clk,rst,freeze,branch_adr,branch_taken,pc,instr);
    
    IF_ID_Reg if_id_reg(clk,rst,freeze,flush,pc,instr,pc_out,instr_out);
    
    ID id_stage(clk,rst,freeze,instr_out,wb_dst,wb_val,wb_en_in,status_bits,
    wb_en_out,mem_r_en,mem_w_en,branch,s,exe_cmd,val_Rn,val_Rm,imm,shift_operand,
    dst,imm24,src1,src2,two_src);
    
    ID_EXE_Reg id_exe_reg(clk,rst,flush,wb_en_out,mem_r_en,mem_w_en,branch,s,exe_cmd,val_Rn,val_Rm,pc_out,
    imm,imm24,shift_operand,dst,status_bits,
    wb_en_out_reg,mem_r_en_out,mem_w_en_out,branch_taken,s_out,exe_cmd_out,val_Rn_out,val_Rm_out,
    pc_out_exe,imm_out,imm24_out,shifter_op_out,dst_out,status_bits_out);
    
    EXE exe_stage(wb_en_out_reg,mem_r_en_out,mem_w_en_out,s_out,exe_cmd_out,
    val_Rn_out,val_Rm_out,pc_out_exe,imm_out,imm24_out,shifter_op_out,status_bits_out,
    alu_res,branch_adr,status_bits_exe_out);
    
    EXE_MEM_Reg exe_mem_reg(clk,rst,wb_en_out_reg,mem_r_en_out,mem_w_en_out,alu_res,val_Rm_out,dst_out,
    wb_en_out_exe,mem_r_en_out_exe,mem_w_en_out_exe,alu_res_out_exe,val_Rm_out_exe,dst_out_exe);

    MEM mem_stage(clk,rst,mem_r_en_out_exe,mem_w_en_out_exe,val_Rm_out_exe,alu_res_out_exe,mem_out);

    MEM_WB_Reg mem_wb_reg(clk,rst,wb_en_out_exe,mem_r_en_out_exe,alu_res_out_exe,mem_out,dst_out_exe,
    wb_en_in,mem_r_en_out_mem,alu_res_out_mem,mem_r_val_out,wb_dst);

    WB wb_stage(mem_r_val_out,alu_res_out_mem,mem_r_en_out_mem,wb_val);

    Hazard_detection_unit hazard_unit(src1,src2,dst_out_exe,wb_en_out_exe,dst_out,
    wb_en_out_reg,two_src,freeze);

    Status_Reg status_reg(clk,rst,s_out,status_bits_exe_out,status_bits);

endmodule
