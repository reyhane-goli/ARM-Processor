`timescale 1ps/1ps
module EXE(input wb_en,input mem_r_en,input mem_w_en,input S,input[3:0]exe_cmd,
input [31:0] val_Rn,input[31:0]val_Rm,input [31:0] PC,input Imm,input[23:0]Imm24,
input[11:0]shifter_operand,input[3:0]status_reg,  
output[31:0]alu_res,output[31:0]branch_addr,output[3:0]status_bits);

    wire str_ldr_detect;
    wire [31:0]val2;
    wire[31:0]signExtenderOut;
    wire [31:0] shiftedOut;

    assign str_ldr_detect = mem_r_en|mem_w_en;

    val2_generate val2gen(Imm,str_ldr_detect,shifter_operand,val_Rm,val2);
    ALU alu(val_Rn,val2,exe_cmd,status_reg,alu_res,status_bits);
    Sign_extender seInExe(Imm24,signExtenderOut);
    
    assign shiftedOut = signExtenderOut << 2;

    Adder adderInExe(PC,shiftedOut,branch_addr);
	
endmodule