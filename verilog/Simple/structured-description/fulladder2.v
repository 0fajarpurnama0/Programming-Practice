module fulladder ( A, B, Cin, S ,Cout );
  input A, B, Cin;
  output S, Cout;

  // Internal wires
  wire  Temp_S, Temp_C1, Temp_C2;

  assign Cout = Temp_C2 | Temp_C1;

  halfadder hf1 ( .A(A), .B(B), .S(Temp_S), .C(Temp_C1) );
  halfadder hf2 ( .A(Temp_S), .B(Cin), .S(S), .C(Temp_C2) );
endmodule
