`timescale 1ps/1ps
module Control_unit(input [3:0]opcode,input [1:0] mode,input s,
output reg wb_en,mem_r_en,mem_w_en, branch, s_out, output reg [3:0] exe_cmd);
    
  always@(*) begin
    case(mode)
      2'b00: begin
        case(opcode)
          4'b1101: //MOV
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b0001;
            end
          4'b1111: //MVN
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b1001;
            end
          4'b0100: //ADD
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b0010;
            end
          4'b0101: //ADC
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b0011;
            end
          4'b0010: //SUB
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b0100;
            end
          4'b0110: //SBC
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b0101;
            end
          4'b0000: //AND
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b0110;
            end
          4'b1100: //ORR
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b0111;
            end
          4'b0001: //EOR
            begin
              wb_en = 1;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = s;
              exe_cmd = 4'b1000;
            end
          4'b1010: //CMP
            begin
              wb_en = 0;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = 1;
              exe_cmd = 4'b0100;
            end
          4'b1000: //TST
            begin
              wb_en = 0;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = 1;
              exe_cmd = 4'b0110;
            end
          default:
            begin
              wb_en = 0;
              mem_r_en = 0;
              mem_w_en = 0;
              branch = 0;
              s_out = 0;
              exe_cmd = 4'b0000;
            end
        endcase
      end
      2'b01: begin
        case(s)
          1'b1:
          begin
            wb_en = 1;
            mem_r_en = 1;
            mem_w_en = 0;
            branch = 0;
            s_out = 1;
            exe_cmd = 4'b0010;
          end
          1'b0:
          begin
            wb_en = 0;
            mem_r_en = 0;
            mem_w_en = 1;
            branch = 0;
            s_out = 0;
            exe_cmd = 4'b0010;
          end
        endcase
      end
      2'b10: begin
         begin
            wb_en = 0;
            mem_r_en = 0;
            mem_w_en = 0;
            branch = 1;
            s_out = 0;
            exe_cmd = 4'b0000;
          end
      end
      default:
         begin
            wb_en = 0;
            mem_r_en = 0;
            mem_w_en = 0;
            branch = 0;
            s_out = 0;
            exe_cmd = 4'b0000;
          end
      endcase
    end
endmodule
