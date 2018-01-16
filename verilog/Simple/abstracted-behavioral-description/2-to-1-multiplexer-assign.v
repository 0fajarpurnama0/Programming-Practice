module 2to1multiplexer(A, B, S, Y)
  input A, B, S;
  output Y;

  assign Y = (S == 0) ? A : B;
endmodule
  
