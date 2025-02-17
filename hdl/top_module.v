`timescale 1ns / 1ps

module top_module#(
    parameter N = 4
    )(
    input BNT,clk,rst,
    input [7:0]SW,
    output a,b,c,d,e,f,g,
    output [7:0] AN
    );
    
    wire go;
    wire multiply_en,done,Ld_in_en,bin2BCD_start_en;
    wire [3:0] X,Y;
    wire [7:0] A;
    wire w1;
    wire [3:0] D0,D1,D2;
    
    multiplier#(.N(N))
             U0(.clk(clk),.rst(!rst),.start(multiply_en),.B(X),.Q(Y),.A(A),.done(done));
             
    debounce U1 (.D(BNT),.clk(clk),.reset(!rst),.Q(w1));
    /*T_FF U4(.Q(BNT),.clk(clk),.rstn(!rst), .en(1'd1),.T(go));*/
    
    reg_xy U2 (.clk(clk), .rst(!rst), .Ld_in(Ld_in_en),.sw(SW), .reg_x(X),.reg_y(Y));
    
    main_ctrl U3( .clk(clk),.reset(!rst),.go(w1),.done(done), .Ld_in(Ld_in_en),.multiply(multiply_en),
                    .stop(),. bin2BCD_start(bin2BCD_start_en));//bin2BCD_start_en확인해보기
    
   // binary_to_BCD U4(.clk(clk), .en(bin2BCD_start_en), .reset(!reset), .eight_bit_value(A), .ones(D0), .tens(D1), .hundreds(D2));          
    
    Binary_to_BCD_Converter #(.N(N))
              U5( .bin2BCD_start_en(bin2BCD_start_en),.binary_in(A),.H(D2),.T(D1),.O(D0));
          
              
    segement7 t0(.clk(clk),.reset(!rst), .en(eo_1K),
                 .D0(D0),.D1(D1),.D2(D2),.D3(4'b0),.D4(4'b0),.D5(4'b0),.D6(4'b0), .D7(4'b0),
                 .A(a), .B(b), .C(c), .D(d), .E(e), .F(f), .G(g),.AN(AN)
                 );
                 
    clock_enable_generator t1 (.clk(clk), .rstn(!rst), .eo_1K(eo_1K));
                     
endmodule