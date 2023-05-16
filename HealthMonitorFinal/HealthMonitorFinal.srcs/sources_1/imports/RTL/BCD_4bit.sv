`timescale 1ns / 1ps

module BCD_4bit(
        input logic [13:0] inputValue,
        output logic [3:0] thousands, hundreds, tens, ones
    );
    
    always_comb begin
        thousands = inputValue/1000;
        hundreds = (inputValue - (thousands * 1000)) / 100;
        tens = (inputValue - (thousands * 1000) - (hundreds * 100)) / 10;
        ones = (inputValue - (thousands * 1000) - (hundreds * 100) - (tens * 10));
    end
endmodule
