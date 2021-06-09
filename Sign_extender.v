`timescale 1ps/1ps
module Sign_extender (in,out);
  parameter n = 32, Sign_Bit = 8;
  input [n-Sign_Bit-1:0]in;
  output [n-1:0]out;
  wire [Sign_Bit-1:0] ext;
  assign ext = in[Sign_Bit-1] ? {(Sign_Bit){1'b1}} : {(Sign_Bit){1'b0}};
  assign out = {ext, in};
    
endmodule
