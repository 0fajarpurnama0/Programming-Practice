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
   wire [  :  ] EA;
   assign EA = ( `IRF ==        ) ? {    ,     } : {    ,     };

   // Program Counter & Return Stack
   reg [  : ] STK[0:7]; // Return Stack depth 8
   reg [ 2:0] STKP;     // Return stack pointer 4 bit
   reg 	      STK_PU;	// Stack Push enable
   reg 	      STK_PO;	// Stack Pop enable
   reg 	      PC_W;     // Write enable for CALL, GOTO
   
   // Program Counter
   always @( posedge CLK )
     if(              ) PC <=                       else // RESET
     if(              ) PC <= {            ,     }; else // CALL, GOTO
     if(              ) PC <= {            ,     }; else // write PCL register
     if(              ) PC <= STK[               ]; else // RETURN, RETLW
     if(              ) PC <=                     ; else // SLEEP mode
                        PC <= PC + 1;
   

   // Return Stack
   always @( posedge CLK )
     begin
	if(               )       STKP<=      ;                        else // for Empty
	if(               ) begin STK[      ] <=     ; STKP<=    ; end else // for CALL
	if(               )                            STKP<=    ;          // for RETxx
     end


   // Instruction Memory (8k word)
   reg [  :  ] IMEM[  :   ];
   initial
     begin
        $readmemh( PROG, IMEM );
     end

   //
   // Instruction Register
   //
   always @( posedge CLK )
     if(       ||       ||       ||       )
       IR <=                ; else   // if CALL, RET, cond.SKIP
       IR <=                ;	     // Instruction fetch

   //
   // Decode & Control
   //
   always @( IR or ZO )
     begin
	ALU_CB=IR[  :  ];
	F_W=0; W_W=0; Z_W=0; DC_W=0; C_W=0;
	nTO_S=0; nTO_C=0; nPD_S=0; nPD_C=0;
	STK_PU=0; STK_PO=0; NOP_S=0; PC_W=0;
	WDT_C=0;
	SLP_S=0;
	case( IR[   :   ] )
	  2'b  :
	    begin
               W_W =       &&        ;
               F_W =       ;
               case( IR[  :  ] )
		 4'b    :
		   case( IR[ ] )
		     1'b0: case( IR[  :  ] )
			     7'b        : begin         ;        ;                            end // RETURN
//			     7'b000_1001: ;                                                       // RETFIE
			     7'b        : begin         ;        ;        ;        ;        ; end // SLEEP
//			     7'b110_0100: ;                                                       // CLRWDT
			     default:     ;		                                          // NOP
			   endcase
		     1'b1: ;                              // MOVWF f
		   endcase
		 4'b    : begin             ;         end // CLRW, CLRF
		 4'b    : begin      ;      ;       ; end // SUBWF 
		 4'b    : begin             ;         end // DECF 
		 4'b    : begin             ;         end // IORWF 
		 4'b    : begin             ;         end // ANDWF 
		 4'b    : begin             ;         end // XORWF 
		 4'b    : begin      ;      ;       ; end // ADDWF 
		 4'b    : begin             ;         end // MOVF 
		 4'b    : begin             ;         end // COMF 
		 4'b    : begin             ;         end // INCF 
		 4'b    : begin             ;         end // DECFSZ 
		 4'b    : begin             ;         end // RRF 
		 4'b    : begin             ;         end // RLF 
		 4'b    :                   ;             // SWPF 
		 4'b    : begin             ;         end // INCFSZ 
               endcase
            end
	  2'b  :
	    begin
	       case( IR[   :   ] )
		 2'b  :      =   ; // BCF   f, b
		 2'b  :      =   ; // BSF   f, b
		 2'b  :      =   ; // BTFSC f, b
		 2'b  :      =   ; // BTFSS f, b
	       endcase
	    end
	  2'b  :
	    begin
                    =    ;     =    ;
               case( IR[  ] )
		 1'b :            ; // CALL
		 1'b :            ; // GOTO
               endcase
            end
	  2'b  :
	    begin
               W_W=    ;
               casex( IR[  :  ] )
		 4'b    : begin ALU_CB=    ;                       end // MOVLW k
		 4'b    : begin ALU_CB=    ;         ;        ;    end // RETLW k
		 4'b    : begin ALU_CB=    ;                     ; end // IORLW k
		 4'b    : begin ALU_CB=    ;                     ; end // ANDLW k
		 4'b    : begin ALU_CB=    ;                     ; end // XORLW k
		 4'b    : begin ALU_CB=    ;      ;       ;      ; end // SUBLW k
		 4'b    : begin ALU_CB=    ;      ;       ;      ; end // ADDLW k
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
	     C        =	     ;
	     DC       =	     ;
	     Z        =	     ;
	     IRP      =      ;
	     RP       =      ;
	     nTO      =	     ; // nTO=1 on Power-on
	     nPD      =	     ; // nPD=1 on Power-on
	     FSR      =      ;
	     PCLATH   =      ;
	     PORTA    =      ;
	     TRISA    =      ; // All ports for input
             PORTB    =      ;
             TRISB    =      ;
        // All ports for input
	  end
	else
	  begin
	     // STATUS
             if(         ) C    =     ;
             if(         ) DC   =     ;
             if(         ) Z    =     ;
	     if(         ) nPD  = 1'b1;
	     if(         ) nPD  = 1'b0;
	     if(         ) nTO  = 1'b1;
	     if(         ) nTO  = 1'b0;
             // Register Write
	     if(         )
               casex(    )
//		 9'b?0_000_0001: TMR0    = WDATA;      // 01    101      Described TMR0 part
//		 9'b?1_000_0001:`OPTION  = WDATA;      //    81     181
//		 9'b??_000_0010: PCL     = WDATA;      // 02 82 102 182  Described PC part
		 9'b           :         = WDATA;      // 03 83 103 183
		 9'b           :         = WDATA;      // 04 84 104 184
		 9'b           :         = WDATA;      // 05
		 9'b           :         = WDATA;      //    85
		 9'b           :         = WDATA;      // 06    106
		 9'b           :         = WDATA;      //    86     186
//		 9'b??_000_0111: ;                     // 07
//		 9'b??_000_1000: ;                     // 08 EEDATA not implement
//		 9'b??_000_1001: ;                     // 09 EEADR  not implement
		 9'b??_000_1010:         = WDATA[ : ]; // 0A 8A 10A 18A 
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
