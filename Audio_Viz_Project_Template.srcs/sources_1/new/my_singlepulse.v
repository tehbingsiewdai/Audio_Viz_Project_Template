`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2019 17:12:33
// Design Name: 
// Module Name: my_singlepulse
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


module single_pulse(input SP_CLOCK,BUTTON,output Q);

wire W1,W2;

my_dff dff1 (SP_CLOCK,BUTTON,W1);
my_dff dff2 (SP_CLOCK,W1,W2);

assign Q = W1 & ~W2;

endmodule
