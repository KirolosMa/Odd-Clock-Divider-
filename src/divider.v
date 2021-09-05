module odd_divider ( 
        input clk,rst,
		input divide,
		output clk_divided); 
parameter data_width=2;
parameter count_param=3;
wire [data_width-1:0] output_count;
reg reg_1,reg_2;
wire neg_clk;
wire counter_reset;
assign neg_clk = !clk;
///-----Counter Reset Signal------/
assign counter_reset = ( (output_count == (count_param - 'd1)) || (rst == 'b0))? 'b0 : 'b1;

//-- Counter -----//
counter  #(.count_param(3),.data_width(data_width)) counter_u1 (.clk(clk),.rst(counter_reset) ,.incr(divide), .count(output_count));
//-- Register to achieve the 90 phase---//
always @( posedge clk or negedge rst) 
  begin
    if(!rst) 
	  reg_1 <= 'b0 ;
	else 
	  begin 
	    if (output_count == 0) 
		  reg_1 <= 'b1;
		else
		  reg_1 <= 'b0;
	  end
  end

always @( negedge neg_clk or negedge rst) 
  begin
    if(!rst) 
	  reg_2 <= 'b0 ;
	else 
	  begin 
	    if (output_count == (count_param - 'd1) ) 
		  reg_2 <= 'b1;
		else
		  reg_2 <= 'b0;
	  end
  end 
//--- Clk divided output ---//
assign clk_divided = reg_2 ^ reg_1;
endmodule 
