`timescale 1ns / 1ps
`default_nettype none

module generate_propagate_unit16(G, P, X, Y);

output wire [15:0] G, P; // declare output variables
input wire [15:0] X, Y; // declare input variables

assign #2 G = X & Y; // G = X and Y
assign #2 P = X ^ Y; // P = X xor Y

endmodule

module block_carry_lookahead_unit(G_star, P_star, C, G, P, C0);

output wire G_star, P_star; // declare output wires
output wire [3:1] C; // c4 c3 c2 c1 
input wire [3:0] G, P; // declare input wires
input wire C0;

// Assigning the logic system
assign #4 C[1] = G[0] || C0 & P[0];
assign #4 C[2] = G[1] || (P[1] & G[0]) || (P[1] & P[0] & C0);
assign #4 C[3] = G[2] || (P[2] & G[1]) || (P[2] & P[1] & G[0]) || (P[2] & P[1] & P[0] & C0);
assign #4 G_star = G[3] || (P[3] & G[2]) || (P[3] & P[2] & G[1]) || (P[3] & P[2] & P[1] & G[0]) || (P[3] & P[2] & P[1] & P[0] & C0);
assign #2 P_star = P[1] & P[2] & P[3] & P[4];

endmodule

module summation_unit16(S, P, C);

output wire [15:0] S; // declare output wires
input wire [15:0] P, C; // delcare input wires

assign #2 S = P ^ C; // S = P xor C

endmodule

module carry_lookahead_16bit(Cout, S, X, Y, Cin);

output wire Cout; // final Cout
output wire [15:0] S; // Sum value
input wire [15:0] X, Y; // declare inputs
input wire Cin;

// declare internal nets
wire [16:0] C;
wire [15:0] P, G;
wire [3:0] P_star, G_star;

assign Cout = C[16]; // assign cout
assign C[0] = Cin; // assign cin

generate_propagate_unit16 gen1(G, P, X, Y); // first generate

block_carry_lookahead_unit BCLAU0( // first block 
    .G_star (G_star[0]),
    .P_star (P_star[0]),
    .C (C[3:1]),
    .G (G[3:0]),
    .P (P[3:0]),
    .C0 (C[0]));

block_carry_lookahead_unit BCLAU1( // second block
    .G_star (G_star[1]),
    .P_star (P_star[1]),
    .C (C[7:5]),
    .G (G[7:4]),
    .P (P[7:4]),
    .C0 (C[4]));

block_carry_lookahead_unit BCLAU2( // third block
    .G_star (G_star[2]),
    .P_star (P_star[2]),
    .C (C[11:9]),
    .G (G[11:8]),
    .P (P[11:8]),
    .C0 (C[8]));

block_carry_lookahead_unit BCLAU3( // fourth block
    .G_star (G_star[3]),
    .P_star (P_star[3]),
    .C (C[15:13]),
    .G (G[15:12]),
    .P (P[15:12]),
    .C0 (C[12]));
        
carry_lookahead_unit CLAU( // Use carry lookahead to add blocks
    .C ({C[16], C[12], C[8], C[4]}),
    .G (G_star),
    .P (P_star),
    .C0 (C[0]));
    
// final sum created
summation_unit16 sum1(S[15:0], P[15:0], C[15:0]);

endmodule
