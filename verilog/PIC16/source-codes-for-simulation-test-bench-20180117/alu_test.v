`timescale 1ns/1ns

`include "alu_op.v"

module alu_test;

   reg  [7:0] FI;
   reg  [2:0]  B;
   reg  [4:0]  CB;
   reg 	       CLK, WE, CO;

   wire [7:0]  FO;
   wire        DC, CI, Z;
   
   
   initial
     begin
	$shm_open("waves.shm");
	$shm_probe("as");
     end

   `include "alu_test.vct"

   alu alu1 ( .CLK(CLK), .CB(CB), .WE(WE), .B(B),
                .FI(FI), .FO(FO), .CI(CO), .CO(CI), .DC(DC), .Z(Z) );

   always @( posedge CLK )
     CO <= CI;
   
endmodule
