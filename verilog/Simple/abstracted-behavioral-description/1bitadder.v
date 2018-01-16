module adder ( A, B, S, C )
  input
  A, B;
  output C, S;
  assign {C,S} = A + B;
endmodule
