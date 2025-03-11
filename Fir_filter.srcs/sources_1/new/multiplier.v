`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2025 11:30:11 PM
// Design Name: 
// Module Name: multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiplier #(parameter WIDTH = 16) (
    input [WIDTH-1:0] data_in,
    input [WIDTH-1:0] coeff,
    output [WIDTH-1:0] data_out
);

    // Full product is 2*WIDTH bits wide.
    wire [2*WIDTH-1:0] full_product;
    
    // Multiply the inputs (this produces a Q30 if both are Q15)
    assign full_product = data_in * coeff;
    
    // Shift right by (WIDTH-1) bits to scale back to Q15.
    // round result

    assign data_out = (full_product + (1 << (WIDTH - 2))) >> (WIDTH - 1);

//    assign data_out = data_in * coeff;
endmodule
