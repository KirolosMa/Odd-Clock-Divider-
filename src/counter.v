module counter #(parameter count_param=3, data_width=2 )( 
           input incr,
		   input clk,rst,
		   output reg [data_width-1:0] count);
//----Counter reg---------//

always@ (posedge clk or negedge rst) 
  begin
    if(!rst) 
	  count <= 'd0;
	else 
	 begin
	 if (incr =='b1)
	  count <= count +'d1;
	 else 
	  count <= count; 
	 end
  end



endmodule 
