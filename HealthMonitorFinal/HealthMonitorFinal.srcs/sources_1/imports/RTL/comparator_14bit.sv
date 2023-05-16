`timescale 1ns / 1ps

module comparator_14bit(
        input logic [13:0] a, b,
        output logic equal
    );
    
    assign equal = (a == b);
    
endmodule
