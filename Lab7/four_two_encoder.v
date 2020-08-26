`timescale 1ns / 1 ps
`default_nettype none
 
 module four_two_encoder(
                         input wire [3:0] W, // declare input wire
                         output wire zero,   // declare output wire
                         output reg [1:0] Y  // declare saved value;
                         );
    assign zero = (W == 4'b0000); // 
    
    always @(W) // at change in W
        begin
            case(W)
                4'b0001: Y = 2'b00; // place value to binary
                4'b0010: Y = 2'b01; // place value to binary
                4'b0100: Y = 2'b10; // place value to binary
                4'b1000: Y = 2'b11; // place value to binary
                default: Y = 2'bXX; // default dont care values
                
            endcase
        end
endmodule