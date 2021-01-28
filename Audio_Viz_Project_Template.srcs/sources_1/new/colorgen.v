`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 22:07:26
// Design Name: 
// Module Name: colorgen
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


module colorgen(
    input clk,
    input btn_clk,
    input [15:0] sw,
    input  btnC,
    output reg [3:0] r, g, b,
    output reg pause
    );
 reg [1:0] r_up;
 reg [1:0] g_up;
 reg [1:0] b_up;
 initial begin
    r = 0;
    g = 0;
    b = 0;
    // 1 is up 0 is hold 2 is down
    r_up = 1;
    g_up = 0;
    b_up = 0;
 end
 
 initial begin
    pause = 1;
 end 
 wire b_c; single_pulse(btn_clk, btnC, b_c);
 
 always @(posedge btn_clk) begin
    if(sw[6] | sw[5] | sw[12])begin
    if(b_c)
        pause = ~pause;
    end
 end
 
 always @(posedge clk)begin
 if(!pause)begin
        if(r_up == 1)
        r = r + 1;
        else if(r_up == 2)
        r = r - 1;
        if(b_up == 1)
        b = b + 1;
        else if(b_up == 2)
        b = b - 1; 
        if(g_up == 1)
        g = g + 1;
        else if(g_up == 2)
        g = g - 1; 
        
        
        if(r == 4'hE) begin
            if(g == 4'hE) begin
                r_up = 2;
                g_up = 0;
            end
            else begin
              r_up = 0;
              g_up = 1;
           end
        end
        
        if(g == 4'hE)begin
            if(b == 4'hE) begin
                g_up = 2;
                b_up = 0;
            end
            else begin
              g_up = 0;
              b_up = 1;
           end
        end
        
        if(b == 4'hE) begin
            if(r == 4'hE) begin
                b_up = 2;
                r_up = 0;
            end
            else begin
              r_up = 1;
              b_up = 0;
           end
        end
    
        
        if(r == 0 && r_up == 2)begin
        r_up = 0;
        g_up = 2;
        end
        
        else if(g == 0 && g_up == 2)begin
        g_up = 0;
        b_up = 2;
        end
        
        if(b == 0 && b_up == 2)begin
        b_up = 0;
        r_up = 2;
        end 
      
        if(r_up == 0 && g_up == 0 && b_up == 0)
        r_up = 1;
    end
end
endmodule
