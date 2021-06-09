`timescale 1ps/1ps
module TB();
    reg clk = 0;
    reg rst = 0;
    ARM_processor uut(clk,rst);
    always #100 clk = ~clk;
    initial begin 
        #100 rst = 1;
        #300 rst = 0;
        #100000
        $stop;
    end
endmodule
