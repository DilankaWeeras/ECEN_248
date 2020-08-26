`timescale 1ns / 1ps

module adder_2bit(
                  output wire [1:0] Sum,
                  output wire Carry,
                  input wire [1:0] A, B
                  //input wire Cin
                  );
    
    wire Cin;
    assign Cin = 1'b0;
    wire Cin2;
                  
    full_adder adder0(Sum[0], Cin2, A[0], B[0], Cin);
    full_adder adder1(Sum[1], Carry, A[1], B[1], Cin2);
    
endmodule
                  
                 