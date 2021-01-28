`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 20:09:52
// Design Name: 
// Module Name: clk_div_var
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


module clk_div_var(
    input clk,
    input btn_clk,
    input [15:0] sw,
    input btnU, btnD,
    output reg out
    );
    wire[25:0] var_c;
    reg [25:0] count;
    spd_sel(btn_clk, sw[15:0],btnU, btnD, var_c);
    initial begin
    count = 0;
    out = 0;
    end
    always @(posedge clk)
    begin
    if(count == var_c)
        begin
        count <= 0;
        out = ~out;
        end
     else 
        count <= count + 1;
    end
endmodule
