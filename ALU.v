`timescale 1ps/1ps
module ALU(input[31:0]val1,input[31:0]val2,input[3:0]exe_cmd,
		input[3:0]status_reg_in,output[31:0]alu_res,output[3:0]status_bits);
  reg[31:0]alu_output;
  reg c_bit;
  reg v_bit;
  always@(*)
  begin
    case(exe_cmd)
	4'b0001: //MOV
	  begin
	  alu_output<=val2;
	  c_bit<=0;
	  v_bit<=0;
	  end
	4'b1001://MVN
	  begin
	  alu_output<=~val2;
          c_bit<=0;
	  v_bit<=0;
	  end
	4'b0010://ADD
	  begin
	  {c_bit,alu_output}<=val1+val2;
	   v_bit<=(val1[31]&val2[31]& !alu_output[31])||(!val1[31]&!val2[31]&alu_output[31]);
	  end
	4'b0011://ADC
	  begin
	  {c_bit,alu_output}<=val1+val2+status_reg_in[1];
	  v_bit<=(val1[31]&val2[31]& !alu_output[31])||(!val1[31]&!val2[31]&alu_output[31]);
	  end
	4'b0100://SUB
	  begin
	   {c_bit,alu_output}<=val1-val2;
	   v_bit<=(!val1[31]&val2[31]&alu_output[31])||(val1[31]&!val2[31]&!alu_output[31]);					
	  end
	4'b0101://SBC
	  begin
	  {c_bit,alu_output}<=val1-val2-(!status_reg_in[1]);
	  v_bit<=(!val1[31]&val2[31]&alu_output[31])||(val1[31]&!val2[31]&!alu_output[31]);
	  end
	4'b0110://AND
	  begin
	  alu_output<=val1&val2;
	  c_bit<=0;
	  v_bit<=0;
	  end
	4'b0111://OR
	  begin
	  alu_output<=val1|val2;
	  c_bit<=0;
	  v_bit<=0;
	  end
	4'b1000://XOR
	  begin
	  alu_output<=val1^val2;
	  c_bit<=0;
	  v_bit<=0;					
	  end
     endcase
   end
	assign alu_res=alu_output;
	//v bit
	assign status_bits[0]=v_bit;
	//c bit
	assign status_bits[1]=c_bit;
	//z bit
	assign status_bits[2]=~(|(alu_res));
	//n bit
	assign status_bits[3]=alu_res[31];

endmodule