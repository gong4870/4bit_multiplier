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
            // Reset ���¿��� ��� �� �ʱ�ȭ
            multiplicand <= 0;
            multiplier <= 0;
            A <= 0;
        end else begin
            if (write) begin
                // �ʱ�ȭ �� ���� ���� �� ����
               multiplicand <= {4'b0, B};  // B�� ���� ���� 4��Ʈ�� 0���� ä�� �ʱ�ȭ
               multiplier <= Q;
            end

            if (add) begin
                // multiplier�� ������ ��Ʈ�� 1�� ��쿡�� A�� multiplicand�� ���ϱ�
                A <= A + multiplicand;
            end

            if (left) begin
                // multiplicand�� �������� 1��Ʈ ����Ʈ
                multiplicand <= multiplicand << 1;
            end

            if (right) begin
                // multiplier�� ���������� 1��Ʈ ����Ʈ
                multiplier <= multiplier >> 1;
            end
        end
    end
endmodule
