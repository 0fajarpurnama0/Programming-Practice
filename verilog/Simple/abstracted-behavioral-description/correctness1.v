module correctness(A, B, C, S, Y)
  input (A, B, C,);
  input [1:0] (S);
  output Y;

  reg Y;
  always @( A or B or C or S )
  begin
    case( S )
    2'b00: Y <= A;
    2'b01: Y <= B;
    2'b10: Y <= C;
    default: Y <= 1'b0;
    endcase
  end
endmodule
