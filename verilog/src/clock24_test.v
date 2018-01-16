`timescale 1ns/1ns

module clock24_text ;

  reg        CLK; 	// Clock (100MHz)
  reg        RSTN; // Reset (Low active)
  reg        SETH; // Set hour (High active)
  reg        SETM; // Set minute (High active)
  reg        SCLR; // Clear sec and msec (high active)
  wire [7:0] SEGN;	// segment for 7 segment LED (Low active)
  wire [7:0] AN;   // Digit enable for 7 segment LED (Low active)
  wire [2:0] LED;  // LED (High active)

  initial
    begin
      $shm_open("waves.shm");
      $shm_probe("as");
    end

   `include "clock24_test.vct"

  clock24 unit ( CLK, RSTN, SETH, SETM, SCLR, SEGN, AN, LED );


endmodule // clock24_text


   
