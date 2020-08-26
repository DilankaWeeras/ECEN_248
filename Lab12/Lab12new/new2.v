`default_nettype none
`timescale 1ns / 1ns

module tlc_controller_ver1(
	output wire [1:0] highwaySignal, farmSignal, // declare output variables
	output wire [3:0] JB,
	input wire Clk, // declare input variables
	input wire Rst,
	input wire Sensor
	);
	
	wire RstSync; // declare internal nets
	wire RstCount;
	reg [30:0] Count;
	wire sensorSync;
	
	assign JB[3] = RstCount;
	
	synchronizer syncRst(RstSync, Rst, Clk); // syncronize reset signal
	synchronizer syncS(sensorSync, Sensor, Clk); // synchronize sensor signal
	
	tlc_fsm FSM( // call the tlc_FSM
		.state(JB[2:0]),
		.RstCount(JB[3]),
		.highwaySignal(highwaySignal),
		.farmSignal(farmSignal),
		.Count(Count),
		.Clk(Clk),
		.Rst(RstSync),
		.farmSensor(sensorSync)
		);
		
	always@(posedge Clk) // increment the clock
		if(RstCount)
			Count = 0; // set clock to zero
		else
			Count = Count + 1; // set clock to plus one
endmodule