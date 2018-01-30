module nonblocking ( CLK, RST, Q );
  input RST, CLK;
  output [2:0] Q;

  reg [2:0] tmp;
  always @(posedge RST or posedge CLK)
    begin
      if (RST) tmp <= 3'b001; else
        begin
          tmp[1] <= tmp[0];
	  tmp[2] <= tmp[1];
	  tmp[0] <= tmp[2];
	end
    end

  assign Q = tmp;
endmodule
