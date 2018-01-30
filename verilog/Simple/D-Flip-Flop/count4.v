module count4 ( D, WE, INC, RST, Q, CLK );
  input [3:0] D;
  input WE, RST, CLK;
  output [3:0] Q;

  reg [3:0] tmp;
  always @(posedge RST or posedge CLK)
    begin
      if (RST == 1) tmp <= 4'h00; else
      if (WE == 1)  tmp <= D; else
      if (INC == 1) tmp <= tmp + 1; 
    end

  assign Q = tmp;
endmodule
