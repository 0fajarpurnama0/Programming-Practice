module reg8_ar ( D, WE, Q, CLK );
  input [7:0] D;
  input WE, RST, CLK;
  output [7:0] Q;

  reg [7:0] tmp;
  always @(posedge RST or posedge CLK)
    begin
      if (RST) tmp <= 8'h00; else
      if (WE)  tmp <= D; 
    end

  assign Q = tmp;
endmodule
