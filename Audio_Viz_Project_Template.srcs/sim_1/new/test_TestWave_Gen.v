`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 19:27:38
// Design Name: 
// Module Name: test_TestWave_Gen
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


module test_TestWave_Gen();
reg clk;
wire [10:0]cnt;

TestWave_Gen dut (clk,cnt);
initial begin
clk=0;#1;
end
always begin
#5;clk=~clk;
end
endmodule
