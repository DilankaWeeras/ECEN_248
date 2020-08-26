`timescale 1ns / 1ps
`default_nettype none

module withDebounce(LEDs, BTN, Clk);

    output reg [3:0] LEDs;
    
    input wire BTN, Clk;

    /*-this is a keyword we have not seen yet!*
     *-as the name implies, it is a parameter *
     * that can be changed at compile time... */
    parameter n = 5;

    wire notMsb, Rst, En, Debounced;
    reg Synchronizer0, Synchronized;
    reg [n-1:0] Count;

    reg edge_detect0;
    wire rising_edge;
    /*This is just for simulation*/
     initial
        LEDs=0; 
    
   /********************************************/
   /* Debounce circuitry!!!                    */ 
   /********************************************/
    
    always@(posedge Clk)
      begin
		// The button goes into synchro
        Synchronizer0 <= BTN; 
        Synchronized <= Synchronizer0;
      end

    always@(posedge Clk) // at clock
        if(Rst) // if reset count = 0
            Count <= 0;
        else if(En) // else enable
            Count <= Count + 1; // count + 1
	// not Msb is not count behind the count
    assign notMsb = ~Count[n-1];
	// enable is true if it is not Msb and Synchro
    assign En = notMsb & Synchronized;
	// reset is remapped
    assign Rst = ~Synchronized;
	// then sets the debounced signal to ignore
    assign Debounced = Count[n-1];

   /********************************************/
   /* End of Debounce circuitry!!!             */ 
   /********************************************/

    always@(posedge Clk)
        edge_detect0 <= Debounced;
		// edge will rise only if the signal passes the
		// previous test otherwise will not rise
    assign rising_edge = ~edge_detect0 & Debounced;

    always@(posedge Clk)
        if(rising_edge)
            LEDs <= LEDs + 1;

endmodule

