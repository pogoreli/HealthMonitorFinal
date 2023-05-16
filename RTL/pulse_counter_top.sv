`timescale 1ns / 1ps


module pulse_counter_top(
        input logic clk, rst, pulseInput,
        output logic [7:0] averageBPM,
        output logic [10:0] stateLED
    );
    
    fsm_GO fsm(.clk(clk), .reset(rst), .pulseInput(pulseInput), .averageBPM(averageBPM), .stateLED);

endmodule
