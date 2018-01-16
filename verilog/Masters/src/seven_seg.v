module seven_seg ( BCD, SEG );
  input  [3:0] BCD;
  output [7:0] SEG;
  reg    [7:0] SEG;

  always @( BCD )
    case( BCD )
    4'b0000 : SEG <= 8'b11111100; // 0
    4'b0001 : SEG <= 8'b01100000; // 1
    4'b0010 : SEG <= 8'b11011010; // 2
    4'b0011 : SEG <= 8'b11110010; // 3
    4'b0100 : SEG <= 8'b01100110; // 4
    4'b0101 : SEG <= 8'b10110110; // 5
    4'b0110 : SEG <= 8'b10111110; // 6
    4'b0111 : SEG <= 8'b11100000; // 7
    4'b1000 : SEG <= 8'b11111110; // 8
    4'b1001 : SEG <= 8'b11110110; // 9
    default : SEG <= 8'bXXXXXXXX; // Don't care
    endcase
endmodule