//
// Micro Controller based on Microchip PIC16
//  for Digilent NEXYS4 DDR  Board

module pic16 ( CLK, nRST, RA, RB );
   input        CLK, nRST;
   inout [7:0] 	RA;
   inout [7:0] 	RB;
   
   parameter PROG = "program.mem";

   // Reset
   wire         RST, nPIC_RST, PIC_RST;
   assign RST = ~nRST;

   // Clock Module for PIC clock
   wire 	PICCLK, CLK100;
   pic_dcm
   //     #( .CLKOUT1_DIVIDE(10), .CLKFBOUT_MULT_F(8.000) ) // 100*8.00/10=80MHz(12.50ns) 7z020:NG
   //     #( .CLKOUT1_DIVIDE( 8), .CLKFBOUT_MULT_F(6.000) ) // 100*6.00/ 8=75MHz(13.33ns) 7z020:NG
          #( .CLKOUT1_DIVIDE(10), .CLKFBOUT_MULT_F(7.000) ) // 100*7.00/10=70MHz(14.29ns) 7z020:OK
   //     #( .CLKOUT1_DIVIDE( 9), .CLKFBOUT_MULT_F(6.000) ) // 100*6.00/ 9=66MHz(15.00ns) 7z020:OK
   //     #( .CLKOUT1_DIVIDE(15), .CLKFBOUT_MULT_F(9.750) ) // 100*9.75/15=65MHz(15.38ns) 7z020:OK
   //     #( .CLKOUT1_DIVIDE(10), .CLKFBOUT_MULT_F(6.000) ) // 100*6.00/10=60MHz(16.67ns) 7z020:OK
   dcm0 ( .CLK_IN1 (CLK),
          .CLK_OUT1(CLK100),
          .CLK_OUT2(PICCLK),
          .RESET   (RST),
          .LOCKED  (nPIC_RST) );
   
   assign PIC_RST = ~nPIC_RST;

   pic16core #( .PROG(PROG) )
   i_pic16core ( .CLK(PICCLK), .RST(PIC_RST), .RA(RA), .RB(RB) );
   
endmodule
