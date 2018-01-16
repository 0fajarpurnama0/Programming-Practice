module 4to1multiplexer(A, B, C, D, S, Y)
  input(A, B, C, D, S);
  output(Y);

  reg Y;
  always @(A or B or C or D or S)
  begin
    case(S)
    2'b00: Y<=A;
    2'b01: Y<=B;
    2'b10: Y<=C;
    2'b11: Y<=D;
    default: Y<=1'bX;
    endcase
  end
endmodule

