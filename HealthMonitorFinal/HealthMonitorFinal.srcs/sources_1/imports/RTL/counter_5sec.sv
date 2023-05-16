`timescale 1ns / 1ps

module counter_5sec(
        input clk, rst,
        output logic [12:0] count,
        output logic impuls5sec
    );
    
    integer COUNTER_MAX = 5000; // 1000 Hz * 5 seconds

    always @(posedge clk) begin
        impuls5sec <= 0;
        if (rst) count <= 0;
        else begin
            count <= count + 1;
            if (count == COUNTER_MAX) begin
                count <= 0;
                impuls5sec <= 1;
            end
        end
    end
   
endmodule