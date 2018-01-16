module counter100( CLK, RST, CE, CNT, UP );
   input        CLK, RST, CE;
   output [7:0] CNT;
   output       UP;
  
   reg [3:0] 	d1, d0;
  
   always @( posedge CLK or posedge RST )
     begin
	if( RST )
	  begin
	     d1<=0;
	     d0<=0;
	  end
	else if( CE )
	  begin
	   if( d0 == 9 )
	     begin
		    d0 <= 0;
		    if( d1 == 9 ) d1 <= 0;
		    else          d1 <= d1 + 4'd1;
	     end
	   else
	     d0 <= d0 + 4'd1;
	 end
  end

  assign CNT = { d1, d0 };		  
  assign UP = ( d1 == 4'd9 && d0 == 4'd9 && CE ) ? 1'd1 : 1'd0;

endmodule
