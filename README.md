# pipelined-FIR-filter-fpga
A pipelined implementation of an FIR filter for FPGA's
![fir_filter](https://github.com/user-attachments/assets/4115ce3d-e4a7-4c70-9b74-0740ff599185)
# How to use
1) Clone the repository and open in Vivado
2) run "vivado -mode tcl -source my_project.tcl" to rebuild using tcl
3) OR use included src files in current project

Default mode is a _moving average filter_, where coeff = 1/#taps. Parameters can be changed to create the filter type desired.

Parameters can be changed in **'fir_filter.v'**

_Parameters and variables:_
- WIDTH: change bit width of filter, default of 16 should be fine for most cases
- TAPS: change number of FIR taps generated
- Coeffs: change # of coeffs to match number of taps. Math is done in Q15 fixed point. Default is set to 16'h2000, equivalent to 1/4

```
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

```
