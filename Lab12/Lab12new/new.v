`default_nettype none
`timescale 1ns / 1ns

module tlc_fsm(
	output reg[2:0] state, // declare output variables
	output reg RstCount,
	output reg[1:0] highwaySignal, farmSignal,
	input wire[30:0] Count, // delcare input variables
	input wire Clk, Rst,
	input wire farmSensor
);

reg [2:0] nextState; // declare states
parameter S0 = 3'b000,
		  S1 = 3'b001,
		  S2 = 3'b010,
		  S3 = 3'b011,
		  S4 = 3'b100,
		  S5 = 3'b101;
		  
	always@(Count) // at any count
		case(state)
			S0: begin // begin state one
				highwaySignal <= 2'b01; // signal red
				farmSignal <= 2'b01; // signal red
				// 1 sec transition to S1
				if(Count == 50000000*1)begin
					nextState <=S1;
					RstCount <= 1;
					end
				else
					begin
					RstCount = 0;
					nextState <= S0;
					end
			end
			S1: begin
				highwaySignal <= 2'b11; // signal green 
				farmSignal <= 2'b01; // signal red
				// 20 sec transition to S1
				if(farmSensor == 1 && Count == 50000000*20)begin
					nextState <=S2;
					RstCount <= 1;
					end
				else
					begin
					RstCount = 0;
					nextState <= S1;
					end
			end
			S2: begin
				highwaySignal <= 2'b10; // signal yellow
				farmSignal <= 2'b01; // signal red
				// 3 sec transition to S1
				if(Count == 50000000*3)begin
					nextState <=S3;
					RstCount <= 1;
					end
				else
					begin
					RstCount = 0;
					nextState <= S2;
					end
			end
			S3: begin
				highwaySignal <= 2'b01; // signal red
				farmSignal <= 2'b01; // signal red
				// 1 sec transition to S1
				if(Count == 50000000*1)begin
					nextState <=S4;
					RstCount <= 1;
					end
				else
					begin
					RstCount = 0;
					nextState <= S3;
					end
			end
			S4: begin
				highwaySignal <= 2'b01; // signal red
				farmSignal <= 2'b11; // signal green
				// 10 sec transition to S1 or 3 sec and sensor = 0
				if((farmSensor == 0 && Count == 50000000*3) || Count == 50000000*10)begin
					nextState <=S5;
					RstCount <= 1;
					end
				else
					begin
					RstCount = 0;
					nextState <= S4;
					end
			end
			S5: begin
				highwaySignal <= 2'b01; // signal red
				farmSignal <= 2'b10; // signal yellow
				// 3 sec transition to S0
				if(Count == 50000000*3)begin
					nextState <=S0;
					RstCount <= 1;
					end
				else
					begin
					RstCount = 0;
					nextState <= S5;
					end
			end
			
		endcase
	always@(posedge Clk)
		if(Rst)
			state <= S0; // goes to red red
		else
			state <=nextState; // transition to the next state
endmodule