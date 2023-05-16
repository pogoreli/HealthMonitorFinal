`timescale 1ns / 1ps

module rgb_control(
        input logic clk, rst,
        input logic [2:0] color_r, color_g, color_b,
        output logic rgb_r, rgb_g, rgb_b
    );
    logic [3:0] count;

    counter4 counter4(.clk, .rst(0), .count(count));
    Comparator comparatorR(.counter(count), .color(color_r), .lt(rgb_r));
    Comparator comparatorG(.counter(count), .color(color_g), .lt(rgb_g));
    Comparator comparatorB(.counter(count), .color(color_b), .lt(rgb_b));  
endmodule
