`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2025 11:33:17 PM
// Design Name: 
// Module Name: delay
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


module delay #(parameter WIDTH = 16) (
input clk,
input [WIDTH-1:0] in,
output reg [WIDTH-1:0] out
    );

    always @(posedge clk) 
        begin
            out <= in; 
        end 
endmodule
