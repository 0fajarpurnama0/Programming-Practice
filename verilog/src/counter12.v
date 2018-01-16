module counter12( CLK, RST, CE, CNT );
   input        CLK, RST, CE;
   output [7:0] CNT;
  
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
		     d1 <= d1 + 4'd1; 
		   end
	    else if( d1 == 2 && d0 == 3 )
		    begin
		      d1 <= 0;
		      d0 <= 0;
		    end
	    else
		    d0 <= d0 + 4'd1;
	  end
   end
     
   assign CNT = { d1, d0 };

endmodule
