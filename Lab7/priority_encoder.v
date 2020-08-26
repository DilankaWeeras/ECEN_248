`timescale 1ns / 1 ps
`default_nettype none
 
 module priority_encoder(
                         input wire [3:0] W, // declare input wire
                         output wire zero,   // declare output wire
                         output reg [1:0] Y  // declare register to save value 
                         );
    assign zero = (W == 4'b0000); // assign no input to zero
    
    always @(W) // at change in W
        begin
            casex(W)
                4'b0001: Y = 2'b00; //assing binary zero
                4'b001X: Y = 2'b01; //prioritize 2nd bit
                4'b01XX: Y = 2'b10; //prioritize 3rd bit
                4'b1XXX: Y = 2'b11; //prioritize 4th bit
                default: Y = 2'bXX; //no input dont care
                
            endcase
        end
endmodule