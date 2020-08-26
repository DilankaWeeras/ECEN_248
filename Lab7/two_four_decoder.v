`timescale 1ns / 1 ps
`default_nettype none

module two_four_decoder(
                        input wire [1:0] W, // declare input 2 bit
                        input wire En, // declare input on or off
                        output reg [3:0] Y // declare output saved value
                        );
    always @(W or En) // at change in W or En
        begin 
            if(En == 1'b1) // if En is 1 bit 1
                case(W)
                    2'b00: Y = 4'b0001; // decode 00
                    2'b01: Y = 4'b0010; // decode 01
                    2'b10: Y = 4'b0100; // decode 10
                    2'b11: Y = 4'b1000; // decode 11
                endcase
            else
                Y = 4'b0000; // else register nothing
        end
        
endmodule
                    