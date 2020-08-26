`timescale 1ns / 1ns
`default_nettype none
`define one 50000000
`define three 150000000
`define fifteen 750000000
`define thirty 1500000000


module tlc_fsm(
	output reg [2:0] state,
	output reg RstCount,
	output reg [1:0] highwaySignal, farmSignal,
	input wire [30:0] Count,
	input wire Clk, Rst);
	
	reg [2:0] nextState; // declare internal nets
	
	// parameters for easy understanding
	parameter S0 = 3'b000,
			  S1 = 3'b001,
			  S2 = 3'b010,
			  S3 = 3'b011,
			  S4 = 3'b100,
			  S5 = 3'b101;
	
	parameter red = 2'b01,
			  yellow = 2'b10,
			  green = 2'b11;
			  	
	always@(*)
		case(state)
			S0: begin
			    highwaySignal <= red;
                farmSignal <= red;				
				if(Count == `one) begin
					nextState <= S1;
					RstCount <= 1;
				end
				else begin
                    nextState <= S0;
                    RstCount <= 0;
				end
			end
			S1: begin
		        if(Count == `thirty) begin
                    highwaySignal <= green;
                    farmSignal <= red;
                    nextState <= S1;
                    RstCount <= 1;
                end
                else begin
                    highwaySignal <= green;
                    farmSignal <= red;
                    nextState <= S0;
                    RstCount <= 0;
                end
			end
			S2: begin
			    if(Count == `three) begin
                    highwaySignal <= yellow;
                    farmSignal <= red;
                    nextState <= S1;
                    RstCount <= 1;
                end
                else begin
                    highwaySignal <= yellow;
                    farmSignal <= red;
                    nextState <= S0;
                    RstCount <= 0;
                end
			end
			S3: begin
			    if(Count == `one) begin
                    highwaySignal <= red;
                    farmSignal <= red;
                    nextState <= S1;
                    RstCount <= 1;
                end
                else begin
                    highwaySignal <= red;
                    farmSignal <= red;
                    nextState <= S0;
                    RstCount <= 0;
                end
			end
			S4: begin
			    if(Count == `fifteen) begin
                    highwaySignal <= red;
                    farmSignal <= green;
                    nextState <= S1;
                    RstCount <= 1;
                end
                else begin
                    highwaySignal <= red;
                    farmSignal <= green;
                    nextState <= S0;
                    RstCount <= 0;
                end
			end
			S5: begin 
			    if(Count == `three) begin
                    highwaySignal <= red;
                    farmSignal <= yellow;
                    nextState <= S1;
                    RstCount <= 1;
                end
                else begin
                    highwaySignal <= red;
                    farmSignal <= yellow;
                    nextState <= S0;
                    RstCount <= 0;
                end
			end
		endcase

	always@(posedge Clk)
		if(Rst)
			state <= S0; // reset state
		else
			state <= nextState; // set next state
		
		
			
endmodule






	