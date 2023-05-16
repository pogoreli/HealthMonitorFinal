`timescale 1ns / 1ps

module ButtonController(
        input logic button, CLK,
        output logic buttonPulse
    );
    
    logic connection;

    debounce debounce(.clk(CLK), .pb(button), .pb_debounced(connection));
    single_pulser SP(.clk(CLK), .din(connection), .d_pulse(buttonPulse));
      
endmodule
