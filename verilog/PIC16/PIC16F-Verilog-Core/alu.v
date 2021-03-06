//
// ALU for PIC16
//
//   Adder conscists of cascade 2 4-bit adders
//   SUB is calculated by adder using 2's complement feature
//

`include "alu_op.v"

module alu ( CLK, CB, WE, B, FI, FO, CI, CO, DC, Z );
   input        CLK;// Clock
   input  [4:0]	CB; // operation code
   input        WE; // Write enable for W register
   input  [2:0]	B;  // bit position
   input  [7:0]	FI; // operand
   output [7:0] FO; // dest bus
   input        CI; // Carry in
   output       CO; // Carry out
   output       DC; // Half carry
   output       Z;  // Zero

   reg 		HC; // half carry
   reg [7:0]  W;
   reg [8:0]  tmp;
   reg [7:0]  bit_mask;
   wire       sub;

   assign sub = ( CB == `ISUB );

   // Bit mask for bit oriented operation
   always @( B )
     case( B )
       3'b000:  bit_mask = 8'b0000_0001; 
       3'b001:  bit_mask = 8'b0000_0010;
       3'b010:  bit_mask = 8'b0000_0100;
       3'b011:  bit_mask = 8'b0000_1000;
       3'b100:  bit_mask = 8'b0001_0000;
       3'b101:  bit_mask = 8'b0010_0000;
       3'b110:  bit_mask = 8'b0100_0000;
       3'b111:  bit_mask = 8'b1000_0000;
       default: bit_mask = 8'bxxxx_xxxx;
     endcase
   
   always @( CB or FI or W or HC or CI or bit_mask or sub )
     begin
	HC = 1'b0;
	casex( CB )
	  `IPSW: tmp = { 1'b0,  W }; // Pass W register value
	  `ICLR: tmp = 9'b0_0000_0000; // Clear
	  `IADD, `ISUB:
	    begin
               { HC, tmp[3:0] }= {1'b0,FI[3:0]} + {1'b0, sub? ~W[3:0]:W[3:0]} + sub;
		     tmp[8:4]  = {1'b0,FI[7:4]} + {1'b0, sub? ~W[7:4]:W[7:4]} + HC;
            end
	  `IDEC1, `IDEC2:
                 tmp = { 1'b0,  FI } - 1 ; // Decrement, Decrement and skip if 0
	  `IOR : tmp = { 1'b0,  FI } | { 1'b0,  W } ; // Logical OR  
	  `IAND: tmp = { 1'b0,  FI } & { 1'b0,  W } ; // Logical AND
	  `IXOR: tmp = { 1'b0,  FI } ^ { 1'b0,  W } ; // Logical Exclusive OR
	  `IPSF: tmp = { 1'b0,  FI } ; // Pass FI
	  `INTF: tmp = { 1'b0,  ~FI } ; // Complement FI
	  `IINC1, `IINC2:
                 tmp = { 1'b0,  FI } + 1 ; // Increment, Increment and skip if 0
	  `IRRF: tmp = {FI[0], CI, FI[7:1]} ; // Rotate Right through Carry	  
	  `IRLF: tmp = {FI, CI} ; // Rotate Left through Carry	  
	  `ISWP: tmp = {1'b0, FI[3:0], FI[7:4]}; // nibble swap
	  `IBCF: tmp = {1'b0, FI} & {1'b0,~bit_mask} ; // bit clear
	  `IBSF: tmp = {1'b0, FI} | {1'b0, bit_mask} ; // bit set
	  `IBTF: tmp = {1'b0, FI} & {1'b0, bit_mask} ; // bit test
	  default: tmp = 9'bx_xxxx_xxxx;
	endcase
     end

   // FO
   assign FO = tmp[7:0] ;

   // W Register
   always @( posedge CLK )
     if( WE ) W <= tmp[7:0] ;
   
   // Flag
   assign CO = tmp[8] ; // Carry/Borrow flag
   assign DC = HC ; // Half carry flag
   assign Z  = (tmp[7:0] == 0) ; // Zero flag
   
endmodule
