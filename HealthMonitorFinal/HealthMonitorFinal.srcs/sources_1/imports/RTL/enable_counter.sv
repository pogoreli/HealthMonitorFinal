`timescale 1ns / 1ps

module enable_counter(
        input logic clk, start, stop,
        output logic level
    );
    
    always @(posedge clk) begin
        if (start)
          level <= 1;
        else if (stop)
          level <= 0;
    end
    
endmodule
