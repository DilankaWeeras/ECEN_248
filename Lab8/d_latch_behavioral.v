`timescale 1ns / 1ps

module d_latch_behavioral(
                          output reg Q, // declare output variables
                          output wire notQ,
                          input wire D, En // delare and define input variables
                          );
                          
    always@(En or D) // at En or D
        if(En)
            Q=D; // Q set to D
        else
            Q = Q; // Q set to Q
       
    assign notQ = ~Q; // Assign Q to opposite

endmodule