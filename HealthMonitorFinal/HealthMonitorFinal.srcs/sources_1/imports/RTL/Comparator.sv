`timescale 1ns / 1ps

module Comparator(
        input logic [3:0] counter,
        input logic [2:0] color,
        output logic lt
    );
    
    assign lt = (counter < color);
    
endmodule
