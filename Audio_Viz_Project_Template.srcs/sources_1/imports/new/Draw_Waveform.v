`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// You may study and modify the code inside this module to imporve the display feature or introduce other features
//////////////////////////////////////////////////////////////////////////////////

module Draw_Waveform(
    input clk,
    input clk_sample, //20kHz clock
    input clk_slow_wave,
    input [3:0] r,
    input [3:0] g,
    input [3:0] b,
    input push_btn_clock,
    input [15:0]sw,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    input [9:0] wave_sample,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    output [3:0] VGA_Red_waveform,
    output [3:0] VGA_Green_waveform,
    output [3:0] VGA_Blue_waveform
    );
    
    wire [3:0] Background_R;
    wire [3:0] Background_G;
    wire [3:0] Background_B;
    reg [3:0] Background_Rn = 4'hf;
    reg [3:0] Background_Gn = 4'hf;
    reg [3:0] Background_Bn = 4'hf;
    wire [3:0] Background_Rs;
    wire [3:0] Background_Gs;
    wire [3:0] Background_Bs;
    reg [3:0] Scrolling_R[15:0];
    reg [3:0] Scrolling_G [15:0];
    reg [3:0] Scrolling_B[15:0] ;
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
    
    assign Background_R = sw[12] ? Background_Rs : Background_Rn;
    assign Background_G = sw[12] ? Background_Gs : Background_Gn;
    assign Background_B = sw[12] ? Background_Bs : Background_Bn;
    

    assign Background_Rs = background_column_r0 ? Scrolling_R[0] : (background_column_r1 ? Scrolling_R[1] : (background_column_r2 ? Scrolling_R[2] : (background_column_r3 ? Scrolling_R[3] : (background_column_r4 ? Scrolling_R[4] : (background_column_r5 ? Scrolling_R[5] : (background_column_r6 ? Scrolling_R[6] : (background_column_r7 ? Scrolling_R[7] : (background_column_r8 ? Scrolling_R[8] : 
    (background_column_r9 ? Scrolling_R[9] : (background_column_r10 ? Scrolling_R[10] : (background_column_r11 ? Scrolling_R[11] : (background_column_r12 ? Scrolling_R[12] : (background_column_r13 ? Scrolling_R[13] : (background_column_r14 ? Scrolling_R[14] : (background_column_r15 ? Scrolling_R[15] : 0)))))))))))))));
    assign Background_Gs = background_column_g0 ? Scrolling_G[0] : (background_column_g1 ? Scrolling_G[1] : (background_column_g2 ? Scrolling_G[2] : (background_column_g3 ? Scrolling_G[3] : (background_column_g4 ? Scrolling_G[4] : (background_column_g5 ? Scrolling_G[5] : (background_column_g6 ? Scrolling_G[6] : (background_column_g7 ? Scrolling_G[7] : (background_column_g8 ? Scrolling_G[8] : 
    (background_column_g9 ? Scrolling_G[9] : (background_column_g10 ? Scrolling_G[10] : (background_column_g11 ? Scrolling_G[11] : (background_column_g12 ? Scrolling_G[12] : (background_column_g13 ? Scrolling_G[13] : (background_column_g14 ? Scrolling_G[14] : (background_column_g15 ? Scrolling_G[15] : 0)))))))))))))));
    assign Background_Bs = background_column_b0 ? Scrolling_B[0] : (background_column_b1 ? Scrolling_B[1] : (background_column_b2 ? Scrolling_B[2] : (background_column_b3 ? Scrolling_B[3] : (background_column_b4 ? Scrolling_B[4] : (background_column_b5 ? Scrolling_B[5] : (background_column_b6 ? Scrolling_B[6] : (background_column_b7 ? Scrolling_B[7] : (background_column_b8 ? Scrolling_B[8] : 
    (background_column_b9 ? Scrolling_B[9] : (background_column_b10 ? Scrolling_B[10] : (background_column_b11 ? Scrolling_B[11] : (background_column_b12 ? Scrolling_B[12] : (background_column_b13 ? Scrolling_B[13] : (background_column_b14 ? Scrolling_B[14] : (background_column_b15 ? Scrolling_B[15] : 0)))))))))))))));
    
        always @(posedge clk)begin
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
        

        Scrolling_R[0] = r;
        Scrolling_G[0] = g;
        Scrolling_B[0] = b;
        
        end
        
    //The Sample_Memory represents the memory array used to store the voice samples.
    //There are 1280 points and each point can range from 0 to 1023. 
    reg [9:0] Sample_Memory[1279:0];
    reg [9:0] Sample_Memory_Average[1279:0];
    reg [9:0] Sample_Memory_Slow[1279:0]; //Slow wave
    reg [10:0] i = 0;
    reg [10:0] j = 10; // Average controller
    reg [10:0] k = 10; //Slow wave
    reg [4:0] wave_selection=1;
    reg [4:0] wave_colourselection=1;
    reg [4:0] Wave_R;
    reg [4:0] Wave_G;
    reg [4:0] Wave_B;
    reg [11:0] Wave_vertical;
    reg [11:0] Wave_horizontal;     
    wire btn_left,btn_right,btn_up,btn_down;
    //Single Pulse
    single_pulse sp1 (push_btn_clock,btnL,btn_left);
    single_pulse sp2 (push_btn_clock,btnR,btn_right);
    single_pulse sp3 (push_btn_clock,btnU,btn_up);
    single_pulse sp4 (push_btn_clock,btnD,btn_down);
    //Each wave_sample is displayed on the screen from left to right. 
    always @ (posedge clk_sample) begin
        i = (i==1279) ? 0 : i + 1;
        if (sw[15]==0) begin
        Sample_Memory[i] <= wave_sample;
        Sample_Memory_Average[i] <= (i % j == 0)? wave_sample : Sample_Memory_Average[i - 1];  
        end    
    end
    //Slow wave
    always @ (posedge clk_slow_wave) begin
            k = (k==1279) ? 0 : k + 1;
            if (sw[15]==0) begin
            Sample_Memory_Slow[k] <= wave_sample;
            end
    end
    //Original
        /*assign VGA_Red_waveform =   ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD]))) ? 4'hf : 4'h0;
        assign VGA_Green_waveform = ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD]))) ? 4'hf : 4'h0;
        assign VGA_Blue_waveform =  ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD]))) ? 4'hf : 4'h0; */
always @ (posedge push_btn_clock) begin
        if (sw[13]==1) begin
        wave_selection = (btn_left==1) ? wave_selection + 1 : (btn_right==1) ? wave_selection - 1 : wave_selection;
            if (wave_selection>=18) begin // Change accordingly to number of wave
            wave_selection=1;
            end
            else if (wave_selection<=0) begin
            wave_selection=17;
            end
        end
        else if (sw[14]==1) begin
        j = (btn_right==1) ? j+1 : (btn_left==1) ? j-1 : j;
            if (j<=1) begin
            j=1278;
            end
            else if (j>=1279) begin
            j=2;        
            end
        end
    end    


always @ (*) begin
    case (wave_selection)
    //Original
    1: begin
        Wave_vertical = (VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD]));
        Wave_horizontal = 0;
        end
    //White top and bottom of waveform
    2:  begin
        Wave_vertical = (VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory[VGA_HORZ_COORD]) || (VGA_VERT_COORD >= (1024-Sample_Memory[VGA_HORZ_COORD])))? 0 : 1;
        Wave_horizontal = 0;
        end
    3:  begin
        Wave_vertical = (VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory_Slow[VGA_HORZ_COORD]) || (VGA_VERT_COORD >= (1024-Sample_Memory_Slow[VGA_HORZ_COORD])))? 0 : 1;
        Wave_horizontal = 0;
        end   
    4:  begin
        Wave_vertical = (VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory_Average[VGA_HORZ_COORD]) || (VGA_VERT_COORD >= (1024 - Sample_Memory_Average[VGA_HORZ_COORD])))? 0 : 1;
        Wave_horizontal = 0;
        end
        // Cool square
    5:  begin
        Wave_vertical = ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory[VGA_HORZ_COORD]) || (VGA_VERT_COORD >= (1024 - Sample_Memory[VGA_HORZ_COORD]))));
        Wave_horizontal = ((VGA_VERT_COORD < 1024) && ((VGA_HORZ_COORD <= Sample_Memory[VGA_VERT_COORD] + 128) || (VGA_HORZ_COORD >= (1280 - 128-Sample_Memory[VGA_VERT_COORD])))); 
        end
    6:  begin
        Wave_vertical = ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory_Average[VGA_HORZ_COORD]) || (VGA_VERT_COORD >= (1024-Sample_Memory_Average[VGA_HORZ_COORD]))));     
        Wave_horizontal = ((VGA_VERT_COORD < 1024) && ((VGA_HORZ_COORD <= Sample_Memory_Average[VGA_VERT_COORD] + 128) || (VGA_HORZ_COORD >= (1280-128-Sample_Memory_Average[VGA_VERT_COORD]))));
        end
        //Vertical and horizontal
    7:  begin
        Wave_vertical = ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory[VGA_HORZ_COORD]) && (VGA_VERT_COORD >= (1024-Sample_Memory[VGA_HORZ_COORD]))));
        Wave_horizontal = ((VGA_VERT_COORD < 1024) && ((VGA_HORZ_COORD <= (Sample_Memory[VGA_VERT_COORD] + 128)) && (VGA_HORZ_COORD >= (1280-128-Sample_Memory[VGA_VERT_COORD]))));
        end
    8:  begin
        Wave_vertical = ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory_Slow[VGA_HORZ_COORD]) && (VGA_VERT_COORD >= (1024-Sample_Memory_Slow[VGA_HORZ_COORD]))));
        Wave_horizontal = ((VGA_VERT_COORD < 1024) && ((VGA_HORZ_COORD <= (Sample_Memory_Slow[VGA_VERT_COORD] + 128)) && (VGA_HORZ_COORD >= (1280-128-Sample_Memory_Slow[VGA_VERT_COORD]))));
        end
    9:  begin
        Wave_vertical = ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory_Average[VGA_HORZ_COORD]) && (VGA_VERT_COORD >= (1024-Sample_Memory_Average[VGA_HORZ_COORD]))));
        Wave_horizontal = ((VGA_VERT_COORD < 1024) && ((VGA_HORZ_COORD <= (Sample_Memory_Average[VGA_VERT_COORD] + 128)) && (VGA_HORZ_COORD >= (1280-128-Sample_Memory_Average[VGA_VERT_COORD]))));
        end 
    10:  begin
        //Bar Graph
        Wave_vertical = ((VGA_HORZ_COORD < 1280) && (VGA_HORZ_COORD % 10 <= 9) && (VGA_VERT_COORD >= Sample_Memory[VGA_HORZ_COORD]));       
        Wave_horizontal = 0;           
        end 
    11:  begin
        Wave_vertical = ((VGA_HORZ_COORD < 1280) && (VGA_HORZ_COORD % 10 <= 9) && (VGA_VERT_COORD >= Sample_Memory_Slow[VGA_HORZ_COORD]));       
        Wave_horizontal = 0;           
        end 
    12: begin
        //Bar Graph Average
        Wave_vertical = ((VGA_HORZ_COORD < 1280) && (VGA_HORZ_COORD % j < j - 1) && (VGA_VERT_COORD >= Sample_Memory_Average[VGA_HORZ_COORD]));      
        Wave_horizontal = 0;
        end  
    13: begin
         // Circle   
       Wave_vertical = (((VGA_VERT_COORD - 512)*(VGA_VERT_COORD - 512))+((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640))<=(Sample_Memory[VGA_HORZ_COORD]/2)*(Sample_Memory[VGA_HORZ_COORD]/2))? 1:0;
       Wave_horizontal = 0;
       end
    14: begin
       Wave_vertical = (((VGA_VERT_COORD - 512)*(VGA_VERT_COORD - 512))+((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640))<=(Sample_Memory_Average[VGA_HORZ_COORD]/2)*(Sample_Memory_Average[VGA_HORZ_COORD]/2))? 1:0;
       Wave_horizontal = 0;
       end
    15: begin
	//Rings
       Wave_vertical = (((VGA_VERT_COORD - 256)*(VGA_VERT_COORD - 256))+((VGA_HORZ_COORD - 320)*(VGA_HORZ_COORD - 320))<=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3)||((VGA_VERT_COORD - 768)*(VGA_VERT_COORD - 768))+((VGA_HORZ_COORD - 320)*(VGA_HORZ_COORD - 320))<=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3)&&((VGA_VERT_COORD - 768)*(VGA_VERT_COORD - 768))+((VGA_HORZ_COORD - 320)*(VGA_HORZ_COORD - 320))>=(Sample_Memory_Average[VGA_HORZ_COORD]/4)*(Sample_Memory_Average[VGA_HORZ_COORD]/4))? 1:0;
       Wave_horizontal = (((VGA_VERT_COORD - 768)*(VGA_VERT_COORD - 768))+((VGA_HORZ_COORD - 960)*(VGA_HORZ_COORD - 960))<=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3)||((VGA_VERT_COORD - 256)*(VGA_VERT_COORD - 256))+((VGA_HORZ_COORD - 960)*(VGA_HORZ_COORD - 960))<=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3)&&((VGA_VERT_COORD - 256)*(VGA_VERT_COORD - 256))+((VGA_HORZ_COORD - 960)*(VGA_HORZ_COORD - 960))>=(Sample_Memory_Average[VGA_HORZ_COORD]/4)*(Sample_Memory_Average[VGA_HORZ_COORD]/4))? 1:0;
       end
    16: begin
	//Infinity loop
       Wave_vertical = (((VGA_VERT_COORD - 512)*(VGA_VERT_COORD - 512))+((VGA_HORZ_COORD - 425)*(VGA_HORZ_COORD - 425))<=(Sample_Memory_Average[VGA_HORZ_COORD]/2)*(Sample_Memory_Average[VGA_HORZ_COORD]/2)&&((VGA_VERT_COORD - 512)*(VGA_VERT_COORD - 512))+((VGA_HORZ_COORD - 425)*(VGA_HORZ_COORD - 425))>=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3))? 1:0;
       Wave_horizontal = (((VGA_VERT_COORD - 512)*(VGA_VERT_COORD - 512))+((VGA_HORZ_COORD - 855)*(VGA_HORZ_COORD - 855))<=(Sample_Memory_Average[VGA_HORZ_COORD]/2)*(Sample_Memory_Average[VGA_HORZ_COORD]/2)&&((VGA_VERT_COORD - 512)*(VGA_VERT_COORD - 512))+((VGA_HORZ_COORD - 855)*(VGA_HORZ_COORD - 855))>=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3))? 1:0;
       end
    17: begin
	//Face
       Wave_vertical = (((VGA_VERT_COORD - 512)*(VGA_VERT_COORD - 512))+((VGA_HORZ_COORD - 340)*(VGA_HORZ_COORD - 340))<=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3)||((VGA_VERT_COORD - 512)*(VGA_VERT_COORD - 512))+((VGA_HORZ_COORD - 940)*(VGA_HORZ_COORD - 940))<=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3))? 1:0;
       Wave_horizontal = ((((VGA_VERT_COORD - 768)*(VGA_VERT_COORD - 768))+((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640))<=(Sample_Memory_Average[VGA_HORZ_COORD]/3)*(Sample_Memory_Average[VGA_HORZ_COORD]/3))&&(((VGA_VERT_COORD - 768)*(VGA_VERT_COORD - 768))+((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640))>=(Sample_Memory_Average[VGA_HORZ_COORD]/4)*(Sample_Memory_Average[VGA_HORZ_COORD]/4))&&(VGA_VERT_COORD>=768))? 1:0;
       end
    default: begin
        //Original pattern
        Wave_vertical =   (VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD]));
        Wave_horizontal = 0;
        end
        endcase
    end
       /*wire [11:0] Red_vertical = ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory[VGA_HORZ_COORD]) || (VGA_VERT_COORD >= (1024-Sample_Memory[VGA_HORZ_COORD]))));
       wire [11:0] Green_vertical = ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory[VGA_HORZ_COORD]) || (VGA_VERT_COORD >= (1024-Sample_Memory[VGA_HORZ_COORD]))));
       wire [11:0] Blue_vertical = ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD <= Sample_Memory[VGA_HORZ_COORD]) || (VGA_VERT_COORD >= (1024-Sample_Memory[VGA_HORZ_COORD]))));
            
       wire [11:0] Red_horizontal = ((VGA_VERT_COORD < 1024) && ((VGA_HORZ_COORD <= (Sample_Memory[VGA_VERT_COORD]+128)) && (VGA_HORZ_COORD >= (1280-128-Sample_Memory[VGA_VERT_COORD]))));
       wire [11:0] Green_horizontal = ((VGA_VERT_COORD < 1024) && ((VGA_HORZ_COORD <= (Sample_Memory[VGA_VERT_COORD]+128)) && (VGA_HORZ_COORD >= (1280-128-Sample_Memory[VGA_VERT_COORD]))));
       wire [11:0] Blue_horizontal = ((VGA_VERT_COORD < 1024) && ((VGA_HORZ_COORD <= (Sample_Memory[VGA_VERT_COORD]+128)) && (VGA_HORZ_COORD >= (1280-128-Sample_Memory[VGA_VERT_COORD]))));
    */
    wire [11:0] Waveform_condition = (Wave_vertical || Wave_horizontal);         
    
    assign VGA_Red_waveform =  Waveform_condition  ? Background_R : 4'h0;
    assign VGA_Green_waveform = Waveform_condition ? Background_G : 4'h0;
    assign VGA_Blue_waveform =  Waveform_condition ? Background_B : 4'h0;
    
endmodule
