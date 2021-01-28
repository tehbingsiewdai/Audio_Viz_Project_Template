`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 18:58:22
// Design Name: 
// Module Name: test_clk_div
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


module test_clk_div();
reg clk;
reg [32:0]my_m_value= 2;
wire outclk;

clk_div dut (clk,my_m_value,outclk);
initial begin
clk=0;#1;
end

always begin
#5;clk=~clk;
end

endmodule
