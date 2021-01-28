`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 18:55:14
// Design Name: 
// Module Name: clk_div
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


module clk_div(input clk,input [32:0]my_m_value,output reg outclk=0);
reg [32:0] counter=0;

always @ (posedge clk) begin
counter <= (counter==my_m_value) ? 0 : counter + 1;
outclk <= (counter==my_m_value) ? ~outclk : outclk;
end
endmodule
