`timescale 1ns / 1ps

module multiplier#(
    parameter N = 4
    )(
    input wire clk, rst, start,
    input wire [N-1:0] B,
    input wire [N-1:0] Q,
    output [7:0] A,
    output done
    );
    wire shift_left_en, shift_right_en, add_en,load_en;
    
    datapath #(
                .N(N)
                )U0(  
                .clk(clk), .rst(rst), .B(B), .Q(Q), .A(A), 
                .left(shift_left_en), .right(shift_right_en),
                .add(add_en), .write(load_en)
                );
   M_controler U1(.clk(clk),.reset(rst), .start(start),
                  .Q(Q),.load_en(load_en),.ADD(add_en),.shift_left(shift_left_en),.shift_right(shift_right_en),.stop(done) );
    
endmodule

