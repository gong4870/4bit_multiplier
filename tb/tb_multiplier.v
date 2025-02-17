`timescale 1ns / 1ps

module top_module_tb;
    // Parameter
    parameter N = 4; // 곱셈기의 기본 비트 크기

    // Inputs
    reg BNT;
    reg clk;
    reg rst;
    reg [0:7] SW;

    // Outputs
    wire a, b, c, d, e, f, g;
    wire [0:7] AN;

    // Testbench variable

    // DUT (Device Under Test)
    top_module #(.N(N)) DUT (
        .BNT(BNT),
        .clk(clk),
        .rst(rst),
        .SW(SW),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .AN(AN)
    );

    // Clock generation (50 MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 20 ns 주기 = 50 MHz
    end

    // Test sequence
    initial begin
        // Initialize inputs
        BNT = 0;
        rst = 1;
        SW = 8'b0000_0000; // 스위치를 초기화

        // Reset pulse
        #50 rst = 1; // 리셋 비활성화
        #50 rst = 0; // 리셋 활성화

        // Wait for reset to stabilize
        #100;

        // Test case 1: Multiply 3 * 2
        SW = 8'b0011_0010; // 3 (X), 2 (Y) 입력
        #50 BNT = 1; // 버튼 눌림 (Debounce 활성화)
        #50 BNT = 0;

        // Wait for calculation to complete
        #500;

        // Test case 2: Multiply 5 * 4
        SW = 8'b0101_0100; // 5 (X), 4 (Y) 입력
        #50 BNT = 1;
        #50 BNT = 0;

        // Wait for calculation to complete
        #1000;

        // Test case 3: Multiply 0 * 7
        SW = 8'b0000_0111; // 0 (X), 7 (Y) 입력
        #50 BNT = 1;
        #50 BNT = 0;

        // Wait for calculation to complete
        #500;

        // Test case 4: Multiply 15 * 15
        SW = 8'b1111_1111; // 15 (X), 15 (Y) 입력
        #50 BNT = 1;
        #50 BNT = 0;

        // Wait for calculation to complete
        #1000;

        // End simulation
        $stop;
    end
endmodule
