`timescale 1ps/1ps
module val2_generate(input imm,input str_ldr_detect,input[11:0]shifter_operand,input[31:0]val_Rm,output[31:0]val2);  

    wire[7:0]immed_8; 
    wire[3:0]rotate_imm;
    wire[1:0]shift_op;
    wire[4:0]shift_imm;
    reg[31:0]rotated;
    wire[19:0]sign;
    wire[31:0]extended;
    reg [63:0] temp;
    assign immed_8 = shifter_operand[7:0];
    assign rotate_imm = shifter_operand[11:8];
    assign shift_op = shifter_operand[6:5];
    assign shift_imm = shifter_operand[11:7];
    assign sign= shifter_operand[11]?{(20){1'b1}}:{(20){1'b0}};
    assign extended = {sign,shifter_operand};
    
    always@(*) begin
        rotated = 32'b0;
        if(str_ldr_detect) begin
            rotated = extended;
        end
        else if(imm) begin
            case(rotate_imm)
                4'b0000: rotated = {24'b0,immed_8};
                4'b0001: rotated = {immed_8[1:0],24'b0,immed_8[7:2]};
                4'b0010: rotated = {immed_8[3:0],24'b0,immed_8[7:4]};
                4'b0011: rotated = {immed_8[5:0],24'b0,immed_8[7:6]};
                4'b0100: rotated = {immed_8[7:0],24'b0};
                4'b0101: rotated = {2'b0,immed_8[7:0],22'b0};
                4'b0110: rotated = {4'b0,immed_8[7:0],20'b0};
                4'b0111: rotated = {6'b0,immed_8[7:0],18'b0};
                4'b1000: rotated = {8'b0,immed_8[7:0],16'b0};
                4'b1001: rotated = {10'b0,immed_8[7:0],14'b0};
                4'b1010: rotated = {12'b0,immed_8[7:0],12'b0};
                4'b1011: rotated = {14'b0,immed_8[7:0],10'b0};
                4'b1100: rotated = {16'b0,immed_8[7:0],8'b0};
                4'b1101: rotated = {18'b0,immed_8[7:0],6'b0};
                4'b1110: rotated = {20'b0,immed_8[7:0],4'b0};
                4'b1111: rotated = {22'b0,immed_8[7:0],22'b0};
            endcase
        end 
        else if(imm == 0&&shifter_operand[4] == 0) begin
            case(shift_op)
                2'b00: rotated = val_Rm << shift_imm;//LSL
                2'b01: rotated = val_Rm >> shift_imm;//LSR
                2'b10: rotated = val_Rm >>> shift_imm;//ASR
		2'b11:begin
                      temp = {val_Rm,val_Rm} >> shift_imm;
                      rotated = temp[31:0];                      
		      end
            endcase
        end
    end

    assign val2 = rotated;

endmodule