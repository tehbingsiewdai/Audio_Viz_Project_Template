`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 15:19:56
// Design Name: 
// Module Name: VGA_Text
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


module VGA_Text(
    input CLK_VGA,
    input btn_clk,
    input [15:0]sw,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD, 
    input paused,
    input btnC,
    output reg [3:0] VGA_R_Text,
    output reg [3:0] VGA_G_Text,
    output reg [3:0] VGA_B_Text
    );
    
    reg [3:0] Song_Name = 0;
    wire [32:0]Text_res; //Each bit assigned to each text
    wire next_song; single_pulse(btn_clk, btnC, next_song);
    reg [32:0]Displaytext_res;
    reg [3:0] on_blue = 4'hf;
    Pixel_On_Text2 #(.displayText("Done By Jody and Lucas")) t1(
      CLK_VGA,
      1000, // text position.x (top left)
      10, // text position.y (top left)
      VGA_HORZ_COORD, // current position.x
      VGA_VERT_COORD, // current position.y
       Text_res[0]  // result, 1 if current pixel is on text, 0 otherwise
       );
    
    Pixel_On_Text2 #(.displayText("Flip SW1 for MENU/HELP")) t2(
            CLK_VGA,
            1000, // text position.x (top left)
            30, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
             Text_res[1]  // result, 1 if current pixel is on text, 0 otherwise
              );
    //MENU
    //always @ (*) begin
    //if (sw[9]==1) begin
    Pixel_On_Text2 #(.displayText("MENU")) t3(
            CLK_VGA,
            1000, // text position.x (top left)
            10, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
             Text_res[2]  // result, 1 if current pixel is on text, 0 otherwise
             );
    Pixel_On_Text2 #(.displayText("SW2: Axis ON/OFF")) t4(
            CLK_VGA,
            1000, // text position.x (top left)
            30, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[3]  // result, 1 if current pixel is on text, 0 otherwise
            );
    Pixel_On_Text2 #(.displayText("SW3: Axis Movement")) t5(
            CLK_VGA,
            1000, // text position.x (top left)
            50, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[4]  // result, 1 if current pixel is on text, 0 otherwise
            );
            
    Pixel_On_Text2 #(.displayText("SW4: Colour Selection")) t6(
            CLK_VGA,
            1000, // text position.x (top left)
            70, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[5]  // result, 1 if current pixel is on text, 0 otherwise
            );
    Pixel_On_Text2 #(.displayText("SW5: Auto Backgrond Colour")) t7(
            CLK_VGA,
            1000, // text position.x (top left)
            90, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[6]  // result, 1 if current pixel is on text, 0 otherwise
            );
    Pixel_On_Text2 #(.displayText("SW6: Scrolling Background Colour")) t8(
            CLK_VGA,
            1000, // text position.x (top left)
            110, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[7]  // result, 1 if current pixel is on text, 0 otherwise
            );
            
    Pixel_On_Text2 #(.displayText("SW12: Scrolling Waveform")) t9(
            CLK_VGA,
            1000, // text position.x (top left)
            130, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[8]  // result, 1 if current pixel is on text, 0 otherwise
            );
            

                        
    Pixel_On_Text2 #(.displayText("SW13: Waveform Selection")) t10(
            CLK_VGA,
            1000, // text position.x (top left)
            150, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[9]  // result, 1 if current pixel is on text, 0 otherwise
            );
            
     Pixel_On_Text2 #(.displayText("SW14: Wave Width")) t11(
            CLK_VGA,
            1000, // text position.x (top left)
            170, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[10]  // result, 1 if current pixel is on text, 0 otherwise
            );                    


    Pixel_On_Text2 #(.displayText("SW15: Freeze Waveform")) t12(
            CLK_VGA,
            1000, // text position.x (top left)
            190, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[11]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
                       
    Pixel_On_Text2 #(.displayText("btnU/btnD/btnL/btnR to move the axis")) t13(
            CLK_VGA,
            0, // text position.x (top left)
            50, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[12]  // result, 1 if current pixel is on text, 0 otherwise
            );            
    Pixel_On_Text2 #(.displayText("btnL/btnR to cycle through colors")) t14(
            CLK_VGA,
            0, // text position.x (top left)
            70, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[13]  // result, 1 if current pixel is on text, 0 otherwise
            );            
   Pixel_On_Text2 #(.displayText("btnU and btnD to increase/decrease scroll speed")) t15(
            CLK_VGA,
            0, // text position.x (top left)
            90, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[14]  // result, 1 if current pixel is on text, 0 otherwise
            );            
   Pixel_On_Text2 #(.displayText("BtnL / BtnR to cycle through waveforms")) t16(
            CLK_VGA,
            0, // text position.x (top left)
            150, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[15]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
   Pixel_On_Text2 #(.displayText("BtnL / BtnR to Increse/Decrese Bar sizes")) t17(
            CLK_VGA,
            0, // text position.x (top left)
            170, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[16]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
   Pixel_On_Text2 #(.displayText("Freeze waveforms")) t18(
            CLK_VGA,
            0, // text position.x (top left)
            190, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[17]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
       Pixel_On_Text2 #(.displayText("Scroll Mode: Left To right - Toggle SW7 for Circle")) t19(
            CLK_VGA,
            0, // text position.x (top left)
            110, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[18]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
           Pixel_On_Text2 #(.displayText("Scroll Mode: Circle - Toggle SW7 for Left To right")) t22(
            CLK_VGA,
            0, // text position.x (top left)
            110, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[21]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
       Pixel_On_Text2 #(.displayText("Scroll Paused: Press btnC to Start")) t20(
            CLK_VGA,
            0, // text position.x (top left)
            130, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[19]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
       Pixel_On_Text2 #(.displayText("Scrolling: Press btnC to Pause")) t21(
            CLK_VGA,
            0, // text position.x (top left)
            130, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[20]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
      Pixel_On_Text2 #(.displayText("TOTALLY LEGIT SONG RECOGNISER: RECOGNISING...")) t23(
            CLK_VGA,
            500, // text position.x (top left)
            0, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[22]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
             
      Pixel_On_Text2 #(.displayText("TOTALLY LEGIT SONG RECOGNISER: DESPACITO - Luis Fonsi")) t24(
            CLK_VGA,
            500, // text position.x (top left)
            0, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[23]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
      Pixel_On_Text2 #(.displayText("TOTALLY LEGIT SONG RECOGNISER: Blue(Da Ba Dee) - Eiffel 65")) t25(
            CLK_VGA,
            500, // text position.x (top left)
            0, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[24]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
      Pixel_On_Text2 #(.displayText("TOTALLY LEGIT SONG RECOGNISER:  All Star - Smash Mouth ")) t26(
            CLK_VGA,
            500, // text position.x (top left)
            0, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[25]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
     Pixel_On_Text2 #(.displayText("TOTALLY LEGIT SONG RECOGNISER: Never Gonna Give You Up - Rick Astley ")) t27(
            CLK_VGA,
            500, // text position.x (top left)
            0, // text position.y (top left)
            VGA_HORZ_COORD, // current position.x
            VGA_VERT_COORD, // current position.y
            Text_res[26]  // result, 1 if current pixel is on text, 0 otherwise
            ); 
    //end
    //end
   always@ (posedge next_song)begin
        Song_Name = Song_Name + 1 ;
   end
      
   
   
   always @(posedge CLK_VGA)begin
       if (sw[1]) begin
            on_blue = 4'hf;
            Displaytext_res = Text_res[11:2];
              if(sw[2])begin
                  if(Text_res[3])
                     on_blue = 0;
                  // else 
                    // on_blue = 4'hf;
              end
            if(sw[3])begin
              Displaytext_res = Displaytext_res | Text_res[12];
              if(Text_res[4])
                 on_blue = 0;
              // else 
                // on_blue = 4'hf;
              end
              if(sw[4])begin
              Displaytext_res = Displaytext_res | Text_res[13];
                 if(Text_res[5])
                   on_blue = 0;
                 //else 
                    //on_blue = 4'hf;
              end
              if(sw[5])begin
              Displaytext_res = Displaytext_res | Text_res[14];
              Displaytext_res = paused ? Displaytext_res | Text_res[19] : Displaytext_res | Text_res[20];
                 if(Text_res[6])
                   on_blue = 0;
                 //else 
                    //on_blue = 4'hf;
              end
              if(sw[6])begin
              Displaytext_res = Displaytext_res | Text_res[14];
                 if(Text_res[7])
                   on_blue = 0;
                 //else 
                    //on_blue = 4'hf;
              end
              if(sw[12])begin
              Displaytext_res = Displaytext_res | Text_res[14];
                 if(Text_res[8])
                   on_blue = 0;
                 //else 
                    //on_blue = 4'hf;
              end
              if(sw[13])begin
              Displaytext_res = Displaytext_res | Text_res[15];
                 if(Text_res[9])
                   on_blue = 0;
                 //else 
                    //on_blue = 4'hf;
              end
              if(sw[14])begin
              Displaytext_res = Displaytext_res | Text_res[16];
                 if(Text_res[10])
                   on_blue = 0;
                 //else 
                    //on_blue = 4'hf;
              end
              if(sw[15])begin
              Displaytext_res = Displaytext_res | Text_res[17];
                 if(Text_res[11])
                   on_blue = 0;
                 //else 
                    //on_blue = 4'hf;
              end
              if(sw[6] | sw[12]) begin
                Displaytext_res = sw[7] ? Displaytext_res |  Text_res[21]: Displaytext_res | Text_res[18];
                Displaytext_res = paused ? Displaytext_res | Text_res[19] : Displaytext_res | Text_res[20];
              end
              if(sw[8]) 
                case(Song_Name)
                    1: Displaytext_res = Displaytext_res | Text_res[23];
                    3: Displaytext_res = Displaytext_res | Text_res[24];
                    5: Displaytext_res = Displaytext_res | Text_res[25];
                    7: Displaytext_res = Displaytext_res | Text_res[26];
                    default: Displaytext_res = Displaytext_res | Text_res[22];
                endcase
       end
       else begin
        Displaytext_res = Text_res[1:0];
       end 
       if(Displaytext_res)begin
           VGA_R_Text = 4'hf;
           VGA_G_Text = 4'hf;
           VGA_B_Text = 4'hf & on_blue;
        end
       else begin
           VGA_R_Text = 0;
           VGA_G_Text = 0;
           VGA_B_Text = 0;
       end
   end
   
endmodule
