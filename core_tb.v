`timescale 1ns / 1ps 

module calcu16_tb;
    reg clk;
    wire LED0;
    wire LED1;
    wire LED2;
    wire LED3;
    wire LED4;
    wire LED5;
    wire LED6;
    wire LED7;

    pro processor(clk,LED0,LED1,LED2,LED3,LED4,LED5,LED6,LED7);

    initial begin     
        clk <= 1;
        $monitor($time,"lights=%b %b %b %b %b %b %b %b",LED0,LED1,LED2,LED3,LED4,LED5,LED6,LED7);

         #1000 // Simulation time
         $finish;
    end

    always
        #1 clk = ~clk;
endmodule