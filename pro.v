module pro (
  input clk,
  output LED0,
  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5,
  output LED6,
  output LED7);
wire dclk;
clk_divider clkUUT(clk,dclk);
core proUUT(clk,LED0,LED1,LED2,LED3,LED4,LED5,LED6,LED7);

endmodule