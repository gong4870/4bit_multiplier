`timescale 1ns / 1ps

module reg_xy (
    input wire clk,rst, Ld_in,        
    input wire [7:0] sw,      
    output reg [3:0] reg_x,reg_y    
);

    always @(*) begin
        reg_x = 4'b0000; 
        reg_y = 4'b0000; 
    if(Ld_in)begin
        reg_x = sw[7:4]; 
        reg_y = sw[3:0]; 
        end
    end

endmodule