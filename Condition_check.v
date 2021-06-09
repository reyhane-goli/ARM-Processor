`timescale 1ps/1ps
module Condition_check(input [3:0]cond,input [3:0]status_bits,output reg check);
/*  status => |N|Z|C|V|
    0 => V
    1 => C
    2 => Z
    3 => N */
  always @(*) begin
    case (cond)
      4'b0000:  check = (status_bits[2]) ? 1 : 0;
      4'b0001:  check = (~status_bits[2]) ? 1 : 0;   
      4'b0010:  check = (status_bits[1]) ? 1 : 0;
      4'b0011:  check = (~status_bits[1]) ? 1 : 0;   
      4'b0100:  check = (status_bits[3]) ? 1 : 0;
      4'b0101:  check = (status_bits[3]) ? 1 : 0;   
      4'b0110:  check = (status_bits[0]) ? 1 : 0;
      4'b0111:  check = (status_bits[0]) ? 1 : 0;
      4'b1000:  check = (status_bits[1] && ~status_bits[2]) ? 1 : 0;
      4'b1001:  check = (~status_bits[1] && status_bits[2]) ? 1 : 0;
      4'b1010:  check = (status_bits[3] == status_bits[0]) ? 1 : 0;
      4'b1011:  check = (status_bits[3] != status_bits[0]) ? 1 : 0;
      4'b1100:  check = (~status_bits[2] && status_bits[3] == status_bits[0]) ? 1 : 0;
      4'b1101:  check = (status_bits[2] && status_bits[3] != status_bits[0]) ? 1 : 0;
      4'b1110:  check = 1;
      4'b1111:  check = 0;
      default:  check = 0;
    endcase
  end   
endmodule
