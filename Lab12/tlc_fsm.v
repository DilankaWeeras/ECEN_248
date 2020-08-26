`timescale 1ns/1ps
default_nettype none;
`define one-sec 50000000;
`define three-sec 150000000;
`define fifteen-sec 750000000;
`define thirty-sec 1500000000;

module tlc_fsm(
	output reg [3:0] state,
	output reg RstCount,
	output reg [1:0] highwaySignal, farmSignal,
	input wire [31-1:0] Count,
	input wire Clk, Rst);
	
	reg [2:0] nextState; // declare internal nets
	
	// parameters for easy understanding
	parameter S0 = 3'b000,
			  S1 = 3'b001,
			  S2 = 3'b010,
			  S3 = 3'b011,
			  S4 = 3'b100,
			  S5 = 3'b101,
			  Srst = 3'b110;
	
	parameter red = 2'b01,
			  yellow = 2'b10,
			  green = 2'b11;
			  
	reg [3:0] state;
	reg [3:0] nextState;
	
	always@(state)
		case(state)
			Srst: begin
				highwaySignal = red;
				farmSignal = red;
				RstCount = 1;
			end
			S0: begin
			RstCount = 0;
				highwaySignal = red;
				farmSignal = red;
				if(Count == one-sec && RstCount == 1) begin
					nextState = S1;
					RstCount = 1;
					end
				else
					nextState = S0;
			end
			S1: begin
		        RstCount = 0;
				highwaySignal = green;
				farmSignal = red;
				if(Count == thirty-sec && RstCount == 1) begin
					nextState = S2;
					RstCount = 1;
					end
				else
					nextState = S1;
			end
			S2: begin
			    RstCount = 0;
				highwaySignal = yellow;
				farmSignal = red;
				if(Count == three-sec && RstCount == 1) begin
					nextState = S3;
					RstCount = 1;
					end
				else
					nextState = S2;
			end
			S3: begin
			    RstCount = 0;
				highwaySignal = red;
				farmSignal = red;
				if(Count == one-sec && RstCount == 1) begin
					nextState = S4;
					RstCount = 1;
					end
				else
					nextState = S3;
			end
			S4: begin
			    RstCount = 0;
				highwaySignal = red;
				farmSignal = green;
				if(Count == fifteen-sec && RstCount == 1) begin
					nextState = S5;
					RstCount = 1;
					end
				else
					nextState = S4;
			end
			S5: begin 
			    RstCount = 0;
				highwaySignal = red;
				farmSignal = yellow;
				if(Count == three-sec && RstCount == 1) begin
					nextState = S0;
					RstCount = 1;
					end
				else
					nextState = S5;
			end
		endcase

	always@(posedge Clk)
		if(RstCount)
			state <= S0; // reset state
		else
			state <= nextState; // set next state
		
		
			
endmodule






	