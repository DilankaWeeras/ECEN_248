`timescale 1ns / 1ps
`default_nettype none

module add_sub(

    output wire [3:0] Sum,
    output wire Overflow,
    
    input wire [3:0] opA, opB,
    input wire opSel
    );
    
    // declare internal nets
    wire [3:0] notB;
    wire c0, c1, c2, c3;
    
    // XOR the b value with the sub to give 2's C or normal numbers
    assign notB[0] = opB[0] ^ opSel;
    assign notB[1] = opB[1] ^ opSel;
    assign notB[2] = opB[2] ^ opSel;
    assign notB[3] = opB[3] ^ opSel;
    
    //adding the two numbers or the 2's complement
    full_adder adder0(Sum[0], c0, opA[0],notB[0], opSel);
    full_adder adder1(Sum[1], c1, opA[1],notB[1], c0);
    full_adder adder2(Sum[2], c2, opA[2],notB[2], c1);
    full_adder adder3(Sum[3], c3, opA[3],notB[3], c2);
    
    //overflow detection logic
    assign Overflow = c3 ^ c2;
    
endmodule
    
    