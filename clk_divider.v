module clk_divider(
    input clk,
    output reg div_clk=0);

localparam div_val=49999999;
integer counter=0;
always @(posedge clk) begin
    
    if (counter == div_val ) 
        counter <=0;
    else
        counter <= counter+1;

end
always @(posedge clk) begin
    
    if (counter == div_val ) 
        div_clk= ~div_clk;
    else
        div_clk= div_clk;

end
endmodule // clk_divider