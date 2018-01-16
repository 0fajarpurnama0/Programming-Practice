module seven_seg(din,dout);
input [3:0] din;
output [7:0] dout;

reg [7:0] dout;

always @( din )
  begin
    case ( din )
    4'b0000:dout<=8'b11111100;
    4'b0001:dout<=8'b01100000;
    4'b0010:dout<=8'b11011010;
    4'b0011:dout<=8'b11110010;
    4'b0100:dout<=8'b01100110;
    4'b0101:dout<=8'b10110110;
    4'b0110:dout<=8'b10111110;
    4'b0111:dout<=8'b11100000;
    4'b1000:dout<=8'b11111110;
    4'b1001:dout<=8'b11100110;
    4'b1010:dout<=8'b11101100;
    4'b1100:dout<=8'b11111110;
    4'b1101:dout<=8'b10011100;
    4'b1110:dout<=8'b10011110;
    4'b1111:dout<=8'b10001110;
    default:dout<=8'bXXXXXXXX;
    endcase
  end
endmodule
