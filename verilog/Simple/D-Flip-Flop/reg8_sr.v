module reg8_sr ( D, WE, Q, CLK );
  input [7:0] D;
  input WE, RST, CLK;
  output [7:0] Q;

  reg [7:0] tmp;
  always @(posedge CLK)
    begin
      if (RST) tmp <= 8'h00; else
      if (WE)  tmp <= D; 
    end

  assign Q = tmp;
endmodule
