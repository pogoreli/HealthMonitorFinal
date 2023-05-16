`timescale 1ns / 1ps

module register_8bit(
        input logic clk, rst, enb,
        input logic [7:0] data_in,
        output logic [7:0] data_out
    );
    
    always @(posedge clk) begin
        if (rst) data_out <= 0;
        else begin
            if (enb) data_out <= data_in;
        end
    end
    
endmodule
