module counter24 ( CLK, RST, CE10, SETH, SETM, SCLR, TIME );
  input  CLK;  // Clock
  input  RST;  // Reset
  input  CE10; // Clock enable 10ms
  input  SETH; // Set Hour éûä‘éûçèçáÇÌÇπ
  input  SETM; // Set Minuite ï™éûçèçáÇÌÇπ
  input  SCLR; // Clear ss&mm, ïbÅC1/10ïb,1/00ïbÉäÉZÉbÉg
  output [31:0] TIME;

  wire       sec;
  wire       up1;
  wire       up2;
  wire [7:0] HH, MM, ss, mm;

  counter100 c100 (.CLK(CLK),.RST(RST|SCLR),.CE(CE10),          .UP(sec),.CNT(mm));
  counter60  c60s (.CLK(CLK),.RST(RST|SCLR),.CE(sec),           .UP(up1),.CNT(ss));
  counter60  c60M (.CLK(CLK),.RST(RST),     .CE(up1|(sec&SETM)),.UP(up2),.CNT(MM));
  counter12  c24  (.CLK(CLK),.RST(RST),     .CE(up2|(sec&SETH)),         .CNT(HH));

  assign TIME = { HH, MM, ss, mm };

endmodule
