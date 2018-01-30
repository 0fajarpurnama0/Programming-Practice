module dff ( D, Q, CLK );
  input D;
  input CLK;
  output Q;

  reg tmp; //for register
  always @( posedge CLK )
    begin
      tmp <= D;
    end

  assign Q = tmp;
endmodule
