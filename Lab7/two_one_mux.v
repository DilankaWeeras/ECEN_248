`timescale 1ns / 1 ps
`default_nettype none

/* THis module describes a 1-bit wide mux with behavioral constructs*/
module two_one_mux(Y, A, B, S);
    // Declare output ports
    output reg Y; 
    // Declare input ports
    input wire A, B, S;
    
    always @(A or B or S)
        begin
            if(S == 1'b0)
                Y = A;
            else
                Y = B;
        end

        
endmodule