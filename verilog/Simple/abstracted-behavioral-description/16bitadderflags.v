module adder ( A, B, Y )
  input
  [15:0] A, B;
  output [15:0] Y;
  
  wire [15:0] A, B, Y;
  wire [16:0] TMP;
  wire S, Z, C;

  assign TMP = {1'b0, A} + {1'b0, B};
  assign Y = TMP[15:0];
  assign S = TMP[15];
  assign Z = ~| TMP[15:0;
  assign C = TMP[16];
endmodule
