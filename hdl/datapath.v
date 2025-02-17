`timescale 1ns / 1ps

module datapath #(
    parameter N = 4
    )(
    input wire clk, rst,
    input wire [N-1:0] B,  // multiplicand
    input wire [N-1:0] Q,  // multiplier
    input wire left, right, add, write,
    output reg [2*N-1:0] A  // Product (2*N bits)
    );
    
    reg [2*N-1:0] multiplicand; 
    reg [N-1:0] multiplier;     

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Reset 상태에서 모든 값 초기화
            multiplicand <= 0;
            multiplier <= 0;
            A <= 0;
        end else begin
            if (write) begin
                // 초기화 및 곱셈 시작 시 설정
               multiplicand <= {4'b0, B};  // B의 값을 상위 4비트를 0으로 채워 초기화
               multiplier <= Q;
            end

            if (add) begin
                // multiplier의 최하위 비트가 1일 경우에만 A에 multiplicand를 더하기
                A <= A + multiplicand;
            end

            if (left) begin
                // multiplicand를 왼쪽으로 1비트 시프트
                multiplicand <= multiplicand << 1;
            end

            if (right) begin
                // multiplier를 오른쪽으로 1비트 시프트
                multiplier <= multiplier >> 1;
            end
        end
    end
endmodule
