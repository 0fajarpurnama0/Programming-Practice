module dff ( D, Q, CLK );
  input D;
  input CLK;
  output Q;

  reg Q;
  always @( posedge CLK )
    begin
      Q <= D;
    end

endmodule
