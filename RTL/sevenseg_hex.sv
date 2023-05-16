`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2023 01:47:12 PM
// Design Name: 
// Module Name: sevenseg_hex
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sevenseg_hex(
     input logic [3:0] data,
     output logic [6:0] segs,
     output logic [6:0] segs_n
    );
    
    always_comb
        begin
            case (data)
                4'h0: segs = 7'b111_1110;
                4'h1: segs = 7'b011_0000;
                4'h2: segs = 7'b110_1101;
                4'h3: segs = 7'b111_1001;
                4'h4: segs = 7'b011_0011;
                4'h5: segs = 7'b101_1011;
                4'h6: segs = 7'b101_1111;
                4'h7: segs = 7'b111_0000;
                4'h8: segs = 7'b111_1111;
                4'h9: segs = 7'b111_1011;
                4'hA: segs = 7'b111_0111;
                4'hB: segs = 7'b001_1111;
                4'hC: segs = 7'b100_1110;
                4'hD: segs = 7'b011_1101;
                4'hE: segs = 7'b100_1111;
                4'hF: segs = 7'b100_0111;
                default: segs = 7'b111_1111;
               endcase
               segs_n = ~segs;
             end     
endmodule
