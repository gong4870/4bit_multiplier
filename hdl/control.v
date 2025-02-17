`timescale 1ns / 1ps


`define S0 4'd0
`define S1 4'd1
`define S2 4'd2
`define S3 4'd3
`define S4 4'd4
`define S5 4'd5 
`define S6 4'd6 
`define S7 4'd7 
`define S8 4'd8 
`define S9 4'd9 

module M_controler(
    input clk,reset,start,
    input [3:0] Q,
    output reg load_en, ADD,shift_left,shift_right,stop 
    );
    
    reg [3:0] cst, nst;
    reg [2:0] n;
    reg [3:0] q;
    
    
    always@(posedge clk or negedge reset)begin
        if(!reset)begin
            cst <= `S0;
            n <= 0;//문제 발생할 수도
        end
        else if(cst == `S5)begin
            n <= n+1;
            cst <= nst; end
            else
            cst <= nst;
    end
    
    always@(*)begin
        case(cst)
            `S0: if(start) nst =`S1; else nst = `S0; 
            `S1: if(Q[n] == 4'd1) nst =`S2; else nst = `S3;
            `S2: nst = `S3;
            `S3: nst = `S4;
            `S4: nst = `S5;
            `S5: nst = `S6;
            `S6: if(n==4)nst = `S7; else nst =`S1;
            `S7: nst = `S0 ;
            default : nst = `S0;
        endcase
    end
    
    always@(*)begin
        ADD = 1'b0;
        shift_left = 1'b0;
        shift_right = 1'b0;
        stop = 1'b0;
        load_en = 1'b0;
    
    case(cst)
        `S0: load_en =1'b1;
        `S1: load_en =1'b0 ;
        `S2: begin ADD = 1'd1 ;end
        `S3: shift_left = 1'd1;
        `S4: shift_right = 1'd1;
        `S5:;
        `S6:;
        `S7: stop = 1'd1;
    endcase
    end
endmodule
