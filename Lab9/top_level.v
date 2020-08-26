`timescale 1ns / 1ps
`default_nettype none

module top_level(LEDs, SWs, BTNs, FastClk);

    output wire [3:0] LEDs; // declare output variale LEDs
    input wire [1:0] SWs; // delcare Switch
    input wire [1:0] BTNs; // declare Buttons
    input wire FastClk; // declare ocsilator
    
    wire [3:0] Clocks;
    reg SlowClk;
    
    always@(*) // at any change
        case(SWs) // determine the clock speed
            2'b00: SlowClk = Clocks[0];
            2'b01: SlowClk = Clocks[1];
            2'b10: SlowClk = Clocks[2];
            2'b11: SlowClk = Clocks[3];
            
        endcase
        
    up_counter up1(LEDs[2:0],LEDs[3],BTNs[1],SlowClk,BTNs[0]); // Use the up counter per clock
    
    clock_divider clk_div0( // Use the clock divider
        .ClkOut(Clocks),
        .ClkIn(FastClk)
    );
    
endmodule
