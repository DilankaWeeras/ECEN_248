`timescale 1ns / 1ps
`default_nettype none


module two_one_mux(Y, A, B, S);

    //output variables
    output wire Y;
    //input variables
    input wire A, B, S;
    
    // internal nets
    wire notS;
    wire andA;
    wire andB;
    
    not not0(notS, S); //creates S'
    and and0(andA, notS, A); //creates AS'
    and and1(andB, S, B); //creates BS
    or  or0(Y, andA, andB); // AS' + BS
    
endmodule //end