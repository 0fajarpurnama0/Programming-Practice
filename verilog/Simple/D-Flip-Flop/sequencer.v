`define S0 2'b00 // define states
`define S1 2'b01
`define S2 2'b10
`define S3 2'b11

module sequencer (START, JP, RESET, CLK, RA, RB, TM);
  input START, JP, RESET, CLK;
  output RA, RB, TM;

  reg RA, RB, TM;
  reg [1:10] STATE; // state variable

  //state machine
  always @(posedge RESET or posedge CLK)
  begin
    if(RESET == 1) //asynchronous reset
      STATE <= 'S0;
    else
      case(STATE)
	`S0:if(START == 1) STATE <= `S1; // transition start
	`S1:if(JP == 1)    STATE <= `S3; // jump
		else	   STATE <= `S2;
	`S2:		   STATE <= `S3;
	'S3:		   STATE <= `S0; // become initial state
      endcase
  end

  // control signals
  always @(STATE)
  begin
    RA <= 0;
    RB <= 0;
    TM <= 0;
    case (STATE)
      `S1: begin RA <= 1;		end
      `S2: begin RA <= 1; RB <=1;	end
      `S3: begin 		TM <= 1 end
    endcase
  end

endmodule
