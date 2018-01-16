module clock24 ( CLK, RSTN, SETH, SETM, SCLR, SEGN, AN, LED );
  input        CLK; 	// Clock (100MHz)
  input        RSTN; // Reset (Low active)
  input        SETH; // Set hour (High active)
  input        SETM; // Set minute (High active)
  input        SCLR; // Clear sec and msec (high active)
  output [7:0] SEGN;	// segment for 7 segment LED (Low active)
  output [7:0] AN;   // Digit enable for 7 segment LED (Low active)
  output [2:0] LED;  // LED (High active)

  // internal wire
  wire        RST;   // Reset (High active)
  wire [31:0] TIME;  // hh:mm:ss:ms
  wire [ 3:0] BCD;	// BCD value of TIME
  wire        CE1;   // Clock enable  1ms = 1,000Hz
  wire        CE10;  // Clock enable 10ms =   100Hz
  wire [ 7:0] SEG;	// Segment data
  wire [ 7:0] DIGIT;
  
  assign RST = ~RSTN;
  
  clock     C0 ( .CLK(CLK), .RST(RST), .CE10(CE10), .CE1(CE1) );
  counter24 C1 ( .CLK(CLK), .RST(RST), .CE10(CE10),
						 .SETH(SETH), .SETM(SETM), .SCLR(SCLR), .TIME(TIME) );
  led_drv   C2 ( .CLK(CLK), .RST(RST), .CE(CE1), .TIME(TIME), .BCD(BCD),  .DIGIT(DIGIT) );
  seven_seg C3 ( .BCD(BCD), .SEG(SEG) );
  
  assign SEGN = ~SEG;
  assign AN   = ~DIGIT;
  assign LED[0] =  TIME[7];
  assign LED[1] = ~TIME[7];
  assign LED[2] = ~TIME[5];
endmodule
