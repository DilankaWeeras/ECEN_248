`timescale 1ns / 1 ps

module adder_synchronous(Carry_reg, Sum_reg, Clk, A,B);
    
    output reg Carry_reg; // declare output variables
    output reg [1:0] Sum_reg;
    input wire Clk; // declare input variables
    input wire [1:0] A, B;
    
    reg [1:0] A_reg, B_reg; // declare reg for input variables
    wire Carry; // declare internal nets
    wire [1:0] Sum;
    
    adder_2bit adder0(Sum, Carry, A, B); //uses a 2-bit adder
    
    always@(posedge Clk) // on the pos edge of the clock it will store the values into a register
        begin
            A_reg <= A;
            B_reg <= B;
            
            Carry_reg <= Carry;
            Sum_reg <= Sum;
        end
        
endmodule
        
    