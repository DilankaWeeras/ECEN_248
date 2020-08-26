`timescale 1ns / 1ps
//`default_nettype none

module d_latch(Q, notQ, En, D);
    
    output wire Q, notQ; //decalre output variables
    input wire En, D; // declare input variables
    
    wire nandDEn, notD, nandDEnNot; // declare internal nets
    
    not #2 not0(notD,D); //set notD
    
    nand #2 nand0(nandDEn, D, En); // set net 1
    nand #2 nand1(nandDEnNot, notD, En); // set net 2
    
    nand #2 nand2(Q, nandDEn, notQ); // set Q
    nand #2 nand3(notQ, nandDEnNot, Q); // set notQ
    
endmodule