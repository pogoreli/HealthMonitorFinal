`timescale 1ns / 1ps

module counter4(
        input logic clk, rst,
        output logic[3:0] count
    );
    
    always_ff @(posedge clk) begin
        if(rst) count <= 'h0000;
        else if(count == 4'd15) count <= 'h0000;
        else count <= count + 1;
    end
endmodule
