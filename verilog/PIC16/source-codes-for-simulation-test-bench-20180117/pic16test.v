`timescale 1ns/1ns

module pic16test;

reg         CLK;
reg        nRST;
wire [7:0] RA;
wire [7:0] RB;

initial
begin
  CLK = 0;
  while(1) CLK = #5 ~CLK;
end

initial
begin
  nRST = 0;
  nRST = #100 1;
  #200000;
  $finish;
end

data_alias da ( RA, 8'ha5 );

initial
begin
  $shm_open("waves.shm");
  $shm_probe("as");
end


pic16 #( .PROG("program.mem") )
   i_pic16 ( .CLK(CLK), .nRST(nRST), .RA(RA), .RB(RB) );


endmodule

module data_alias( alias_sig_o, alias_sig_i);
input  [7:0] alias_sig_i;
output [7:0] alias_sig_o;

assign alias_sig_o = alias_sig_i;
endmodule
