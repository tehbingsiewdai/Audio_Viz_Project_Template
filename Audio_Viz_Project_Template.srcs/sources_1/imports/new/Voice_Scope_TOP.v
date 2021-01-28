`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// National University of Singapore
// Department of Electrical and Computer Engineering
// EE2026 Digital Design
// AY1819 Semester 2
// Project: Voice Scope
//////////////////////////////////////////////////////////////////////////////////

module Voice_Scope_TOP(
    input CLK,
    input [15:0] sw,
    input btnU, btnD, btnL, btnR, btnC,
    
    input  J_MIC3_Pin3,   // PmodMIC3 audio input data (serial)
    output J_MIC3_Pin1,   // PmodMIC3 chip select, 20kHz sampling clock
    output J_MIC3_Pin4,   // PmodMIC3 serial clock (generated by module VoiceCapturer.v)
    
   
    output [3:0] VGA_RED,    // RGB outputs to VGA connector (4 bits per channel gives 4096 possible colors)
    output [3:0] VGA_GREEN,
    output [3:0] VGA_BLUE,
    
    output VGA_VS,          // horizontal & vertical sync outputs to VGA connector
    output VGA_HS,
    output [11:0]led,
    output [3:0] an,
    output [7:0] seg
    );
       
   
      
       
//-----------------------------------------------------------------------------
//                  STUDENT A - MIC
//-----------------------------------------------------------------------------

       
       
    
// Please create a clock divider module to generate a 20kHz clock signal. 
// Instantiate it below
    wire clk_20k; clk_div cl20k (CLK,'d2499,clk_20k);
    wire clk_10; clk_div cl10(CLK,'d4999999, clk_10);
    wire clk_50; clk_div cl50(CLK, 'd999999 , clk_50);
    wire clk_20;clk_div cl20(CLK,'d2499999,clk_20); 
    wire clk_var; clk_div_var clx(CLK,clk_50,sw[15:0], btnU, btnD, clk_var);   
   
       
// Please instantiate the voice capturer module below
    wire [9:0] wave_sample; 
    wire [10:0] testwave; 
    wire [11:0]MIC_in;
    wire [11:0]VOL;
    Voice_Capturer fa2 (CLK,clk_20k,J_MIC3_Pin3,J_MIC3_Pin1,J_MIC3_Pin4,MIC_in);   
    Volume_Indicator fa3 (MIC_in,clk_10,clk_20k,VOL,an,seg);
    TestWave_Gen twgen(clk_20k,testwave);
  
    assign wave_sample = sw[0] ? MIC_in[11:2] : testwave ;
    assign led = VOL;

 

//-----------------------------------------------------------------------------
//                  STUDENT B - VGA
//-----------------------------------------------------------------------------

    // VGA Clock Generator (108MHz)
    wire CLK_VGA;
    CLK_108M VGA_CLK_108M( 
            CLK,   // 100 MHz
            CLK_VGA     // 108 MHz
        ) ; 
//Buttons
    wire [11:0] VGA_HORZ_COORD;
    wire [11:0] VGA_VERT_COORD; 

//Text instanstiation
    wire [3:0] VGA_R_Text;
    wire [3:0] VGA_G_Text;
    wire [3:0] VGA_B_Text; 
    
// Please instantiate the waveform drawer module below
    
    wire [3:0] VGA_Red_waveform;
    wire [3:0] VGA_Green_waveform;
    wire [3:0] VGA_Blue_waveform;    
    
    

// Please instantiate the background drawing module below   
    wire [3:0] VGA_Red_grid;
    wire [3:0] VGA_Green_grid;
    wire [3:0] VGA_Blue_grid;
    
    wire [3:0] red;
    wire [3:0] green;
    wire [3:0] blue;
    wire paused;
// Please instantiate the VGA display module below
    VGA_Text(CLK_VGA,clk_50 ,sw[15:0],VGA_HORZ_COORD,VGA_VERT_COORD, paused, btnC ,VGA_R_Text,VGA_G_Text,VGA_B_Text);
    colorgen cg(clk_var,clk_50, sw[15:0],btnC ,red, green, blue, paused);
    Draw_Waveform wv(clk_var,clk_20k,clk_50,red, green, blue,clk_20,sw,btnL,btnR,btnU,btnD,wave_sample,VGA_HORZ_COORD,VGA_VERT_COORD, VGA_Red_waveform,VGA_Green_waveform, VGA_Blue_waveform);      //    Draw_Avg_Waveform wv(clk_20k, sw[15], sw[4:2], wave_sample,VGA_HORZ_COORD,VGA_VERT_COORD, VGA_Red_waveform,VGA_Green_waveform, VGA_Blue_waveform);
    Draw_Background bg(clk_50, clk_var,sw[15:0], btnU,btnD,btnL,btnR,btnC ,red, green, blue, VGA_HORZ_COORD, VGA_VERT_COORD, VGA_Red_grid, VGA_Green_grid, VGA_Blue_grid);
    VGA_DISPLAY disp(CLK_VGA, VGA_Red_waveform, VGA_Green_waveform, VGA_Blue_waveform,VGA_Red_grid, VGA_Green_grid,VGA_Blue_grid,VGA_R_Text,VGA_G_Text,VGA_B_Text, VGA_HORZ_COORD, VGA_VERT_COORD, VGA_RED, VGA_GREEN, VGA_BLUE,VGA_VS,VGA_HS);
     
     
                    
endmodule