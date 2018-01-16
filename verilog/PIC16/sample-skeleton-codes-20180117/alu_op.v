//
// Control code for PIC16 ALU
//
`define IPSW  5'b00000 // Pass W
`define ICLR  5'b00001 // Clear
`define ISUB  5'b00010 // Sub
`define IDEC1 5'b00011 // Dec
`define IOR   5'b00100 // Or
`define IAND  5'b00101 // And
`define IXOR  5'b00110 // Xor
`define IADD  5'b00111 // Add
`define IPSF  5'b01000 // Pass F
`define INTF  5'b01001 // Not
`define IINC1 5'b01010 // Inc
`define IDEC2 5'b01011 // Dec
`define IRRF  5'b01100 // Rotate Right with carry
`define IRLF  5'b01101 // Rotate Left with carry
`define ISWP  5'b01110 // Nibble swap
`define IINC2 5'b01111 // Inc
`define IBCF  5'b100?? // Bit Clear F
`define IBSF  5'b101?? // Bit Set F
`define IBTF  5'b11??? // Bit Test F
