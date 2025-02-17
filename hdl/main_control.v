`timescale 1ns / 1ps

`define C0     3'b000
`define C1     3'b001
`define C2     3'b010
`define C3     3'b011
`define C4     3'b100
`define C5     3'b101

module main_ctrl(
    input clk, reset,go,done,         // 곱셈 완료 신호
    output reg Ld_in,multiply,stop,bin2BCD_start 

    );
    
     reg [2:0] cst, nst;   
    
     always @(posedge clk or negedge reset) 
        if (!reset) 
            cst <= `C0;
            else
            cst <= nst;
                 
                 always @(*) begin
        case (cst)
            `C0:  if (go)  nst = `C1; else nst =`C0;
            `C1:  nst = `C2;
            `C2: if (done)  nst = `C3; else nst = `C2;
            `C3: nst = `C4;
            `C4: nst = `C0;
            default : nst = `C0;
        endcase
    end
    
    always @(*) begin
        // 기본 출력 신호 설정
        Ld_in = 1'b0;
        multiply = 1'b0;
        stop = 1'b0;
        bin2BCD_start = 1'b0;
      
    case (cst)
           `C0: {Ld_in,multiply,stop,bin2BCD_start} = 4'b0000;
           `C1: {Ld_in,multiply,stop,bin2BCD_start} = 4'b1000;
           `C2: {Ld_in,multiply,stop,bin2BCD_start} = 4'b1100;
           `C3: {Ld_in,multiply,stop,bin2BCD_start} = 4'b1001;
           `C4: {Ld_in,multiply,stop,bin2BCD_start} = 4'b0010;
           default : {Ld_in,multiply,stop,bin2BCD_start} = 4'b0000;
        endcase
    end
    
endmodule
