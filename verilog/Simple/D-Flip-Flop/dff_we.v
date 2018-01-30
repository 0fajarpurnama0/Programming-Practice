module dff_we ( D, WE, Q, CLK );
  input D, WE, CLK;
  output Q;

  reg tmp;
  always @(posedge CLK)
    begin
      if (WE) tmp <= D; 
   end

  assign Q = tmp;
endmodule
