module led_drv ( CLK, RST, CE, TIME, BCD, DIGIT );
  input         CLK; 
  input         RST; 
  input         CE; //clock enable
  input  [31:0] TIME;
  output  [3:0] BCD;
  output  [7:0] DIGIT;

  reg [7:0] DIGIT;
  reg [2:0] cnt;
  reg [3:0] BCD;

  always @( posedge CLK or posedge RST )
    if( RST ) cnt <= 3'b000;   else
    if( CE ) cnt <= cnt + 3'd1;

  always @( cnt )
   begin
    case( cnt )
    3'b000 : DIGIT <= 8'b0000_0001;
    3'b001 : DIGIT <= 8'b0000_0010;
    3'b010 : DIGIT <= 8'b0000_0100;
    3'b011 : DIGIT <= 8'b0000_1000;
    3'b100 : DIGIT <= 8'b0001_0000;
    3'b101 : DIGIT <= 8'b0010_0000;
    3'b110 : DIGIT <= 8'b0100_0000;
    default: DIGIT <= 8'b1000_0000;
    endcase
   end

  always @( cnt or BCD or TIME )
   begin
    case( cnt )
    3'b000  : BCD <= TIME[ 3: 0]; // msl
    3'b001  : BCD <= TIME[ 7: 4]; // msh
    3'b010  : BCD <= TIME[11: 8]; // sl
    3'b011  : BCD <= TIME[15:12]; // sh
    3'b100  : BCD <= TIME[19:16]; // ml
    3'b101  : BCD <= TIME[23:20]; // mh
    3'b110  : BCD <= TIME[27:24]; // hl
    default : BCD <= TIME[31:28]; // hh
    endcase
   end
endmodule
