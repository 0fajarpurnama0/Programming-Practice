module sevenseg(BCD, SEG);
  input  [3:0] BCD;
  output [7:0] SEG;
  reg    [7:0] SEG;
  always @( BCD )
    case( BCD )
    4'h0 : SEG <= 8'b11111100; // 0
    4'h1 : SEG <= 8'b01100000; // 1
    4'h2 : SEG <= 8'b11011010; // 2
    4'h3 : SEG <= 8'b11110010; // 3
    4'h4 : SEG <= 8'b01100110; // 4
    4'h5 : SEG <= 8'b10110110; // 5
    4'h6 : SEG <= 8'b10111110; // 6
    4'h7 : SEG <= 8'b11100000; // 7
    4'h8 : SEG <= 8'b11111110; // 8
    4'h9 : SEG <= 8'b11110110; // 9
    default : SEG <= 8'bXXXXXXXX; // Don't care
    endcase
  endmodule
