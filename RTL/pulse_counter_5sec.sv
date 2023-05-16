`timescale 1ns / 1ps

module pulse_counter_5sec(
        input clk, rst, input_pulse,
        output logic [4:0] count
    );
    logic singlePulse;

    single_pulser single_pulser(.clk, .din(input_pulse), .d_pulse(singlePulse));
    
    always @(posedge clk) begin
        if(rst) count <= 0; 
        else if(singlePulse) count <= count + 1;
    end
 
    
endmodule
