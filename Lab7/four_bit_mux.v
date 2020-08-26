`timescale 1ns / 1 ps
`default_nettype none

module four_bit_mux(
                    output reg [3:0] Y, // declare output variables
                    input wire [3:0] A, B, // declare input wires for numbers
                    input wire S); // declare input wire for choose
                    
    // call two one mux 4 times for each vaiable
    two_one_mux mux0(Y[0],A[0],B[0],S); 
    two_one_mux mux1(Y[1],A[1],B[1],S);
    two_one_mux mux2(Y[2],A[2],B[2],S);
    two_one_mux mux3(Y[3],A[3],B[3],S);
    
endmodule
    
    
    
    
    