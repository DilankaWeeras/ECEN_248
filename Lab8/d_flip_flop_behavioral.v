`timescale 1ns / 1ps

module d_flip_flop_behavioral(
                              output reg Q, //declare output variables
                              output wire notQ,
                              input wire D,
                              input wire Clk
                              );
    
    always@(posedge Clk) // on the posotive edge of the clock
        Q <= D; // assign D to Q
        
    assign notQ = ~Q; // assign not Q to not Q
    
endmodule