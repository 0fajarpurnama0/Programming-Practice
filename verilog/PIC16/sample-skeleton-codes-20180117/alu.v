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
       ...   :  ...                    ;
       ...   :  ...                    ;
       default: bit_mask = 8'bxxxx_xxxx;
     endcase
   
   always @( CB or FI or W or HC or CI or bit_mask or sub )
     begin
	HC = 1'b0;
	case( CB )
	  `IPSW: tmp = ... // Pass W register value
	  `ICLR: tmp = ... // Clear
	  `IADD, `ISUB:
	    begin
               { HC, tmp[3:0] }= ... + sub;
		     tmp[8:4]  = ... + HC;
            end
	  `IDEC1, `IDEC2:
                 tmp = ... ; // Decrement, Decrement and skip if 0
	  `IOR : tmp = ... ; // Logical OR  
	  `IAND: tmp = ... ; // Logical AND
	  `IXOR: tmp = ... ; // Logical Exclusive OR
	  `IPSF: tmp = { 1'b0,  FI }; // Pass FI
	  `INTF: tmp = ... ; // Complement FI
	  `IINC1, `IINC2:
                 tmp = ... ; // Increment, Increment and skip if 0
	  `IRRF: tmp = ... ; // Rotate Right through Carry	  
	  `IRLF: tmp = ... ; // Rotate Left through Carry	  
	  `ISWP: tmp = ... ; // nibble swap
	  `IBCF: tmp = ... ; // bit clear
	  `IBSF: tmp = ... ; // bit set
	  `IBTF: tmp = ... ; // bit test
	  default: tmp = 9'bx_xxxx_xxxx;
	endcase
     end

   // FO
   assign FO = ... ;

   // W Register
   always @( posedge CLK )
     if( ... ) W <= ... ;
   
   // Flag
   assign CO = ... ; // Carry/Borrow flag
   assign DC = ... ; // Half carry flag
   assign Z  = ... ; // Zero flag
   
endmodule
