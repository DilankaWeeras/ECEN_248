`timescale 1ns/1ps
//default_nettype none;

module combination_lock_fsm(
	output reg [2:0] state, // output state
	output wire [3:0] Lock, // output Lock
	input wire Key1, Key2, Reset, Clk, // input variables
	input wire [3:0] Password
	);
	
	reg [2:0] nextState; // declare internal nets
	
	// parameters for easy understanding
	parameter S0 = 3'b000,
			  S1 = 3'b001,
			  S2 = 3'b010,
			  S3 = 3'b011,
			  S4 = 3'b100;
			  
	reg [3:0] LockReg; // this is a register for the lock

	assign Lock = LockReg; // register for "="
			  
	always@(Key1, Key2) // when a key is changed
		case(state)
			// beginning or initial state
			S0: begin // state zero
			    LockReg = 4'b0001;
				if(Password == 4'b1101 && Key1)
					nextState = S1; // if correct
				else if(Password != 4'b1101 && Key1)
					nextState = S0; // if false
		        else
		            nextState = S0; // default
			end
			// when first password is correct
			S1: begin // state 1
			    LockReg = 4'b0010;
				if(Password == 4'b0111 && Key2)
					nextState = S2; // correct
				else if(Password != 4'b0111 && Key2)
                    nextState = S0; // false
                else
                    nextState = S1; // default
			end
			// after second password is correct
			S2: begin // state 2
			    LockReg = 4'b0100;
				if(Password == 4'b1001 && Key1)
					nextState = S3; // correct
				else if(Password != 4'b1001 && Key1)
                    nextState = S0; // false
                else 
                    nextState = S2; // default
			end
			// after third password is correct
            S3: begin // state 3
                LockReg = 4'b1000;
                if(Password == 4'b1111 && Key2)
                    nextState = S4; // correct
                else if(Password != 4'b1111 && Key2)
                    nextState = S0; // false
                else
                    nextState = S3; //default
            end
			// finished after fourth password is correct
			S4: begin // state 4
				LockReg = 4'b1111; // COMPLETED 
				nextState = S4;    // UNLOCKED
			end
		endcase
	always@(posedge Clk)
		if(Reset)
			state <= S0; // reset state
		else
			state <= nextState; // set next state
			
endmodule
	