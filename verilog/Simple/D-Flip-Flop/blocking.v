module bcd_addr ( A, B, S, C );
  input [3:0] A, B;
  output [3:0] S;
  output       C: // Carry
  reg [4:0] tmp;
  always @(A or B)
    begin
      tmp = {1'b0, A} + {1'b0, B};
      if( tmp >= 5'b01010)
          tmp = tmp + 5'b00110;
    end

  assign S = tmp[3:0];
  assign C = tmp[4];
endmodule
