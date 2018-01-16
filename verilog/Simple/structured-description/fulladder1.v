module fulladder (A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;

  // Internal wires
  wire Temp_S, Temp_C1, Temp_C2;
  
  assign Cout = Tmep_C2 | Temp_C1;
  
  halfadder hf1 (A, B, Temp_S, Temp_C1);
  halfadder hf2 (Temp_S, Cin, S, Temp_C2);
endmodule
