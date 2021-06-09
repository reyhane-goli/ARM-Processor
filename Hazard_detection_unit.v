`timescale 1ps/1ps
module Hazard_detection_unit(input [3:0]src1,input [3:0]src2,
input [3:0]mem_dst,input mem_wb_en,input [3:0]exe_dst,input exe_wb_en,input two_src,
output reg hazard);

	always@(*) begin
    hazard = 0;
    if (exe_wb_en == 1 && src1 == exe_dst) hazard = 1; 
    else if (mem_wb_en == 1 && src1 == mem_dst) hazard = 1;
    else if (exe_wb_en == 1 && two_src == 1 && src2 == exe_dst) hazard = 1;
    else if (mem_wb_en == 1 && two_src == 1 && src2 == mem_dst) hazard = 1;  
  end
endmodule

