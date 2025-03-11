`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Caden Nihart
// 
// Create Date: 03/06/2025 11:33:17 PM
// Design Name: pipelined fir_tap
// Module Name: fir_tap
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Pipelined FIR filter tap
// 
//////////////////////////////////////////////////////////////////////////////////


module fir_tap #(parameter WIDTH = 16, parameter IS_HEAD_TAP = 0) (
    input clk,
    input [WIDTH-1:0] previous_tap_in, // Accumulated sum from previous tap
    input [WIDTH-1:0] xn,              // Input signal
    input [WIDTH-1:0] coeff,           // Chosen coefficient
    output [WIDTH-1:0] data_out       // Tap output
);

    // Wires
    wire [WIDTH-1:0] a_reg_out;
    wire [WIDTH-1:0] b_reg_out;
    wire [WIDTH-1:0] adder_out;
    wire [WIDTH-1:0] coeff_out;

    // Instantiate modules
    // ORDER: regA -> multiplier -> regB -> adder -> delay
    // regA & B serve as pipeline registers
    // **Check readme for tap block design**
    delay #(.WIDTH(WIDTH)) a_reg (.clk(clk), .in(xn), .out(a_reg_out));
    multiplier #(WIDTH) Coeff (.data_in(a_reg_out), .coeff(coeff), .data_out(coeff_out));
    delay #(.WIDTH(WIDTH)) b_reg (.clk(clk), .in(coeff_out), .out(b_reg_out));
    adder #(WIDTH) adder (.a(b_reg_out), .b(previous_tap_in), .sum(adder_out));

    // If it's the head tap, skip final delay
    if (IS_HEAD_TAP) begin
        assign data_out = adder_out;
    end else begin
        // NORMAL TAP: pass the adder output through a delay
        delay #(.WIDTH(WIDTH)) delay (.clk(clk), .in(adder_out), .out(data_out));
    end


endmodule
