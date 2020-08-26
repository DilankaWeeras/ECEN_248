`timescale 1ns / 1 ps
`default_nettype none

module mux_4bit_4to1(Y,A,B,C,D,S);


    output reg [3:0] Y; // decalre output saved value
    input wire [3:0] A,B,C,D; // declare 4 bit input for mux
    input wire [1:0]S; // declare 2 bit chooser for mux
    
    
    always @(*) // at change in anything
    
    case(S) // case S is 0,1,2,3
    
        2'b00: Y = A; // S = 0
        2'b01: Y = B; // S = 1
        2'b10: Y = C; // S = 2
        2'b11: Y = D; // S = 3
        
    endcase
    
endmodule