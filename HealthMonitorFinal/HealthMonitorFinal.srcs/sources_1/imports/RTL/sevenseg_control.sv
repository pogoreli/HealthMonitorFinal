`timescale 1ns / 1ps

module sevenseg_control(
        input logic clk, rst,
        input logic [2:0] num,
        input logic [3:0] d0, d1, d2, d3,d4, d5, d6, d7,
        output logic [7:0] an_n,
        output logic [6:0] segs_n,
        output logic dot
        );
        
        logic [2:0] sel;
        logic [3:0] data;
    
        count_3bit count_3( .clk(clk), .rst(rst), .q(sel));
        mux8 multiplexer(.d0(d0), .d1(d1), .d2(d2), .d3(d3), .d4(d4), .d5(d5), .d6(d6), .d7(d7), .y(data), .sel(sel));
        dec_3_8 dec_3_8(.a(sel), .y_n(an_n), .num, .dot(dot));
        sevenseg_hex sevenseg_hex(.data(data), .segs_n(segs_n));

endmodule