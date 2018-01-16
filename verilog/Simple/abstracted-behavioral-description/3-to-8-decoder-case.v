module decoder (din, dout);
  input [2:0] din;
  output [7:0] dout;
  reg [7:0] dout;

  always @( din )
  begin 
    case ( din )
    3'b000: dout <=8'b0000_0001;
    3'b001: dout <=8'b0000_0010;
    3'b010: dout <=8'b0000_0100;
    3'b011: dout <=8'b0000_1000;
    3'b100: dout <=8'b0001_0000;
    3'b101: dout <=8'b0010_0000;
    3'b110: dout <=8'b0100_0000;
    3'b111: dout <=8'b1000_0000;
    default:dout <=8'bXXXX_XXXX;
    endcase
  end

endmodule
