`timescale 1ns / 1ps
`default_nettype none

module full_adder(S, Cout, A, B, Cin);

    //Declare output variables
    output wire S;
    output wire Cout;
    
    //declare input wires
    input wire A, B, Cin;
    
    //declare internal wires
    wire andBCin, andACin;
    wire andAB;
    
    assign S = A ^ B ^ Cin; // the hat (^) is XOR
    assign andAB = A & B; // stores A and B int andAB
    assign andACin = A & Cin;
    assign andBCin = B & Cin;
    assign Cout = andAB | andBCin | andACin; //returns the Cout
    
endmodule // end
    