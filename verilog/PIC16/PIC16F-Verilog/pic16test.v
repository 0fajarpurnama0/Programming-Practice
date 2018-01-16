`timescale 1ns/1ns

module pic16test;

reg         CLK;
reg        nRST;
reg         INT;
wire [7:0] RA;
wire [7:0] RB;

initial
begin
  CLK = 0;
  while(1) CLK = #5 ~CLK;
end

initial
begin
   INT = 1;
  nRST = 0;
  nRST = #100 1;
  #2000000;
  $finish;
end

initial
begin
  INT = 0;
  INT = #10000 1; 
  INT = #  500 0; 
  INT = #10000 1; 
  INT = #  500 0; 
  INT = #10000 1; 
  INT = #  500 0; 
  INT = #10000 1; 
  INT = #  500 0; 
  INT = #10000 1; 
  INT = #  500 0; 
  INT = #10000 1; 
  INT = #  500 0; 
  INT = #10000 1; 
  INT = #  500 0; 
  INT = #1_000_000 1; 
end

data_alias da ( RA, 8'ha5 );

initial
begin
  $shm_open("waves.shm");
  $shm_probe("as");
end


pic16 #( .PROG("inttest.mem") )
  i_pic16 ( .CLK(CLK), .nRST(nRST), .INT(INT), .RA(RA), .RB(RB) );


endmodule

module data_alias( alias_sig_o, alias_sig_i);
input  [7:0] alias_sig_i;
output [7:0] alias_sig_o;

assign alias_sig_o = alias_sig_i;
endmodule
