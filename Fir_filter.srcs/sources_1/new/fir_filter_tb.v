`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2025 08:35:08 PM
// Design Name: 
// Module Name: fir_filter_tb
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


module fir_filter_tb(

    );

    // 1) declare local reg and wire identifiers
    parameter WIDTH = 16;
    parameter TAPS = 4;

    reg clk;
    reg [WIDTH-1:0] xn;
    wire [WIDTH-1:0] yn;

    // 2) instantiate the unit under test (UUT)
    fir_filter #(.WIDTH(WIDTH), .TAPS(TAPS)) uut (
        .clk(clk),
        .xn(xn),
        .yn(yn)
    );

    // 3) clock generation
    always begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    // 4) specify a stopwatch to stop the simulation

    // 5) generate stimuli, using initial and always
    initial begin
        xn = 1000;
        #20;
        xn = 2000;
        #20;
        xn = 3000;
        #20;
        xn = 4000;
        #20;
        xn = 5000;
        #20;
        xn = 6000;
        #20;
        xn = 7000;
        #20;
        xn = 8000;
        #20;
        xn = 9000;
        #20;
        xn = 10000;
    
        #100;
        $stop;
    end

    // 6) display output response
    initial begin
        $monitor("Time=%0t | xn=%d | yn=%d", $time, xn, yn);
    end
endmodule
