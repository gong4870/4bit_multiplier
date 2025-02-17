

module clock_enable_generator(input wire clk, input wire rstn,
                 output wire eo_1K);
    wire tc0, tc1, tc2, tc3, tc4, tc5, tc6, tc7;
    wire [3:0] Q100M;
    
    bcd_count u0(.TC(tc0), .inc(1'b1),.Q(),  .rstn(rstn), .clk(clk));
    bcd_count u1(.TC(tc1), .inc(tc0), .Q(), .rstn(rstn), .clk(clk));
    bcd_count u2(.TC(tc2), .inc(tc1), .Q(), .rstn(rstn), .clk(clk));
    bcd_count u3(.TC(tc3), .inc(tc2), .Q(), .rstn(rstn), .clk(clk));
    bcd_count u4(.TC(tc4), .inc(tc3), .Q(), .rstn(rstn), .clk(clk));
    bcd_count u5(.TC(tc5), .inc(tc4), .Q(), .rstn(rstn), .clk(clk));
    bcd_count u6(.TC(tc6), .inc(tc5), .Q(), .rstn(rstn), .clk(clk));
    bcd_count u7(.Q(Q100M), .TC(tc7), .inc(tc6), .rstn(rstn), .clk(clk));
    
    assign eo_100M = tc6;
    assign eo_100K = tc4;
    assign eo_1K = tc2;
    
    
endmodule

module bcd_count(input wire clk, rstn, inc, 
               output wire TC,
               output reg [3:0] Q );
               
always @(posedge clk, negedge rstn)
   if(!rstn)
      Q <= 0;
   else if(inc) begin
      if(Q == 'd9)
        Q <= 0;
      else
        Q <= Q+1;
   end
   
assign TC = (Q == 'd9 && inc)?1:0;
   
endmodule
