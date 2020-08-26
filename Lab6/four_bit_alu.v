`timescale 1ns / 1ps
`default_nettype none

module four_bit_alu(

    output wire [3:0] Result,
    output wire Overflow,
    
    input wire [3:0] opA,opB,
    input wire [1:0] ctrl
    );
    
    wire [3:0] ANDopAB;
    wire [3:0] SUMopAB;
    wire overCheck;
    
    add_sub addSub(SUMopAB,overCheck,opA,opB,ctrl[1]);
    assign ANDopAB[0] = opA[0] & opB[0];
    assign ANDopAB[1] = opA[1] & opB[1];
    assign ANDopAB[2] = opA[2] & opB[2];
    assign ANDopAB[3] = opA[3] & opB[3];
    
    assign Overflow = overCheck & ctrl[0];
    
    four_bit_mux MUX(Result,ANDopAB,SUMopAB,ctrl[0]);
    
endmodule