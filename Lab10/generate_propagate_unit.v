`timescale 1ns / 1ps
`default_nettype none

module generate_propagate_unit(G, P, X, Y);

output wire [3:0] G, P; // declare output wires
input wire [3:0] X, Y; // declare input wires

assign #2 G = X & Y; // G = X and Y
assign #2 P = X ^ Y; // P = X xor Y

endmodule

module carry_lookahead_unit(C, G, P, C0);

output wire [4:1] C; // c4 c3 c2 c1
input wire [3:0] G, P; // declare input wires
input wire C0;

// internal logic assignments
assign #4 C[1] = G[0] || C0 & P[0];
assign #4 C[2] = G[1] || (P[1] & G[0]) || (P[1] & P[0] & C0);
assign #4 C[3] = G[2] || (P[2] & G[1]) || (P[2] & P[1] & G[0]) || (P[2] & P[1] & P[0] & C0);
assign #4 C[4] = G[3] || (P[3] & G[2]) || (P[3] & P[2] & G[1]) || (P[3] & P[2] & P[1] & G[0]) || (P[3] & P[2] & P[1] & P[0] & C0);

endmodule

module summation_unit(S, P, C);

output wire [3:0] S; //delclare output wires
input wire [3:0] P, C; // declare input wires

assign #2 S = P ^ C; // S = P xor C

endmodule

module carry_lookahead_4bit(Cout, S, X, Y, Cin);

output wire Cout; // declare Cout
output wire [3:0] S; // declare Sum
input wire [3:0] X, Y; // declare input wires
input wire [3:0] Cin;

//internal nets
wire [3:0] genG, genP;
wire [4:0] C;
assign C[0] = Cin; // assign cin

generate_propagate_unit gen1(genG, genP, X, Y); // first generate
carry_lookahead_unit look1(C[4:1], genG, genP, C[0]); // logic compute
summation_unit sum1(S, genP, C[3:0]); // change for final sum
assign Cout = C[4];  // assign cout

endmodule
