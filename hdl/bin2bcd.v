`timescale 1ns / 1ps

module Binary_to_BCD_Converter #(
    parameter N = 4
    )(
    input bin2BCD_start_en,
    input [7:0] binary_in, 
    output reg [3:0] H, T, O
    );
    reg [3:0] b_MSB,b_LSB;
    reg [3:0] d_MSB,d_LSB;
    reg [7:0] total;
    
    always @* begin
    b_MSB = binary_in [3:0] ;
    b_LSB = binary_in [7:4];
    end
    

    always @*begin
    d_MSB=0;
    case(b_MSB) 
    4'b00_00: d_MSB = 4'd0; 
    4'b00_01: d_MSB = 4'd1;
    4'b00_10: d_MSB = 4'd2; 
    4'b00_11: d_MSB = 4'd3;
    4'b01_00: d_MSB = 4'd4; 
    4'b01_01: d_MSB = 4'd5;
    4'b01_10: d_MSB = 4'd6; 
    4'b01_11: d_MSB = 4'd7;
    4'b10_00: d_MSB = 4'd8; 
    4'b10_01: d_MSB = 4'd9;
    4'b10_10: d_MSB = 4'd10; 
    4'b10_11: d_MSB = 4'd11;
    4'b11_00: d_MSB = 4'd12; 
    4'b11_01: d_MSB = 4'd13;
    4'b11_10: d_MSB = 4'd14; 
    4'b11_11: d_MSB = 4'd15;
    default: d_MSB = 4'd0;
    endcase
    end
    
    
    always @*begin
    d_LSB=0;
    case(b_LSB) 
    4'b00_00: d_LSB = 4'd0; 
    4'b00_01: d_LSB = 4'd1;
    4'b00_10: d_LSB = 4'd2; 
    4'b00_11: d_LSB = 4'd3;
    4'b01_00: d_LSB = 4'd4; 
    4'b01_01: d_LSB = 4'd5;
    4'b01_10: d_LSB = 4'd6; 
    4'b01_11: d_LSB = 4'd7;
    4'b10_00: d_LSB = 4'd8; 
    4'b10_01: d_LSB = 4'd9;
    4'b10_10: d_LSB = 4'd10; 
    4'b10_11: d_LSB = 4'd11;
    4'b11_00: d_LSB = 4'd12; 
    4'b11_01: d_LSB = 4'd13;
    4'b11_10: d_LSB = 4'd14; 
    4'b11_11: d_LSB = 4'd15;
    default:  d_LSB = 4'd0;
    endcase
    end
    always @*begin
    total = 0;
    if(bin2BCD_start_en)begin
    total = d_MSB + d_LSB*16;
      H = total / 100;        // 백의 자리 (BCD)
      T = (total % 100) / 10; // 십의 자리 (BCD)
      O = total % 10;
        end
    end
endmodule
