`timescale 1ns / 1ps
//`default_nettype none

module d_flip_flop(Q, notQ, Clk, D);

    output wire Q, notQ; // declare output variables
    input wire Clk, D; // declare input variables
    
    wire notClk, Qm, notQm; // delcare interal nets
    
    not not0(notClk, Clk); // assign not clock
    
    d_latch latch0(Qm, notQm, notClk, D); // assign Qm
    d_latch latch1(Q, notQ, Clk, Qm); // assign Q
    
endmodule