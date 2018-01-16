module priority_encoder (din, dout, en);
  input [9:0] din;
  output [3:0] dout;
  output en;
  reg [3:0] dout;
  reg en;
  always @( din )
  begin
    casex ( din )
    10'b?????_????1: { en, dout } <=5'b1_0000;
    10'b?????_???10: { en, dout } <=5'b1_0001;
    10'b?????_??100: { en, dout } <=5'b1_0010;
    10'b?????_?1000: { en, dout } <=5'b1_0011;
    10'b?????_10000: { en, dout } <=5'b1_0100;
    10'b????1_00000: { en, dout } <=5'b1_0101;
    10'b???10_00000: { en, dout } <=5'b1_0110;
    10'b??100_00000: { en, dout } <=5'b1_0111;
    10'b?1000_00000: { en, dout } <=5'b1_1000;
    10'b10000_00000: { en, dout } <=5'b1_1001;
    default: { en, dout } <=5'b0_XXXX;
    endcase
  end
endmodule
