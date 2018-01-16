module 2to1multiplexer(A, B, S, Y)
  input A, B, S;
  output Y;

  reg Y;

  always @( A or B or S )
  begin
    case( S )
    1'b0: Y <= A;
    1'b1: Y <= B;
    default: Y <= 1'bX;
    endcase
  end
endmodule
