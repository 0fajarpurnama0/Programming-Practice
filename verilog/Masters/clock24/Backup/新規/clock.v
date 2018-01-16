module clock ( CLK, RST, CE10, CE1 );
input CLK; // Clock
input RST; // Reset
output CE10; // Clock enable 10ms (100Hz)
output CE1; // Clock enable 1ms (1kHz)
reg [16:0] cnt1;
reg [3:0] cnt2;

always @( posedge CLK or posedge RST )
    begin
	   if( RST ) cnt1 <= `PRECOUNT;    else
      if( CE1 ) cnt1 <= `PRECOUNT;    else
                cnt1 <= cnt1 - 17'd1;
    end

always @( posedge CLK or posedge RST )
    begin
	   if( RST ) cnt2 <= 4'd9; else
	   if( CE1 ) 
	     begin
          if( ~|cnt2 ) cnt2 <= 4'd9;        else
                       cnt2 <= cnt2 - 4'd1;
        end
    end

  assign CE1  = ~|cnt1;         // Clock enable  1ms = 1000Hz
  assign CE10 = ~|{cnt2, cnt1}; // Clock enable 10ms =  100Hz

endmodule
