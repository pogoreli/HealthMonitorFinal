`timescale 1ns / 1ps

module dec_3_8(input logic [2:0] a, num,
                output logic [7:0] y, y_n,
                output logic dot
                );
                
       always_comb
            begin
                 if(num == 3'd3) begin
                    dot = 1;
                     case (a)
                        3'd0: y = 8'b00000001;
                        3'd1: y = 8'b00000010;
                        3'd2: y = 8'b00000100;
                        3'd3: y = 8'b00000000;
                        3'd4: y = 8'b00000000;
                        3'd5: y = 8'b00000000;
                        3'd6: y = 8'b00000000;
                        3'd7: y = 8'b00000000;
                        default: y = 8'b00000000;
                     endcase 
                  end else if(num == 3'd4) begin
                    dot = 1;
                        case (a)
                        3'd0: y = 8'b00000001;
                        3'd1: y = 8'b00000010;
                        3'd2: y = 8'b00000100;
                        3'd3: begin
                                    y = 8'b00001000;
                                    dot = 0;
                              end
                        3'd4: y = 8'b00000000;
                        3'd5: y = 8'b00000000;
                        3'd6: y = 8'b00000000;
                        3'd7: y = 8'b00000000;
                        default: y = 8'b00000000;
                     endcase 
                  end else if(num == 0) begin
                        y = 8'b00000000;
                        dot = 1;
                  end 
                 y_n = ~y;
             end            
endmodule












//              case (a)
//                    3'd0: y = 8'b00000001;
//                    3'd1: y = 8'b00000010;
//                    3'd2: y = 8'b00000100;
//                    3'd3: y = 8'b00001000;
//                    3'd4: y = 8'b00010000;
//                    3'd5: y = 8'b00100000;
//                    3'd6: y = 8'b01000000;
//                    3'd7: y = 8'b10000000;
//                    default: y = 8'b00000000;
//                 endcase 
