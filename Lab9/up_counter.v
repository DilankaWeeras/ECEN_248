`timescale 1ns/ 1ps
//`default_nettype none


module up_counter(Count, Carry2, En, Clk, Rst);

    output reg[2:0] Count; // declare register
    output wire Carry2; // declare the carry out 
    
    input wire En, Clk, Rst; // declare input variables
    
    wire [2:0] Carry, Sum; // interior nets
    
    Threebit_counter UCL(Sum,Carry2,Count,En); // use the trhree bit counter to count
    
    always@(posedge Clk or posedge Rst) // This is what deternimes the count
        if(Rst) 
            Count <= 0;
        else
            Count <= Sum;
            
endmodule

module Threebit_counter(Sum, Carry2, Count, En);

    input wire En; // declare input variables
    input wire [2:0] Count; // 
    
    output wire [2:0] Sum; // delcare output variables
    output wire Carry2;
    wire [2:0] Carry;
    // Use three half adders to make full counter
    half_adder half1(Sum[0],Carry[0],Count[0],En); 
    half_adder half2(Sum[1],Carry[1],Count[1],Carry[0]);
    half_adder half3(Sum[2],Carry[2],Count[2],Carry[1]);
    // The carry 2 is assigned to carry out
    assign Carry2 = Carry[2];
    
endmodule
    