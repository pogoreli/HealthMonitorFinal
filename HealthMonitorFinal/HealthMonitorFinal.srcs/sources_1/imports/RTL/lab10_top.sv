module lab10_top(
    input logic clk, rst, modeSwitch, analog_pos_in, analog_neg_in, ENTER, START,
    
    output logic [15:0] led,
    output logic LED16_R, LED16_G, LED16_B, LED17_R, LED17_G, LED17_B,
    output logic point,
    output logic [7:0] an_n,
    output logic [6:0] segs_n
    );
    
    logic pulse;
    logic pulseLED;
    logic point_signal;
    assign point = point_signal;
    
    logic [15:0] pulse_leds;
    logic [4:0] state_led;
        
    logic clk_divided;
    logic [7:0] averageBPM;
    logic [3:0] thousands, hundreds, tens, ones;
    logic [2:0] num;
    logic [2:0] R_RGB, G_RGB, B_RGB;
    logic [13:0] reaction_timer_time, displayInput;
    logic [2:0] color_r16, color_g16, color_b16, color_r17, color_g17, color_b17, pulseRedValue;
    
    logic delayImpulse;
    
    logic pulseSensor;
    
    assign pulseLED = pulse;
    assign pulseSensor = pulse;

    rgb_control rgb_control16(.clk, .rst, .color_r(color_r16), .color_g(color_g16), .color_b(color_b16), .rgb_r(LED16_R), .rgb_g(LED16_G), .rgb_b(LED16_B));
    rgb_control rgb_control17(.clk, .rst, .color_r(color_r17), .color_g(color_g17), .color_b(color_b17), .rgb_r(LED17_R), .rgb_g(LED17_G), .rgb_b(LED17_B));
    clkdiv clkdiv(.clk(clk), .reset(0), .sclk(clk_divided));
    pulse_sensor U_PS(.clk, .rst, .analog_pos_in, .analog_neg_in, .led(pulse_leds), .pulse);
    pulse_counter_top pulse_counter_top(.clk(clk_divided), .rst(rst), .pulseInput(pulseSensor), .averageBPM(averageBPM));
    BCD_4bit converter(.inputValue(displayInput), .thousands, .hundreds, .tens, .ones);
    sevenseg_control sevenseg_control(.d3(thousands), .d2(hundreds), .d1(tens), .d0(ones), .an_n, .segs_n, .clk(clk_divided), .rst(rst), .num);
    reaction_timer_top reaction_timer_top(.state_led, .clk(clk_divided), .clk100(clk), .rst(rst), .START, .ENTER, .R_RGB, .G_RGB, .B_RGB, .reaction_timer_time);

    always_comb begin
        if(modeSwitch) begin
            displayInput = averageBPM;
            
            if(pulseLED) pulseRedValue = 3'b111;
            else pulseRedValue = 3'b000;
            
            color_r16 = pulseRedValue;
            color_g16 = 0;
            color_b16 = 0;
            color_r17 = 0;
            color_g17 = 0;
            color_b17 = 0;
            
            led = pulse_leds;
            num = 3'd3;
            point_signal = 1;
            
        end else begin
            
            displayInput <= reaction_timer_time;
            
            if(reaction_timer_time == 0) num = 0;
            else num = 3'd4;
            
            if(an_n == 8'b11110111 && num == 3'd4) point_signal = 0;
            else point_signal = 1;
            
            led = state_led;
            color_r16 = 0;
            color_g16 = 0;
            color_b16 = 0;
            color_r17 = R_RGB;
            color_g17 = G_RGB;
            color_b17 = B_RGB;
        end
    end
    
endmodule
