module dff ( D, Q, CLK, RST );
  input D, CLK, RST;
  output Q;

  reg tmp;
  always @( posedge RST or posedge CLK)
    begin
      if (RST) tmp <= 1'b0; else
               tmp <= D;
    end

  assign Q = tmp;
endmodule
