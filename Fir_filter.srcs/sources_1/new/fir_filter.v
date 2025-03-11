`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2025 08:21:55 PM
// Design Name: 
// Module Name: fir_filter
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


module fir_filter #(parameter WIDTH = 16, parameter TAPS = 4) (
    input clk,
    input [WIDTH-1:0] xn, // input sample
    output [WIDTH-1:0] yn // output sample
    );

  // Coefficients: READ ME
  // MOVING AVERAGE FILTER: coeff = 1/taps
    wire [WIDTH-1:0] coeffs [0:TAPS-1];
    assign coeffs[0] = 16'h2000;
    assign coeffs[1] = 16'h2000;
    assign coeffs[2] = 16'h2000;
    assign coeffs[3] = 16'h2000;

    // Wires
    wire [WIDTH-1:0] stage_out[TAPS-1:0];

    // generate fir_tap modules
    genvar i;
    generate
        for (i = 0; i < TAPS; i = i + 1) begin : fir_taps

            if (i == TAPS - 1) begin : tail_tap
                fir_tap #(.WIDTH(WIDTH)) tail_inst (
                .clk(clk),
                .previous_tap_in(0),
                .xn(xn),
                .coeff(coeffs[i]),
                .data_out(stage_out[i])
                );
            end

            else begin : fir_tap
            fir_tap #(.WIDTH(WIDTH), .IS_HEAD_TAP(i == 0)) tap_inst (
            .clk(clk),
            .previous_tap_in(stage_out[i + 1]),
            .xn(xn),
            .coeff(coeffs[i]),
            .data_out(stage_out[i])
            );
            end

        end
    endgenerate
    
    assign yn = stage_out[0];
endmodule
