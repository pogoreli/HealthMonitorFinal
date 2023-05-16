`timescale 1ns / 1ps

module fsm_GO(
        input logic clk, reset, pulseInput,
        output logic [7:0] averageBPM,
        output logic [10:0] stateLED
    );
    logic [7:0] averageBPM2;
    
//    assign averageBPM = bpm;
    
    logic register1enb, register2enb, register3enb, input_pulse, output_register_enb, impulse5sec, reset_counter, switch;
    logic [7:0] bpm, register1_out, register2_out, register3_out, average_value_1, average_value_2, average_value_3, average_out;
    logic [4:0] counter_in;


    pulse_counter_5sec pulse_counter(.clk(clk), .rst(reset || reset_counter), .count(counter_in), .input_pulse(pulseInput));
    multiply_by12(.value_in(counter_in), .value_out(bpm));
    register_8bit register1(.clk(clk), .rst(reset), .enb(register1enb), .data_in(bpm), .data_out(register1_out));
    register_8bit register2(.clk(clk), .rst(reset), .enb(register2enb), .data_in(bpm), .data_out(register2_out));
    register_8bit register3(.clk(clk), .rst(reset), .enb(register3enb), .data_in(bpm), .data_out(register3_out));
    find_average find_average(.clk(clk), .value1(average_value_1), .value2(average_value_2), .value3(average_value_3), .average(average_out));
    register_8bit output_register(.clk(clk), .rst(reset), .enb(output_register_enb), .data_in(average_out), .data_out(averageBPM));
    counter_5sec counter_5sec(.clk(clk), .rst(reset), .impuls5sec(impulse5sec));
    
    assign stateLED[10] = reset || reset_counter;

    typedef enum logic [3:0] {
        S0 = 4'b0000,
        S1 = 4'b0001,
        S2 = 4'b0010,
        S3 = 4'b0011,
        S4 = 4'b0100,
        S5 = 4'b0101,
        S6 = 4'b0110,
        S7 = 4'b0111,
        S8 = 4'b1000,
        S9 = 4'b1001
    } state_t;

    state_t current_state, next;
    
    initial begin
        reset_counter = 1;
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            reset_counter = 1;
        end else current_state <= next;

        register1enb = 0;
        register2enb = 0;
        register3enb = 0;
        reset_counter = 0;
        output_register_enb = 0;
        stateLED[9:0] = 9'b0;
        
        case (current_state)
            S0: begin
                    if(impulse5sec) begin
                        switch <= 1;
                    end
                    
                    if(switch) begin
                        register2enb <= 1;
                        reset_counter <= 1;
                        next <= S1;
                        switch <= 0;
                     end
                     stateLED[0] <= 1;
                end
            S1: begin
                    average_value_1 <= register2_out;
                    average_value_2 <= register2_out;
                    average_value_3 <= register2_out;
                    output_register_enb <= 1;
                    next <= S2;
                    stateLED[1] <= 1;
                    reset_counter <= 1;
                end
            S2: begin
                    if(impulse5sec) begin
                        switch <= 1;
                    end
            
                    if(switch) begin
                        register3enb <= 1;
                        reset_counter <= 1;
                        next <= S3;
                        switch <= 0;
                     end
                     stateLED[2] <= 1;
                end
            S3: begin
                    average_value_1 <= register2_out;
                    average_value_2 <= register3_out;
                    average_value_3 <= register3_out;
                    output_register_enb <= 1;
                    next <= S4;
                    reset_counter <= 1;
                    stateLED[3] <= 1;
                end
            S4: begin
                    if(impulse5sec) begin
                        switch <= 1;
                    end
                    
                    if(switch) begin
                        register1enb <= 1;
                        reset_counter <= 1;
                        next <= S5;
                        switch <= 0;
                     end
                     stateLED[4] <= 1;
                end
            S5: begin
                    average_value_1 <= register2_out;
                    average_value_2 <= register3_out;
                    average_value_3 <= register1_out;
                    output_register_enb <= 1;
                    next <= S6;
                    reset_counter <= 1;
                    stateLED[5] <= 1;
                end
            S6: begin
                    if(impulse5sec) begin
                        switch <= 1;
                    end
            
                    if(switch) begin
                        register2enb <= 1;
                        reset_counter <= 1;
                        next <= S7;
                        switch <= 0;
                     end
                     stateLED[6] <= 1;
                end
            S7: begin
                    average_value_1 <= register3_out;
                    average_value_2 <= register1_out;
                    average_value_3 <= register2_out;
                    output_register_enb <= 1;
                    next <= S8;
                    reset_counter <= 1;
                    stateLED[7] <= 1;
                end
            S8: begin
                    if(impulse5sec) begin
                        switch <= 1;
                    end
                    
                    if(switch) begin
                        register3enb <= 1;
                        reset_counter <= 1;
                        next <= S9;
                        switch <= 0;
                     end
                     stateLED[8] <= 1;
                end
            S9: begin
                    average_value_1 <= register1_out;
                    average_value_2 <= register2_out;
                    average_value_3 <= register3_out;
                    output_register_enb <= 1;
                    next <= S4;
                    reset_counter <= 1;
                    stateLED[9] <= 1;
                end
        endcase
    end
endmodule
