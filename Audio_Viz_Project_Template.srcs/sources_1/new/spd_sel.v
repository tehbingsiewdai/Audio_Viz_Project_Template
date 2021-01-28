`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 21:53:11
// Design Name: 
// Module Name: spd_sel
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spd_sel(
    input clk,
    input [15:0]sw,
    input btnU, btnD,
    output reg [25:0] out
    );
    
reg[3:0] val = 3;
initial begin 
out = 'd4194304;
end

wire b_up; single_pulse su(clk, btnU, b_up);
wire b_down; single_pulse sd(clk, btnD, b_down);

always @(posedge clk)begin 
    if(sw[6] | sw[5] | sw[12]) begin
        if(b_up && val < 156)begin
            out = out / 2;
            val = val + 1;
        end
        if(b_down && val > 0)begin
            out = out * 2;
            val = val - 1;
        end
    end
end

endmodule
