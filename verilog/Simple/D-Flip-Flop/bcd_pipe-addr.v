module bcd_pipe_addr ( CLK, A, B, S, C );
  input [3:0] A, B, CLK;
  output [3:0] S;
  output       C: // Carry
  reg [4:0] tmp1, tmp2;
  always @(posedge CLK)
    begin
      tmp1 <= {1'b0, A} + {1'b0, B};
      if( tmp1 >= 5'b01010)
          tmp2 <= tmp1 + 5'b00110; else
	  tmp2 <= tmp1;
    end

  assign S = tmp2[3:0];
  assign C = tmp2[4];
endmodule
