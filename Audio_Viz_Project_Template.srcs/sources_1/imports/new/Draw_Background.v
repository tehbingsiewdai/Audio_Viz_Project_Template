`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------  
//                  DRAWING GRID LINES AND TICKS ON SCREEN
// Description:
// Grid lines are drawn at pixel # 320 along the x-axis, and
// pixel #768 along the y-axis

// Note the VGA controller is configured to produce a 1024 x 1280 pixel resolution
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
// TOOD:    Draw grid lines at every 80-th pixel along the horizontal axis, and every 64th pixel
//          along the vertical axis. This gives us a 16x16 grid on screen. 
//          
//          Further draw ticks on the central x and y grid lines spaced 16 and 8 pixels apart in the 
//          horizontal and vertical directions respectively. This gives us 5 sub-divisions per division 
//          in the horizontal and 8 sub-divisions per divsion in the vertical direction   
//-------------------------------------------------------------------------  
  
//////////////////////////////////////////////////////////////////////////////////


module Draw_Background(
    input push_btn_clock,
    input clk_var,
    input [15:0]sw,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input btnC,
    input [3:0] red,
    input [3:0] green,
    input [3:0] blue,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
  
    output [3:0] VGA_Red_Grid,
    output [3:0] VGA_Green_Grid,
    output [3:0] VGA_Blue_Grid
    );
 /* Modified ver 1  
// The code below draws two grid lines. Modify the codes to draw more grid lines. 
    wire Condition_For_Grid = (VGA_HORZ_COORD % 80==0 ) ||  (VGA_VERT_COORD % 64==0 ) ;


// Using the gridline example, insert your code below to draw ticks on the x-axis and y-axis.
    wire Condition_For_Ticks = (VGA_HORZ_COORD == 639) ||  (VGA_VERT_COORD == 511) || ((VGA_HORZ_COORD >639) & (VGA_HORZ_COORD <=644) & (VGA_VERT_COORD % 10==0)) || ((VGA_VERT_COORD >=506) & (VGA_VERT_COORD <= 516)&(VGA_HORZ_COORD % 10==0)) ;

    
// Please modify below codes to change the background color and to display ticks defined above
    assign VGA_Red_Grid = Condition_For_Ticks ? 4'hD : 4'h0 ;
    assign VGA_Green_Grid = Condition_For_Grid ? 4'hD : 4'h0 ;
    assign VGA_Blue_Grid = Condition_For_Grid ? 4'h0 : 4'h0 ;
                            // if true, a red pixel is put at coordinates (VGA_HORZ_COORD, VGA_VERT_COORD), 
     */
     /* Modified ver 2 with moving axis
     reg [10:0] Vertical_Counter = 512;
     reg [10:0] Horizontal_Counter = 640;
     

     always @ (posedge push_btn_clock) begin
     if (sw[12]==1) begin
     Vertical_Counter = (btnL==1)?Vertical_Counter-1:(btnR==1)?Vertical_Counter+1: Vertical_Counter;
     Horizontal_Counter = (btnU==1)?Horizontal_Counter-1:(btnD==1)?Horizontal_Counter+1:Horizontal_Counter;
     end
     if (Horizontal_Counter>=1280) begin
     Horizontal_Counter=1;
     end
     else if (Horizontal_Counter<=0) begin
     Horizontal_Counter=1279;
     end
     else if (Vertical_Counter>=1024) begin
     Vertical_Counter=1;
     end
     else if (Vertical_Counter<=0) begin
     Vertical_Counter=1023;
     end
     end
     // The code below draws two grid lines. Modify the codes to draw more grid lines. 
         wire Condition_For_Grid = (VGA_HORZ_COORD % 80==0 ) ||  (VGA_VERT_COORD % 64==0 ) ;
     
     
     // Using the gridline example, insert your code below to draw ticks on the x-axis and y-axis.
         wire Condition_For_Ticks = (VGA_HORZ_COORD == Horizontal_Counter) ||  (VGA_VERT_COORD == Vertical_Counter) || ((VGA_HORZ_COORD >Horizontal_Counter) && (VGA_HORZ_COORD <=Horizontal_Counter+5) && (VGA_VERT_COORD % 10==0)) || ((VGA_VERT_COORD >=Vertical_Counter-5) && (VGA_VERT_COORD <= Vertical_Counter+5)&&(VGA_HORZ_COORD % 10==0)) ;
         
     // Please modify below codes to change the background color and to display ticks defined above
         assign VGA_Red_Grid = Condition_For_Ticks ? 4'hD : 4'h0 ;
         assign VGA_Green_Grid = Condition_For_Grid ? 4'hD : 4'h0 ;
         assign VGA_Blue_Grid = Condition_For_Grid ? 4'h0 : 4'h0 ;
     // if true, a red pixel is put at coordinates (VGA_HORZ_COORD, VGA_VERT_COORD),
     */ 
     // The code below draws two grid lines. Modify the codes to draw more grid lines. 
         wire Condition_For_Grid = ((VGA_HORZ_COORD % 80 == 0) ||  (VGA_VERT_COORD % 64 == 0)) && ((VGA_HORZ_COORD != 640) ||  (VGA_VERT_COORD != 512)) ;
         wire [3:0] Background_R;
         wire [3:0] Background_G;
         wire [3:0] Background_B;
         reg [3:0] Foreground_R;
         reg [3:0] Foreground_G;
         reg [3:0] Foreground_B;
         reg [0:3] Scrolling_R[15:0];
         reg [0:3] Scrolling_G[15:0];
         reg [0:3] Scrolling_B[15:0];
         wire [3:0] Background_Rs;
         wire [3:0] Background_Gs;
         wire [3:0] Background_Bs;
         reg [3:0] Background_Rn;
         reg [3:0] Background_Gn;
         reg [3:0] Background_Bn;
         reg [3:0] prev_r; reg [3:0] prev_g; reg [3:0] prev_b;
         
         wire b_up; single_pulse su(push_btn_clock, btnU, b_up);
         wire b_down; single_pulse sd(push_btn_clock, btnD, b_down);
         wire b_left; single_pulse sl(push_btn_clock, btnL, b_left);
         wire b_right; single_pulse sr(push_btn_clock, btnR, b_right);

     
     // Using the gridline example, insert your code below to draw ticks on the x-axis and y-axis.
         wire text_cond = VGA_HORZ_COORD == 100 ;
         reg [10:0] Vertical_Counter = 512;
         reg [10:0] Horizontal_Counter = 640;
       /*wire x_axis_cond =  VGA_VERT_COORD == Vertical_Counter || ((VGA_HORZ_COORD >= Horizontal_Counter-4) && (VGA_HORZ_COORD <= Horizontal_Counter+4) && VGA_VERT_COORD % 8 == 0);
         wire y_axis_cond = VGA_HORZ_COORD == Horizontal_Counter || ((VGA_VERT_COORD >= Vertical_Counter-4) && (VGA_VERT_COORD <= Vertical_Counter+4) && VGA_HORZ_COORD % 16 == 0);
         wire Condition_For_Ticks = x_axis_cond || y_axis_cond; */
         wire Condition_For_Ticks = (VGA_HORZ_COORD == Horizontal_Counter) ||  (VGA_VERT_COORD == Vertical_Counter) || ((VGA_HORZ_COORD >=Horizontal_Counter-5) && (VGA_HORZ_COORD <=Horizontal_Counter+5) && (VGA_VERT_COORD % 10==0)) || ((VGA_VERT_COORD >=Vertical_Counter-5) && (VGA_VERT_COORD <= Vertical_Counter+5)&&(VGA_HORZ_COORD % 10==0)) ;
         
         wire Condition_Combined_R =  Condition_For_Grid ||  Condition_For_Ticks;
         wire Condition_Combined_G =  Condition_For_Grid ||  Condition_For_Ticks;
         wire Condition_Combined_B =  Condition_For_Grid ||  Condition_For_Ticks;
         
         reg [2:0] Color_Sel = 1;
         
     
        wire background_column_r0 = ~sw[7]? VGA_HORZ_COORD >= 0 && VGA_HORZ_COORD < 80 :  VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 480 && VGA_VERT_COORD < 544;
        wire background_column_g0 = ~sw[7] ? VGA_HORZ_COORD >= 0 && VGA_HORZ_COORD < 80  :  VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 480 && VGA_VERT_COORD < 544;
        wire background_column_b0 = ~sw[7] ? VGA_HORZ_COORD >= 0 && VGA_HORZ_COORD < 80  :  VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 480 && VGA_VERT_COORD < 544;
        wire background_column_r1 = ~sw[7] ? VGA_HORZ_COORD >= 80 && VGA_HORZ_COORD < 160 :  VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 600 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 576 || VGA_HORZ_COORD >= 680  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 576 || VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 480 || VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 544 && VGA_VERT_COORD < 576 ;
        wire background_column_g1 = ~sw[7] ? VGA_HORZ_COORD >= 80 && VGA_HORZ_COORD < 160 :  VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 600 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 576 || VGA_HORZ_COORD >= 680  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 576 || VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 480 || VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 544 && VGA_VERT_COORD < 576 ;
        wire background_column_b1 = ~sw[7] ? VGA_HORZ_COORD >= 80 && VGA_HORZ_COORD < 160 :  VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 600 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 576 || VGA_HORZ_COORD >= 680  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 576 || VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 448 && VGA_VERT_COORD < 480 || VGA_HORZ_COORD >= 600  && VGA_HORZ_COORD < 680 && VGA_VERT_COORD >= 544 && VGA_VERT_COORD < 576 ;
        wire background_column_r2 = ~sw[7] ? VGA_HORZ_COORD >= 160 && VGA_HORZ_COORD < 240 :  VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 560 && VGA_VERT_COORD >= 416 && VGA_VERT_COORD < 608 || VGA_HORZ_COORD >= 720  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 416 && VGA_VERT_COORD < 608 || VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 416 && VGA_VERT_COORD < 448 || VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 576 && VGA_VERT_COORD < 608 ;
        wire background_column_g2 = ~sw[7] ? VGA_HORZ_COORD >= 160 && VGA_HORZ_COORD < 240 :  VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 560 && VGA_VERT_COORD >= 416 && VGA_VERT_COORD < 608 || VGA_HORZ_COORD >= 720  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 416 && VGA_VERT_COORD < 608 || VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 416 && VGA_VERT_COORD < 448 || VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 576 && VGA_VERT_COORD < 608 ;
        wire background_column_b2 = ~sw[7] ? VGA_HORZ_COORD >= 160 && VGA_HORZ_COORD < 240 :  VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 560 && VGA_VERT_COORD >= 416&& VGA_VERT_COORD < 608 || VGA_HORZ_COORD >= 720  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 416 && VGA_VERT_COORD < 608 || VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 416 && VGA_VERT_COORD < 448 || VGA_HORZ_COORD >= 560  && VGA_HORZ_COORD < 720 && VGA_VERT_COORD >= 576 && VGA_VERT_COORD < 608 ;
        wire background_column_r3 = ~sw[7] ? VGA_HORZ_COORD >= 240 && VGA_HORZ_COORD < 320 :  VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 520 && VGA_VERT_COORD >= 384&& VGA_VERT_COORD < 640 || VGA_HORZ_COORD >= 760  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 384 && VGA_VERT_COORD < 640 || VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 384 && VGA_VERT_COORD < 416 || VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 608 && VGA_VERT_COORD < 640 ;
        wire background_column_g3 = ~sw[7] ? VGA_HORZ_COORD >= 240 && VGA_HORZ_COORD < 320 :  VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 520 && VGA_VERT_COORD >= 384&& VGA_VERT_COORD < 640 || VGA_HORZ_COORD >= 760  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 384 && VGA_VERT_COORD < 640 || VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 384 && VGA_VERT_COORD < 416 || VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 608 && VGA_VERT_COORD < 640 ;
        wire background_column_b3 = ~sw[7] ? VGA_HORZ_COORD >= 240 && VGA_HORZ_COORD < 320 :  VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 520 && VGA_VERT_COORD >= 384&& VGA_VERT_COORD < 640 || VGA_HORZ_COORD >= 760  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 384 && VGA_VERT_COORD < 640 || VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 384 && VGA_VERT_COORD < 416 || VGA_HORZ_COORD >= 520  && VGA_HORZ_COORD < 760 && VGA_VERT_COORD >= 608 && VGA_VERT_COORD < 640 ;
        wire background_column_r4 = ~sw[7] ? VGA_HORZ_COORD >= 320 && VGA_HORZ_COORD < 400 :  VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 480 && VGA_VERT_COORD >= 352&& VGA_VERT_COORD < 672 || VGA_HORZ_COORD >= 800  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 352 && VGA_VERT_COORD < 672 || VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 352 && VGA_VERT_COORD < 384 || VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 640 && VGA_VERT_COORD < 672 ;
        wire background_column_g4 = ~sw[7] ? VGA_HORZ_COORD >= 320 && VGA_HORZ_COORD < 400 :  VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 480 && VGA_VERT_COORD >= 352&& VGA_VERT_COORD < 672 || VGA_HORZ_COORD >= 800  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 352 && VGA_VERT_COORD < 672 || VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 352 && VGA_VERT_COORD < 384 || VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 640 && VGA_VERT_COORD < 672 ;
        wire background_column_b4 = ~sw[7] ? VGA_HORZ_COORD >= 320 && VGA_HORZ_COORD < 400 :  VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 480 && VGA_VERT_COORD >= 352&& VGA_VERT_COORD < 672 || VGA_HORZ_COORD >= 800  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 352 && VGA_VERT_COORD < 672 || VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 352 && VGA_VERT_COORD < 384 || VGA_HORZ_COORD >= 480  && VGA_HORZ_COORD < 800 && VGA_VERT_COORD >= 640 && VGA_VERT_COORD < 672 ;
        wire background_column_r5 = ~sw[7] ? VGA_HORZ_COORD >= 400 && VGA_HORZ_COORD < 480 :  VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 440 && VGA_VERT_COORD >= 320&& VGA_VERT_COORD < 704 || VGA_HORZ_COORD >= 840  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 320 && VGA_VERT_COORD < 704 || VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 320 && VGA_VERT_COORD < 352 || VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 672 && VGA_VERT_COORD < 704 ;
        wire background_column_g5 = ~sw[7] ? VGA_HORZ_COORD >= 400 && VGA_HORZ_COORD < 480 :  VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 440 && VGA_VERT_COORD >= 320&& VGA_VERT_COORD < 704 || VGA_HORZ_COORD >= 840  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 320 && VGA_VERT_COORD < 704 || VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 320 && VGA_VERT_COORD < 352 || VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 672 && VGA_VERT_COORD < 704 ;
        wire background_column_b5 = ~sw[7] ? VGA_HORZ_COORD >= 400 && VGA_HORZ_COORD < 480 :  VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 440 && VGA_VERT_COORD >= 320&& VGA_VERT_COORD < 704 || VGA_HORZ_COORD >= 840  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 320 && VGA_VERT_COORD < 704 || VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 320 && VGA_VERT_COORD < 352 || VGA_HORZ_COORD >= 440  && VGA_HORZ_COORD < 840 && VGA_VERT_COORD >= 672 && VGA_VERT_COORD < 704 ;
        wire background_column_r6 = ~sw[7] ? VGA_HORZ_COORD >= 480 && VGA_HORZ_COORD < 560 :  VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 400 && VGA_VERT_COORD >= 288&& VGA_VERT_COORD < 736 || VGA_HORZ_COORD >= 880  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 288 && VGA_VERT_COORD < 736 || VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 288 && VGA_VERT_COORD < 320 || VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 704 && VGA_VERT_COORD < 736 ;
        wire background_column_g6 = ~sw[7] ? VGA_HORZ_COORD >= 480 && VGA_HORZ_COORD < 560 :  VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 400 && VGA_VERT_COORD >= 288&& VGA_VERT_COORD < 736 || VGA_HORZ_COORD >= 880  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 288 && VGA_VERT_COORD < 736 || VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 288 && VGA_VERT_COORD < 320 || VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 704 && VGA_VERT_COORD < 736 ;
        wire background_column_b6 = ~sw[7] ? VGA_HORZ_COORD >= 480 && VGA_HORZ_COORD < 560 :  VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 400 && VGA_VERT_COORD >= 288&& VGA_VERT_COORD < 736 || VGA_HORZ_COORD >= 880  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 288 && VGA_VERT_COORD < 736 || VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 288 && VGA_VERT_COORD < 320 || VGA_HORZ_COORD >= 400  && VGA_HORZ_COORD < 880 && VGA_VERT_COORD >= 704 && VGA_VERT_COORD < 736 ;
        wire background_column_r7 = ~sw[7] ? VGA_HORZ_COORD >= 560 && VGA_HORZ_COORD < 640 :  VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 360 && VGA_VERT_COORD >= 256&& VGA_VERT_COORD < 768 || VGA_HORZ_COORD >= 920  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 256 && VGA_VERT_COORD < 768 || VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 256 && VGA_VERT_COORD < 288 || VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 736 && VGA_VERT_COORD < 768 ;
        wire background_column_g7 = ~sw[7] ? VGA_HORZ_COORD >= 560 && VGA_HORZ_COORD < 640 :  VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 360 && VGA_VERT_COORD >= 256&& VGA_VERT_COORD < 768 || VGA_HORZ_COORD >= 920  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 256 && VGA_VERT_COORD < 768 || VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 256 && VGA_VERT_COORD < 288 || VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 736 && VGA_VERT_COORD < 768 ;
        wire background_column_b7 = ~sw[7] ? VGA_HORZ_COORD >= 560 && VGA_HORZ_COORD < 640 :  VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 360 && VGA_VERT_COORD >= 256&& VGA_VERT_COORD < 768 || VGA_HORZ_COORD >= 920  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 256 && VGA_VERT_COORD < 768 || VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 256 && VGA_VERT_COORD < 288 || VGA_HORZ_COORD >= 360  && VGA_HORZ_COORD < 920 && VGA_VERT_COORD >= 736 && VGA_VERT_COORD < 768 ;
        wire background_column_r8 = ~sw[7] ? VGA_HORZ_COORD >= 640 && VGA_HORZ_COORD < 720 :  VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 320 && VGA_VERT_COORD >= 224&& VGA_VERT_COORD < 800 || VGA_HORZ_COORD >= 960  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 224 && VGA_VERT_COORD < 800 || VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 224 && VGA_VERT_COORD < 256 || VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 768 && VGA_VERT_COORD < 800 ;
        wire background_column_g8 = ~sw[7] ? VGA_HORZ_COORD >= 640 && VGA_HORZ_COORD < 720 :  VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 320 && VGA_VERT_COORD >= 224&& VGA_VERT_COORD < 800 || VGA_HORZ_COORD >= 960  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 224 && VGA_VERT_COORD < 800 || VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 224 && VGA_VERT_COORD < 256 || VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 768 && VGA_VERT_COORD < 800 ;
        wire background_column_b8 = ~sw[7] ? VGA_HORZ_COORD >= 640 && VGA_HORZ_COORD < 720 :  VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 320 && VGA_VERT_COORD >= 224&& VGA_VERT_COORD < 800 || VGA_HORZ_COORD >= 960  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 224 && VGA_VERT_COORD < 800 || VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 224 && VGA_VERT_COORD < 256 || VGA_HORZ_COORD >= 320  && VGA_HORZ_COORD < 960 && VGA_VERT_COORD >= 768 && VGA_VERT_COORD < 800 ;
        wire background_column_r9 = ~sw[7] ? VGA_HORZ_COORD >= 720 && VGA_HORZ_COORD < 800 :  VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 280 && VGA_VERT_COORD >= 192&& VGA_VERT_COORD < 832 || VGA_HORZ_COORD >= 1000  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 192 && VGA_VERT_COORD < 832 || VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 192 && VGA_VERT_COORD < 224 || VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 800 && VGA_VERT_COORD < 832 ;
        wire background_column_g9 = ~sw[7] ? VGA_HORZ_COORD >= 720 && VGA_HORZ_COORD < 800 :  VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 280 && VGA_VERT_COORD >= 192&& VGA_VERT_COORD < 832 || VGA_HORZ_COORD >= 1000  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 192 && VGA_VERT_COORD < 832 || VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 192 && VGA_VERT_COORD < 224 || VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 800 && VGA_VERT_COORD < 832 ;
        wire background_column_b9 = ~sw[7] ? VGA_HORZ_COORD >= 720 && VGA_HORZ_COORD < 800 :  VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 280 && VGA_VERT_COORD >= 192&& VGA_VERT_COORD < 832 || VGA_HORZ_COORD >= 1000  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 192 && VGA_VERT_COORD < 832 || VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 192 && VGA_VERT_COORD < 224 || VGA_HORZ_COORD >= 280  && VGA_HORZ_COORD < 1000 && VGA_VERT_COORD >= 800 && VGA_VERT_COORD < 832 ;
        wire background_column_r10 = ~sw[7] ? VGA_HORZ_COORD >= 800 && VGA_HORZ_COORD < 880 :  VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 240 && VGA_VERT_COORD >= 160&& VGA_VERT_COORD < 864 || VGA_HORZ_COORD >= 1040  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 160 && VGA_VERT_COORD < 864 || VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 160 && VGA_VERT_COORD < 192 || VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 832 && VGA_VERT_COORD < 864 ;
        wire background_column_g10 = ~sw[7] ? VGA_HORZ_COORD >= 800 && VGA_HORZ_COORD < 880 :  VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 240 && VGA_VERT_COORD >= 160&& VGA_VERT_COORD < 864 || VGA_HORZ_COORD >= 1040  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 160 && VGA_VERT_COORD < 864 || VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 160 && VGA_VERT_COORD < 192 || VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 832 && VGA_VERT_COORD < 864 ;
        wire background_column_b10 = ~sw[7] ? VGA_HORZ_COORD >= 800 && VGA_HORZ_COORD < 880 :  VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 240 && VGA_VERT_COORD >= 160&& VGA_VERT_COORD < 864 || VGA_HORZ_COORD >= 1040  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 160 && VGA_VERT_COORD < 864 || VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 160 && VGA_VERT_COORD < 192 || VGA_HORZ_COORD >= 240  && VGA_HORZ_COORD < 1040 && VGA_VERT_COORD >= 832 && VGA_VERT_COORD < 864 ;
        wire background_column_r11 = ~sw[7] ? VGA_HORZ_COORD >= 880 && VGA_HORZ_COORD < 960 :  VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 200 && VGA_VERT_COORD >= 128&& VGA_VERT_COORD < 896 || VGA_HORZ_COORD >= 1080  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 128 && VGA_VERT_COORD < 896 || VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 128 && VGA_VERT_COORD < 160 || VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 864 && VGA_VERT_COORD < 896 ;
        wire background_column_g11 = ~sw[7] ? VGA_HORZ_COORD >= 880 && VGA_HORZ_COORD < 960 :  VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 200 && VGA_VERT_COORD >= 128&& VGA_VERT_COORD < 896 || VGA_HORZ_COORD >= 1080  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 128 && VGA_VERT_COORD < 896 || VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 128 && VGA_VERT_COORD < 160 || VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 864 && VGA_VERT_COORD < 896 ;
        wire background_column_b11 = ~sw[7] ? VGA_HORZ_COORD >= 880 && VGA_HORZ_COORD < 960 :  VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 200 && VGA_VERT_COORD >= 128&& VGA_VERT_COORD < 896 || VGA_HORZ_COORD >= 1080  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 128 && VGA_VERT_COORD < 896 || VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 128 && VGA_VERT_COORD < 160 || VGA_HORZ_COORD >= 200  && VGA_HORZ_COORD < 1080 && VGA_VERT_COORD >= 864 && VGA_VERT_COORD < 896 ;
        wire background_column_r12 = ~sw[7] ? VGA_HORZ_COORD >= 960 && VGA_HORZ_COORD < 1040 :  VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 160 && VGA_VERT_COORD >= 96&& VGA_VERT_COORD < 928 || VGA_HORZ_COORD >= 1120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 96 && VGA_VERT_COORD < 928 || VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 96 && VGA_VERT_COORD < 128 || VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 896 && VGA_VERT_COORD < 928 ;
        wire background_column_g12 = ~sw[7] ? VGA_HORZ_COORD >= 960 && VGA_HORZ_COORD < 1040 :  VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 160 && VGA_VERT_COORD >= 96&& VGA_VERT_COORD < 928 || VGA_HORZ_COORD >= 1120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 96 && VGA_VERT_COORD < 928 || VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 96 && VGA_VERT_COORD < 128 || VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 896 && VGA_VERT_COORD < 928 ;
        wire background_column_b12 = ~sw[7] ? VGA_HORZ_COORD >= 960 && VGA_HORZ_COORD < 1040 :  VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 160 && VGA_VERT_COORD >= 96&& VGA_VERT_COORD < 928 || VGA_HORZ_COORD >= 1120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 96 && VGA_VERT_COORD < 928 || VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 96 && VGA_VERT_COORD < 128 || VGA_HORZ_COORD >= 160  && VGA_HORZ_COORD < 1120 && VGA_VERT_COORD >= 896 && VGA_VERT_COORD < 928 ;
        wire background_column_r13 = ~sw[7] ? VGA_HORZ_COORD >= 1040 && VGA_HORZ_COORD < 1120 :  VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 120 && VGA_VERT_COORD >= 64&& VGA_VERT_COORD < 960 || VGA_HORZ_COORD >= 1160  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 64 && VGA_VERT_COORD < 960 || VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 64 && VGA_VERT_COORD < 96 || VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 960 ;
        wire background_column_g13 = ~sw[7] ? VGA_HORZ_COORD >= 1040 && VGA_HORZ_COORD < 1120 :  VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 120 && VGA_VERT_COORD >= 64&& VGA_VERT_COORD < 960 || VGA_HORZ_COORD >= 1160  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 64 && VGA_VERT_COORD < 960 || VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 64 && VGA_VERT_COORD < 96 || VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 960 ;
        wire background_column_b13 = ~sw[7] ? VGA_HORZ_COORD >= 1040 && VGA_HORZ_COORD < 1120 :  VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 120 && VGA_VERT_COORD >= 64&& VGA_VERT_COORD < 960 || VGA_HORZ_COORD >= 1160  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 64 && VGA_VERT_COORD < 960 || VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 64 && VGA_VERT_COORD < 96 || VGA_HORZ_COORD >= 120  && VGA_HORZ_COORD < 1160 && VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 960 ;
        wire background_column_r14 = ~sw[7] ? VGA_HORZ_COORD >= 1120 && VGA_HORZ_COORD < 1200 :  VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 80 && VGA_VERT_COORD >= 32&& VGA_VERT_COORD < 992 || VGA_HORZ_COORD >= 1200  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 32 && VGA_VERT_COORD < 992 || VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 32 && VGA_VERT_COORD < 64 || VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 960 && VGA_VERT_COORD < 992 ;
        wire background_column_g14 = ~sw[7] ? VGA_HORZ_COORD >= 1120 && VGA_HORZ_COORD < 1200 :  VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 80 && VGA_VERT_COORD >= 32&& VGA_VERT_COORD < 992 || VGA_HORZ_COORD >= 1200  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 32 && VGA_VERT_COORD < 992 || VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 32 && VGA_VERT_COORD < 64 || VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 960 && VGA_VERT_COORD < 992 ;
        wire background_column_b14 = ~sw[7] ? VGA_HORZ_COORD >= 1120 && VGA_HORZ_COORD < 1200 :  VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 80 && VGA_VERT_COORD >= 32&& VGA_VERT_COORD < 992 || VGA_HORZ_COORD >= 1200  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 32 && VGA_VERT_COORD < 992 || VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 32 && VGA_VERT_COORD < 64 || VGA_HORZ_COORD >= 80  && VGA_HORZ_COORD < 1200 && VGA_VERT_COORD >= 960 && VGA_VERT_COORD < 992 ;
        wire background_column_r15 = ~sw[7] ? VGA_HORZ_COORD >= 1200 && VGA_HORZ_COORD < 1280 :  VGA_HORZ_COORD >= 0  && VGA_HORZ_COORD < 40 && VGA_VERT_COORD >= 0&& VGA_VERT_COORD < 1024 || VGA_HORZ_COORD >= 1240  && VGA_HORZ_COORD < 1280 && VGA_VERT_COORD >= 0 && VGA_VERT_COORD < 1024 || VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 0 && VGA_VERT_COORD < 32 || VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 992 && VGA_VERT_COORD < 1024 ;
        wire background_column_g15 = ~sw[7] ? VGA_HORZ_COORD >= 1200 && VGA_HORZ_COORD < 1280 :  VGA_HORZ_COORD >= 0  && VGA_HORZ_COORD < 40 && VGA_VERT_COORD >= 0&& VGA_VERT_COORD < 1024 || VGA_HORZ_COORD >= 1240  && VGA_HORZ_COORD < 1280 && VGA_VERT_COORD >= 0 && VGA_VERT_COORD < 1024 || VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 0 && VGA_VERT_COORD < 32 || VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 992 && VGA_VERT_COORD < 1024 ;
        wire background_column_b15 = ~sw[7] ? VGA_HORZ_COORD >= 1200 && VGA_HORZ_COORD < 1280 :  VGA_HORZ_COORD >= 0  && VGA_HORZ_COORD < 40 && VGA_VERT_COORD >= 0&& VGA_VERT_COORD < 1024 || VGA_HORZ_COORD >= 1240  && VGA_HORZ_COORD < 1280 && VGA_VERT_COORD >= 0 && VGA_VERT_COORD < 1024 || VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 0 && VGA_VERT_COORD < 32 || VGA_HORZ_COORD >= 40  && VGA_HORZ_COORD < 1240 && VGA_VERT_COORD >= 992 && VGA_VERT_COORD < 1024 ;


         //Toggling x&y axis
         always @ (posedge push_btn_clock) begin
              if (sw[3]==1) begin
                Vertical_Counter = (btnU==1)?Vertical_Counter-1:(btnD==1)?Vertical_Counter+1: Vertical_Counter;
                Horizontal_Counter = (btnL==1)?Horizontal_Counter-1:(btnR==1)?Horizontal_Counter+1:Horizontal_Counter;
                if (btnL==0 && btnR==0 && btnU==0 && btnD==0 && btnC==1) begin
                    Vertical_Counter = 512;
                    Horizontal_Counter = 640;
                  end
                  if (Horizontal_Counter>=1280) begin
                     Horizontal_Counter=1;
                      end
                      else if (Horizontal_Counter<=0) begin
                      Horizontal_Counter=1279;
                  end
                      else if (Vertical_Counter>=1024) begin
                      Vertical_Counter=1;
                      end
                      else if (Vertical_Counter<=0) begin
                        Vertical_Counter=1023;
                      end
                   end
                if (sw[4]) begin
                Color_Sel = b_left ? Color_Sel + 1 : b_right ? Color_Sel - 1 : Color_Sel;
                    if (Color_Sel > 6) begin // Change accordingly to number of wave
                    Color_Sel = 1;
                    end
                    else if (Color_Sel  == 0) begin
                    Color_Sel=6;
                    end
                end
            end    

   
              
     
         assign Background_Rs = background_column_r0 ? Scrolling_R[0] : (background_column_r1 ? Scrolling_R[1] : (background_column_r2 ? Scrolling_R[2] : (background_column_r3 ? Scrolling_R[3] : (background_column_r4 ? Scrolling_R[4] : (background_column_r5 ? Scrolling_R[5] : (background_column_r6 ? Scrolling_R[6] : (background_column_r7 ? Scrolling_R[7] : (background_column_r8 ? Scrolling_R[8] : 
         (background_column_r9 ? Scrolling_R[9] : (background_column_r10 ? Scrolling_R[10] : (background_column_r11 ? Scrolling_R[11] : (background_column_r12 ? Scrolling_R[12] : (background_column_r13 ? Scrolling_R[13] : (background_column_r14 ? Scrolling_R[14] : (background_column_r15 ? Scrolling_R[15] : 0)))))))))))))));
         assign Background_Gs = background_column_g0 ? Scrolling_G[0] : (background_column_g1 ? Scrolling_G[1] : (background_column_g2 ? Scrolling_G[2] : (background_column_g3 ? Scrolling_G[3] : (background_column_g4 ? Scrolling_G[4] : (background_column_g5 ? Scrolling_G[5] : (background_column_g6 ? Scrolling_G[6] : (background_column_g7 ? Scrolling_G[7] : (background_column_g8 ? Scrolling_G[8] : 
         (background_column_g9 ? Scrolling_G[9] : (background_column_g10 ? Scrolling_G[10] : (background_column_g11 ? Scrolling_G[11] : (background_column_g12 ? Scrolling_G[12] : (background_column_g13 ? Scrolling_G[13] : (background_column_g14 ? Scrolling_G[14] : (background_column_g15 ? Scrolling_G[15] : 0)))))))))))))));
         assign Background_Bs = background_column_b0 ? Scrolling_B[0] : (background_column_b1 ? Scrolling_B[1] : (background_column_b2 ? Scrolling_B[2] : (background_column_b3 ? Scrolling_B[3] : (background_column_b4 ? Scrolling_B[4] : (background_column_b5 ? Scrolling_B[5] : (background_column_b6 ? Scrolling_B[6] : (background_column_b7 ? Scrolling_B[7] : (background_column_b8 ? Scrolling_B[8] : 
         (background_column_b9 ? Scrolling_B[9] : (background_column_b10 ? Scrolling_B[10] : (background_column_b11 ? Scrolling_B[11] : (background_column_b12 ? Scrolling_B[12] : (background_column_b13 ? Scrolling_B[13] : (background_column_b14 ? Scrolling_B[14] : (background_column_b15 ? Scrolling_B[15] : 0)))))))))))))));
         
         assign Background_R = sw[6] ? Background_Rs : Background_Rn;
         assign Background_G = sw[6] ? Background_Gs : Background_Gn;
         assign Background_B = sw[6] ? Background_Bs : Background_Bn;
     
             always @(posedge clk_var)begin
             Scrolling_R[15] <= Scrolling_R[14];
             Scrolling_G[15] <= Scrolling_G[14];
             Scrolling_B[15] <= Scrolling_B[14];
             
             Scrolling_R[14] <= Scrolling_R[13];
             Scrolling_G[14] <= Scrolling_G[13];
             Scrolling_B[14] <= Scrolling_B[13];
             
             Scrolling_R[13] <= Scrolling_R[12];
             Scrolling_G[13] <= Scrolling_G[12];
             Scrolling_B[13] <= Scrolling_B[12];
             
             Scrolling_R[12] <= Scrolling_R[11];
             Scrolling_G[12] <= Scrolling_G[11];
             Scrolling_B[12] <= Scrolling_B[11];
             
             Scrolling_R[11] <= Scrolling_R[10];
             Scrolling_G[11] <= Scrolling_G[10];
             Scrolling_B[11] <= Scrolling_B[10];
             
             Scrolling_R[10] <= Scrolling_R[9];
             Scrolling_G[10] <= Scrolling_G[9];
             Scrolling_B[10] <= Scrolling_B[9];
             
             Scrolling_R[9] <= Scrolling_R[8];
             Scrolling_G[9] <= Scrolling_G[8];
             Scrolling_B[9] <= Scrolling_B[8];
             
             Scrolling_R[8] <= Scrolling_R[7];
             Scrolling_G[8] <= Scrolling_G[7];
             Scrolling_B[8] <= Scrolling_B[7];
             
             Scrolling_R[7] <= Scrolling_R[6];
             Scrolling_G[7] <= Scrolling_G[6];
             Scrolling_B[7] <= Scrolling_B[6];
             
             Scrolling_R[6] <= Scrolling_R[5];
             Scrolling_G[6] <= Scrolling_G[5];
             Scrolling_B[6] <= Scrolling_B[5];
             
             Scrolling_R[5] <= Scrolling_R[4];
             Scrolling_G[5] <= Scrolling_G[4];
             Scrolling_B[5] <= Scrolling_B[4];
             
             Scrolling_R[4] <= Scrolling_R[3];
             Scrolling_G[4] <= Scrolling_G[3];
             Scrolling_B[4] <= Scrolling_B[3];
             
             Scrolling_R[3] <= Scrolling_R[2];
             Scrolling_G[3] <= Scrolling_G[2];
             Scrolling_B[3] <= Scrolling_B[2];
             
             Scrolling_R[2] <= Scrolling_R[1];
             Scrolling_G[2] <= Scrolling_G[1];
             Scrolling_B[2] <= Scrolling_B[1];
             
             Scrolling_R[1] <= Scrolling_R[0];
             Scrolling_G[1] <= Scrolling_G[0];
             Scrolling_B[1] <= Scrolling_B[0];
             
     
             Scrolling_R[0] = red;
             Scrolling_G[0] = green;
             Scrolling_B[0] = blue;
             
             end
             
         
             always @ (*) begin
             if(sw[5])begin
                Background_Rn = red;
                Background_Gn = green;
                Background_Bn = blue;
             end
             if(sw[2]) begin
             Foreground_R = 4'hf - Background_R;
             Foreground_G = 4'hf - Background_G;
             Foreground_B = 4'hf - Background_B;
             end 
             else begin
             Foreground_R = Background_R;
             Foreground_G = Background_G;
             Foreground_B = Background_B;
             end
             
             
             
             if(~sw[5])begin
                     case(Color_Sel)
                         1:
                             begin
                             Background_Rn = 4'h0;
                             Background_Gn = 4'h0;
                             Background_Bn = 4'h0;
                             end
                         2:
                             begin
                             Background_Rn = 4'h3;
                             Background_Gn = 4'h6;
                             Background_Bn = 4'h9;
                             end
                         3:
                             begin
                             Background_Rn = 4'h9;
                             Background_Gn = 4'h6;
                             Background_Bn = 4'h3;
                             end
                         4:
                             begin
                             Background_Rn = 4'h6;
                             Background_Gn = 4'h6;
                             Background_Bn = 4'h3;
                             end
                         5:
                             begin
                             Background_Rn = 4'h3;
                             Background_Gn = 4'h6;
                             Background_Bn = 4'h6;
                             end
                         6:
                             begin
                             Background_Rn = 4'h0;
                             Background_Gn = 4'h3;
                             Background_Bn = 4'h6;
             
                             end
           
                         default:
                             begin
                             Background_Rn = 0;
                             Background_Gn = 0;
                             Background_Bn = 0;
                             end
                     endcase
                 end
         end
         
     // Please modify below codes to change the background color and to display ticks defined above
         assign VGA_Red_Grid = Condition_Combined_R ? Foreground_R : Background_R;
         assign VGA_Green_Grid = Condition_Combined_G ? Foreground_G : Background_G;
         assign VGA_Blue_Grid = Condition_Combined_B ? Foreground_B : Background_B;
                                 // if true, a red pixel is put at coordinates (VGA_HORZ_COORD, VGA_VERT_COORD),
endmodule


