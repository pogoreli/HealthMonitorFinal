`timescale 1ns / 1ps

module random_delay_top(
        input logic clk, clk100, startButton, rst,
        output logic delayImpulse
    );
    
    logic [13:0] count_random_counter, random_delay_time, count_timer;
    logic startButtonPulse, startButtonPulse100, enable_counter_level, equal;

    counter_9999ms random_counter(.clk(clk100), .rst, .enb(1), .count(count_random_counter));
    register_14bit random_delay_time_register(.clk(clk100), .rst, .enb(startButtonPulse100), .data_in(count_random_counter), .data_out(random_delay_time));
    ButtonController ButtonControllerStartButton100(.CLK(clk100), .button(startButton), .buttonPulse(startButtonPulse100));
    ButtonController ButtonControllerStartButton(.CLK(clk), .button(startButton), .buttonPulse(startButtonPulse));
    enable_counter enable_counter(.clk, .start(startButtonPulse), .stop(delayImpulse), .level(enable_counter_level));
    counter_9999ms counter_timer(.clk(clk), .rst(rst || startButtonPulse), .enb(enable_counter_level), .count(count_timer));
    comparator_14bit comparator_14bit(.a(random_delay_time), .b(count_timer), .equal);
    single_pulser single_pulser(.clk, .din(equal), .d_pulse(delayImpulse));
  
endmodule
