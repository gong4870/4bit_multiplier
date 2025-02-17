
module segement7(clk, reset, en, D0,D1,D2,D3,D4,D5,D6,D7,A,B,C,D,E,F,G,AN);
input wire clk,reset, en;
input wire [3:0]D0,D1,D2,D3,D4,D5,D6,D7;
output reg A,B,C,D,E,F,G;
output wire [7:0] AN;

wire [3:0] Y;
wire [2:0]sel;
// D0 -> 1Hz bcd counter data
// Dn = D0 + n (n = 1, ..., 7)

// bcd counter -> Q // 1 Hz
// assign D0 = Q;

mux81 seg_u0 (.D0(D0), .D1(D1), .D2(D2), .D3(D3), .D4(D4), .D5(D5), .D6(D6), .D7(D7), .sel(sel), .Y(Y)); //cnt3에 때라 D0에 들어가는 숫자가 바뀜
cnt3 seg_u1(.clk(clk), .reset(reset), .en(en), .Q(sel)); 
decoder seg_u3(.sel(sel), .enable(AN));//cn3 에 의해 위치가 바뀜

always @(*)
begin
    case(Y)
        4'b0000 : {A,B,C,D,E,F,G} = 7'b0000001;  //0
        4'b0001 : {A,B,C,D,E,F,G} = 7'b1001111;  //1
        4'b0010 : {A,B,C,D,E,F,G} = 7'b0010010;  //2
        4'b0011 : {A,B,C,D,E,F,G} = 7'b0000110;  //3
        4'b0100 : {A,B,C,D,E,F,G} = 7'b1001100;  //4
        4'b0101 : {A,B,C,D,E,F,G} = 7'b0100100;  //5
        4'b0110 : {A,B,C,D,E,F,G} = 7'b0100000;  //6
        4'b0111 : {A,B,C,D,E,F,G} = 7'b0001111;  //7
        4'b1000 : {A,B,C,D,E,F,G} = 7'b0000000;  //8
        4'b1001 : {A,B,C,D,E,F,G} = 7'b0000100;  //9
        4'b1010 : {A,B,C,D,E,F,G} = 7'b0001000;  //A
        4'b1011 : {A,B,C,D,E,F,G} = 7'b1100000;  //B
        4'b1100 : {A,B,C,D,E,F,G} = 7'b0110001;  //C
        4'b1101 : {A,B,C,D,E,F,G} = 7'b1000010;  //D
        4'b1110 : {A,B,C,D,E,F,G} = 7'b0110000;  //E
        4'b1111 : {A,B,C,D,E,F,G} = 7'b0111000;  //F
        
        default : {A,B,C,D,E,F,G} = 7'b1111111;
    endcase
end

endmodule


module mux81(
    input wire [3:0] D0,D1,D2,D3,D4,D5,D6,D7, 
    input wire [2:0] sel,
    output reg[3:0] Y
);

    always@* begin
        case(sel)
        3'd0: Y = D0;
        3'd1: Y = D1;
        3'd2: Y = D2;
        3'd3: Y = D3;
        3'd4: Y = D4;
        3'd5: Y = D5;
        3'd6: Y = D6;
        default: Y = D7;
    endcase
end
    

endmodule


module decoder(input wire [2:0] sel, output reg [7:0] enable);

always@*
begin
    case (sel)
        3'b000:  enable = ~8'b0000_0001;
        3'b001:  enable = ~8'b0000_0010;
        3'b010:  enable = ~8'b0000_0100;
        3'b011:  enable = ~8'b0000_1000;
        3'b100:  enable = ~8'b0001_0000;
        3'b101:  enable = ~8'b0010_0000;
        3'b110:  enable = ~8'b0100_0000;
        default: enable = ~8'b1000_0000;
    endcase
end

endmodule



module cnt3 (input wire clk, reset,en, output reg [2:0]Q);
    
always @(posedge clk, negedge reset)
   if(!reset)
      Q <= 0;
   else if(en) begin
      if(Q == 3'd7)
        Q <= 0;
      else
        Q <= Q+1;
   end
   
endmodule
