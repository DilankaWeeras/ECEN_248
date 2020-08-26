`timescale 1ns / 1ps
//`default_nettype none

module sr_latch(Q, notQ, En, S, R);
//
    output wire Q, notQ; // delcare output wires
    input wire En, S, R; // declare intput wires
  //  
    wire nandSEn, nandREn; // decalre internal nets
    
    nand #2 nand0(nandSEn, En, S); // set nand En
    nand #2 nand1(nandREn, En, R); // set nand Reset
    
    nand #2 nand2(Q, nandSEn, notQ); // set Q
    nand #2 nand3(notQ, nandREn, Q); // set notQ
    
endmodule
    
    