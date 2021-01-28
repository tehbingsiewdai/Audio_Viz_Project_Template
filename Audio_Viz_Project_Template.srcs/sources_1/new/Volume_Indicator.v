`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2019 19:08:47
// Design Name: 
// Module Name: Volume_Indicator
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


module Volume_Indicator( input [11:0] MIC_in,input vol_clk, input read_clk, output[11:0] VOL, output [3:0]an,output[7:0]seg);
reg [11:0] meter=0;
reg [11:0] counter=0;
reg [11:0] temp_vol=0;
reg [5:0] level=0;
reg [3:0] temp_an=0;
reg [7:0] temp_seg=0;
reg counter2=0;
always @ (posedge read_clk) begin
meter = (meter < MIC_in) ? MIC_in : meter;
counter = counter + 1;
counter2 = ~counter2;
case (level)
0: begin 
   temp_vol='b000000000000;
   temp_an='b1110;
   temp_seg='b11000000; //0
   end 
1: begin 
   temp_vol='b000000000001;
   temp_an='b1110;
   temp_seg='b11111001; //1
   end
2: begin 
   temp_vol='b000000000011;
   temp_an='b1110;
   temp_seg='b10100100; //2
   end
3: begin
   temp_vol='b000000000111;
   temp_an='b1110;
   temp_seg='b10110000; //3
   end
4: begin
   temp_vol='b000000001111;
   temp_an='b1110;
   temp_seg='b10011001; //4
   end
5: begin
   temp_vol='b000000011111;
   temp_an='b1110;
   temp_seg='b10010010; //5
   end
6: begin
   temp_vol='b000000111111;
   temp_an='b1110;
   temp_seg='b10000010; //6
   end
7: begin
   temp_vol='b000001111111;
   temp_an='b1110;
   temp_seg='b11111000; //7
   end
8: begin
   temp_vol='b000011111111;
   temp_an='b1110;
   temp_seg='b10000000; //8
   end
9: begin
   temp_vol='b000111111111;
   temp_an='b1110;
   temp_seg='b10010000; //9
   end
10: begin
    temp_vol='b001111111111;
    temp_an=(counter2==0) ? 'b1101 : 'b1110;
    temp_seg=(counter2==0) ? 'b11111001 : 'b11000000; //10
    end
11: begin
    temp_vol='b011111111111;
    temp_an=(counter2==0) ? 'b1101 : 'b1110;
    temp_seg=(counter2==0) ? 'b11111001 : 'b11111001; //11
    end
12: begin
    temp_vol='b111111111111;
    temp_an=(counter2==0) ? 'b1101 : 'b1110;
    temp_seg=(counter2==0) ? 'b11111001 : 'b10100100; //12
    end
endcase
if (counter=='d2000) begin
meter=0;
counter=0;
end
end

always @ (posedge vol_clk) begin

        level <= ((meter<=2000+181) & (meter>2000)) ? 1 :
                ((meter<=(2000+181*2)) & (meter>2000+181)) ? 2 :
                ((meter<=(2000+181*3)) & (meter>(2000+181*2))) ? 3 :
                ((meter<=(2000+181*4)) & (meter>(2000+181*3))) ? 4 :
                ((meter<=(2000+181*5)) & (meter>(2000+181*4))) ? 5 :
                ((meter<=(2000+181*6)) &(meter>(2000+181*5))) ? 6 :
                ((meter<=(2000+181*7)) & (meter>(2000+181*6))) ? 7 :
                ((meter<=(2000+181*8)) & (meter>(2000+181*7))) ? 8 :
                ((meter<=(2000+181*9)) & (meter>(2000+181*8))) ? 9 :
                ((meter<=(2000+181*10)) & (meter>(2000+181*9))) ? 10 :
                ((meter<=(2000+181*11)) & (meter>(2000+181*10))) ? 11 :
                (meter>(4000)) ? 12 :
                0;
        
end
assign VOL = temp_vol;
assign an = temp_an;
assign seg = temp_seg;
endmodule
