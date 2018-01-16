module adder ( A, B, S )
  input
  [15:0] A, B;
  output [15:0] S;
  assign S = A + B;
endmodule
