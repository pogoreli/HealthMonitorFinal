`timescale 1ns / 1ps

module multiply_by12(
        input logic [4:0] value_in,
        output logic [7:0] value_out
    );
    
    always_comb begin
        value_out <= value_in * 12;
    end
    
endmodule
