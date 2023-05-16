`timescale 1ns / 1ps

module reaction_fsm(
        input logic clk, rst, START, ENTER,
        output logic [2:0] R_RGB, G_RGB, B_RGB,
        output logic [13:0] reaction_timer_time,
        output logic [4:0] state_led
    );
    
    assign R_RGB = LED_R;
    assign G_RGB = LED_G;
    assign B_RGB = LED_B;
    
    logic [13:0] counter_value;
    logic [13:0] count_9999, time_value;
    logic [12:0] count_5sec;

    
    logic [2:0] LED_R, LED_G, LED_B; 
    logic wait_done_impulse, less_9999, statedelay_5sec;
    logic start_timer, register_enable, register_rst;
    
    
    counter_9999ms counter_9999ms(.clk(clk), .enb(1), .rst(rst || start_timer), .pulse(less_9999), .count(count_9999));
    counter_5sec counter_5sec(.clk(clk), .rst(rst || start_timer), .impuls5sec(statedelay_5sec), .count(count_5sec));
    
    register_14bit register_time(.clk, .rst(rst || register_rst), .enb(register_enable), .data_in(time_value), .data_out(reaction_timer_time));
    
    typedef enum logic [3:0] {
        S0 = 4'b0000,
        S1 = 4'b0001,
        S2 = 4'b0010,
        S3 = 4'b0011,
        S4 = 4'b0100
    } state_t;


    state_t current_state, next;

    always_ff @(posedge clk) begin
        if (rst) begin
            current_state <= S0;
            next <= S0;
        end else begin
            current_state <= next;
        end

     
        LED_R = 3'b000;
        LED_B = 3'b000;
        LED_G = 3'b000;
        start_timer = 0;
        state_led = 0;
        register_enable = 0;
        register_rst = 0;
        
        
        case (current_state)
            S0: begin
                state_led[0] = 1;
                   LED_R = 0;
                   LED_G = 3'b111;
                   LED_B = 0;
                   if(START) begin
                         next = S1;
                         start_timer = 1;
                   end else if(ENTER) next = S2;
                end
            S1: begin
                   state_led[1] = 1;
                   LED_R = 3'b111;
                   LED_G = 3'b111;
                   LED_B = 3'b111;
                   register_rst = 1;
                   if(ENTER) next = S4;
                   else if(count_9999 > 5000) next = S3;    
                end
            S2: begin
                 state_led[2] = 1;
                 LED_R = 3'b111;
                 LED_G = 0;
                 LED_B = 0;
                 if(ENTER) next = S0;
                end
            S3: begin
                 state_led[3] = 1;
                 LED_R = 3'b111;
                 LED_G = 3'b111;
                 LED_B = 0;
                 if(less_9999) next = S2;
                 else if(ENTER) begin
                    time_value = count_9999;
                    register_enable = 1;
                    next = S0;
                 end
                end
            S4: begin
                 state_led[4] = 1;
                 LED_R = 0;
                 LED_G = 3'b111;
                 LED_B = 0;
                 time_value = count_9999;
                 register_enable = 1;
                 next = S0; 
                end
        endcase
    end

    assign state = current_state;
    

endmodule

