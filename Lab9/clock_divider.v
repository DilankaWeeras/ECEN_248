`timescale 1ns / 1ps
`default_nettype none


module clock_divider(ClkOut, ClkIn);

    output wire [3:0] ClkOut; // declare ouptut variables
    input wire ClkIn; // declare input variables
    
    parameter n = 25; // declare timing
    
    reg [n:0] Count;
    
    always@(posedge ClkIn) // change in pos clock
        Count <= Count + 1;
       
    assign ClkOut[3:0] = Count[n:n-3];
    
endmodule