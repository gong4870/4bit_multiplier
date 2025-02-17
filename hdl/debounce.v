
module debounce(
    input  wire clk,
    input  wire reset,
    input  wire D,
    output wire Q
);
    wire Q0, Q1, debounced_sig;

    DFF J1 (.clk(clk) , .D(D),   .reset(reset), .Q(Q0));
    
    DFF J2 (.clk(clk) , .D(Q0), .reset(reset), .Q(Q1));
    
    assign Q = ~ Q1 & Q0;  
    
    //T_FF but (.D(debounced_sig), .clk(clk), .reset(reset), .Q(Q));
    
    //assign debounced_sig = ~ Q1 & Q0;   
    
endmodule


module DFF(
    input  wire clk,
    input  wire reset,
    input  wire D,
    output reg Q);

always@(posedge clk, negedge reset)
    if(!reset)
        Q <= 0;
    else
        Q <= D;
    
endmodule