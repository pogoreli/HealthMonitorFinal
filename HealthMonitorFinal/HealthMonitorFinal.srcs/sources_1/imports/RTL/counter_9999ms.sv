`timescale 1ns / 1ps

module counter_9999ms(
input logic clk, rst, enb,
    output logic [13:0] count,
    output logic pulse
);

 always_ff @(posedge clk) begin
    pulse = 0;
    if (rst) count <= 0;
    else if(enb) begin
        if (count >= 9999) begin
            pulse <= 1;
            count <= 0;
        end else count <= count + 1;
    end
end

endmodule
