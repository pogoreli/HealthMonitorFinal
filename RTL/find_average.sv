`timescale 1ns / 1ps

module find_average(
    input logic clk,
    input logic [7:0] value1, value2, value3,
    output logic [7:0] average
);

    always_ff @(posedge clk) begin
        average <= (value1 + value2 + value3) / 3;
    end
    
endmodule