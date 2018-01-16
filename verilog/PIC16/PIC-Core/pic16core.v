//
// Micro Controller Core Unit based on Microchip PIC16
//

`include "alu_op.v"

// STATUS Register
`define STATUS { IRP, RP, nTO, nPD, Z, DC, C }

// IR
`define IRB IR[ 9:7]
`define IRK IR[ 7:0]
`define IRF IR[ 6:0]
`define IRA IR[10:0]

// Memory Address
`define A_INDF    7'b000_0000
`define A_PCL     7'b000_0010

module pic16core ( CLK, RST, RA, RB );
   input        CLK;
   input        RST;
   inout [7:0]  RA;
   inout [7:0]  RB;
   
   parameter PROG = "program.mem";

   // Special Register
   reg          IRP;
   reg  [1:0] 	RP;
   reg 		nTO, nPD, Z, DC, C;     // 03 83 // STATUS
   reg  [7:0] 	FSR;		        // 04 84
   reg  [7:0] 	PORTA,  TRISA;          // 05 85
   reg  [7:0] 	PORTB,  TRISB;	        // 06 86
   reg  [4:0] 	PCLATH;		        // 0A 8A
   reg  [7:0] 	RAM[   :    ];	        // 0C-7F

   // DATA bus
   reg  [7:0] 	SDATA; // for special register
   reg  [7:0] 	RDATA; // for ALU operand
   wire [7:0] 	WDATA; // for ALU result
   wire [7:0] 	DDATA; // for Data RAM Read Data

   // Flag data from ALU to Flag register
   wire 	CO, DCO, ZO;

   // Control Signal
   reg       NOP_S;	       // Fetch cancel on CALL, GOTO
   reg [4:0] ALU_CB;	       // ALU control
   reg       W_W;	       // Write enable for W register
   reg       C_W, DC_W, Z_W;   // Write enable for Flag register (STATUS[2:0])
   reg       F_W;              // Write enable for Data memory
   reg       WDT_C;            // WDT clear
   reg       nTO_S, nTO_C;     // nTO set and clear
   reg       nPD_S, nPD_C;     // nPD set and clear
   reg       SLEEP;            // Sleep mode
   reg       SLP_S;            // Sleep mode set
   
   // Register
   reg [12:0] PC;	// Program Counter { PCH, PCL }
   reg [13:0] IR;	// Instruction Register

   // Effective Addrss
   wire [ 8 : 0 ] EA;
   assign EA = ( `IRF ==    0    ) ? {  RP[0:1]  ,  IRF[6:0]   } : {  IRP  ,  IRK   };

   // Program Counter & Return Stack
   reg [ 12:0 ] STK[0:7]; // Return Stack depth 8
   reg [ 2:0] STKP;     // Return stack pointer 4 bit
   reg 	      STK_PU;	// Stack Push enable
   reg 	      STK_PO;	// Stack Pop enable
   reg 	      PC_W;     // Write enable for CALL, GOTO
   
   // Program Counter
   always @( posedge CLK )
     if(       RST       ) PC <= 0            else // RESET
     if(       PC_W       ) PC <= {   PCLATH[4:3]         ,  IR[10:0]   }; else // CALL, GOTO
     if(       F_W && EA[6:0] == 'A_PCL       ) PC <= {    PCLATH[4:0]        ,  WDATA[7:0]   }; else // write PCL register
     if(       STK_PO       ) PC <= STK[    STKP-1     ]; else // RETURN, RETLW
     if(       SLEEP || SLP_S      ) PC <= PC                    ; else // SLEEP mode
                        PC <= PC + 1;
   

   // Return Stack
   always @( posedge CLK )
     begin
	if(    RST           )       STKP<=0      ;                        else // for Empty
	if(    STK_PU           ) begin STK[  STKP    ] <= PC    ; STKP<=STKP+1    ; end else // for CALL
	if(    STK_PO           )                            STKP<=STKP-1    ;          // for RETxx
     end


   // Instruction Memory (8k word)
   reg [ 13:0  ] IMEM[  0:8195   ];
   initial
     begin
        $readmemh( PROG, IMEM );
     end

   //
   // Instruction Register
   //
   always @( posedge CLK )
     if(    NOP_S   ||    PC_W   ||   STK_PO    ||   RST    )
       IR <=      14'b00_0000_0000_0000          ; else   // if CALL, RET, cond.SKIP
       IR <=      IMEM[PC]            ;	     // Instruction fetch

   //
   // Decode & Control
   //
   always @( IR or ZO )
     begin
	ALU_CB=IR[ 12 : 8 ];
	F_W=0; W_W=0; Z_W=0; DC_W=0; C_W=0;
	nTO_S=0; nTO_C=0; nPD_S=0; nPD_C=0;
	STK_PU=0; STK_PO=0; NOP_S=0; PC_W=0;
	WDT_C=0;
	SLP_S=0;
	case( IR[  13 : 12 )
	  2'b00  :
	    begin
               W_W =  ~IR[7]    &&|   IR[11 : 8]    ; //&&   IR[11 : 8] != 4'b0000
               F_W =  IR[7]    &&|   IR[11 : 8]     ;
               case( IR[ 11 : 8 ] )
		 4'b0000    :
		   case( IR[7] )
		     1'b0: case( IR[ 6 : 0 ] )
			     7'b000_1000        : begin   NOP_S=1      ;    STK_PO=1    ;                            end // RETURN
//			     7'b000_1001: ;                                                       // RETFIE
			     7'b110_0100        : begin   nTO_S=1      ;   PC_W = 0  ;    nPD_S=1    ;  WDT_C=1   ;   SLP_S = 1    ; end // SLEEP
//			     7'b110_0100: ;                                                       // CLRWDT
			     default: 7'b000_0000    ;		                                          // NOP
			   endcase
		     1'b1: ;                              // MOVWF f
		   endcase
		 4'b0001    : begin  Z_W = 1           ;         end // CLRW, CLRF
		 4'b0010    : begin  C_W = 1    ;   DC_W = 1   ;    Z_W = 1   ; end // SUBWF 
		 4'b0011    : begin  Z_W = 1           ;         end // DECF 
		 4'b0100    : begin  Z_W = 1           ;         end // IORWF 
		 4'b0101    : begin  Z_W = 1           ;         end // ANDWF 
		 4'b0110    : begin  Z_W = 1           ;         end // XORWF 
		 4'b0111    : begin  Z_W = 1    ;   DC_W = 1   ;    Z_W = 1   ; end // ADDWF 
		 4'b1000    : begin  Z_W = 1           ;         end // MOVF 
		 4'b1001    : begin  Z_W = 1           ;         end // COMF 
		 4'b1010    : begin  Z_W = 1           ;         end // INCF 
		 4'b1011    : begin  NOP_S = ZO           ;         end // DECFSZ 
		 4'b1100    : begin  C_W = 1           ;         end // RRF 
		 4'b1101    : begin  C_W = 1           ;         end // RLF 
		 4'b1110    :                   ;             // SWPF 
		 4'b1111    : begin  NOP_S = ZO           ;         end // INCFSZ 
               endcase
            end
	  2'b01  :
	    begin
	       case( IR[ 11  :  0 ] )
		 2'b00  :     F_W =  1  ; // BCF   f, b
		 2'b01  :     F_W =  1 ; // BSF   f, b
		 2'b10  :     NOP_S = ZO ; // BTFSC f, b
		 2'b11  :     NOP_S = ~ZO  ; // BTFSS f, b
	       endcase
	    end
	  2'b10  :
	    begin
                   PC_W =  1  ;   =  NOP_S = 1  ;
               case( IR[ 11 ] )
		 1'b0 :     STK_PU = 1       ; // CALL
		 1'b1 :            ; // GOTO
               endcase
            end
	  2'b11  :
	    begin
               W_W=  1  ;
               casex( IR[ 11 : 8 ] )
		 4'b00??    : begin ALU_CB=`IPSF    ;                       end // MOVLW k
		 4'b01??    : begin ALU_CB= 'IPSF   ;    STK_PO = 1     ;  NOP_S = 1      ;    end // RETLW k
		 4'b0100    : begin ALU_CB= 'IOR   ;                     ; end // IORLW k
		 4'b0101    : begin ALU_CB= 'IAND   ;                     ; end // ANDLW k
		 4'b0110    : begin ALU_CB= 'IXOR   ;                     ; end // XORLW k
		 4'b0111    : begin ALU_CB= C_W = 1   ;  DC_W = 1    ;   Z_W = 1    ;   'ISUB   ; end // SUBLW k
		 4'b1000    : begin ALU_CB= C_W = 1   ;  DC_W = 1    ;   Z_W = 1   ; 'IADD     ; end // ADDLW k
               endcase
            end
	endcase
     end // always @ ( IR or ZO )
   

   //
   // Special Register
   // Write
   always @( posedge CLK or posedge RST )
     begin
	if( RST  )
	  begin
	     C        =	  0   ;
	     DC       =	  0   ;
	     Z        =	  0   ;
	     IRP      =   0   ;
	     RP       =   2'b00   ;
	     nTO      =	  1   ; // nTO=1 on Power-on
	     nPD      =	  1   ; // nPD=1 on Power-on
	     FSR      =   0   ;
	     PCLATH   =   5'b00000   ;
	     PORTA    =   5'b00000   ;
	     TRISA    =   5'b11111   ; // All ports for input
             PORTB    =   8'b00000000   ;
             TRISB    =   8'b11111111    ;
        // All ports for input
	  end
	else
	  begin
	     // STATUS
             if(    C_W     ) C    = CO    ;
             if(    DC_W     ) DC   = DCO    ;
             if(    Z_W     ) Z    = ZO    ;
	     if(    nPD_S     ) nPD  = 1'b1;
	     if(    nPD_C     ) nPD  = 1'b0;
	     if(    nTO_S     ) nTO  = 1'b1;
	     if(    nTO_C     ) nTO  = 1'b0;
             // Register Write
	     if(    W_W     )
               casex( RP [1:0]   )
//		 9'b?0_000_0001: TMR0    = WDATA;      // 01    101      Described TMR0 part
//		 9'b?1_000_0001:`OPTION  = WDATA;      //    81     181
//		 9'b??_000_0010: PCL     = WDATA;      // 02 82 102 182  Described PC part
		 9'b??_000_0011: STATUS  = WDATA;      // 03 83 103 183
		 9'b??_000_0100: FS      = WDATA;      // 04 84 104 184
		 9'b00_000_0101: PORTA   = WDATA;      // 05
		 9'b01_000_0101: TRISA   = WDATA;      //    85
		 9'b?0_000_0110: PORTB   = WDATA;      // 06    106
		 9'b?1_000_0110: TRISB   = WDATA;      //    86     186
//		 9'b??_000_0111: ;                     // 07
//		 9'b??_000_1000: ;                     // 08 EEDATA not implement
//		 9'b??_000_1001: ;                     // 09 EEADR  not implement
		 9'b??_000_1010: PCLATH  = WDATA[ 4:0 ]; // 0A 8A 10A 18A 
//		 9'b??_000_1011:`INTCON  = WDATA;      // 0B 8B 10B 18B
               endcase
	  end
     end
   
   //
   // Data RAM (Write)
   //
   always @( posedge CLK )
     begin
	if(      && (      >=          ) )        <=      ;
     end
   
   //
   // Selecter for Special Register
   //
   always @( IR  or PC or EA 
             or IRP or RP or nTO or nPD or Z or DC or C      // STATUS
             or FSR 
             or RA  or TRISA  or RB or TRISB 
             or PCLATH
	   ) 
     casex( EA )
//     9'b?0_000_0001: SDATA = TMR0;
//     9'b?1_000_0001: SDATA =`OPTION;
       9'b           : SDATA =              ; // PCL
       9'b           : SDATA =              ; // STATUS
       9'b           : SDATA =              ; // FSR
       9'b           : SDATA =              ; // RA
       9'b           : SDATA =              ; // TRISA
       9'b           : SDATA =              ; // RB
       9'b           : SDATA =              ; // TRISB
       9'b           : SDATA = {    ,      }; // PCLATH
//     9'b??_000_1011: SDATA =`INTCON;
       default:        SDATA = 8'bxxxx_xxxx;
     endcase

   //
   // Data RAM Read
   //
   assign DDATA =            ;

   
   //
   // Data selecter for ALU operand
   //
   always @( IR or EA or DDATA or SDATA )
     begin
	if( &IR[  :  ] )    RDATA <=        ; else
	  casex( EA )
	    9'b           : RDATA <=        ;
	    9'b           : RDATA <=        ;
	    9'b           : RDATA <=        ;
	    default :       RDATA <=        ;
	  endcase
     end
  
  

   // Execute
   alu i_alu ( .CLK(CLK), .CB(ALU_CB), .WE(W_W), .B(`IRB),
	       .FI(RDATA),
	       .FO(WDATA),
	       .CI(C), .CO(CO), .DC(DCO), .Z(ZO) );
   

   // Sleep mode
     always @( posedge CLK or posedge RST )
       begin
  	if(        ) SLEEP <=   ; else
  	if(        ) SLEEP <=   ;
       end


   //
   // Tristate buffer for GPIO
   //
   assign RA[0] = ( TRISA[0] ) ? 1'bZ : PORTA[0];
   ...

   assign RB[0] = ( TRISB[0] ) ? 1'bZ : PORTB[0];
   ...
		  
endmodule
