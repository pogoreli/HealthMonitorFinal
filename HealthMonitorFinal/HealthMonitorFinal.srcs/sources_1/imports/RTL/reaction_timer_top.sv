`timescale 1ns / 1ps


module reaction_timer_top(
        input logic clk, rst, START, ENTER, clk100,
        output logic [2:0] R_RGB, G_RGB, B_RGB, 
        output logic [13:0] reaction_timer_time,
        output logic [4:0] state_led
    );
    logic delayImpulse, START_impulse, ENTER_impulse;
    logic led;
    assign state_led = 0;

    ButtonController start_controller(.button(START), .CLK(clk), .buttonPulse(START_impulse));
    ButtonController enter_controller(.button(ENTER), .CLK(clk), .buttonPulse(ENTER_impulse));
    
    reaction_fsm reaction_fsm(.state_led(led), .clk(clk), .rst(rst), .R_RGB(R_RGB), .G_RGB(G_RGB), .B_RGB(B_RGB), .START(delayImpulse), .ENTER(ENTER_impulse), .reaction_timer_time);
    random_delay_top random_delay_top(.clk, .clk100, .startButton(START), .rst, .delayImpulse);

    
    
endmodule
