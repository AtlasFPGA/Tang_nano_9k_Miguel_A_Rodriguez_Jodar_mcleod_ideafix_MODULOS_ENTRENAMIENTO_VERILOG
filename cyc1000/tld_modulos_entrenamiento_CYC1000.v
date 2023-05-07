/*
 * This file is part of "Modulos de entrenamiento para FPGAs"
 * Copyright (c) 2018 Miguel Angel Rodriguez Jodar.
 * 
 * This program is free software: you can redistribute it and/or modify  
 * it under the terms of the GNU General Public License as published by  
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License 
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

`timescale 1ns / 1ps
`default_nettype none

module tld_modulos_entrenamiento_CYC1000 (
  input wire clk12mhz,
  input wire clkps2,
  input wire dataps2,
 // output wire [7:0] Out_TMDS
  
  	output wire Out_TMDS_D0,		
	output wire Out_TMDS_D1,
	output wire Out_TMDS_D1_N,		
	output wire Out_TMDS_D2,		
	output wire Out_TMDS_CLK
  
  
  );
 /* 
hdmi
//paso de ctes
#(25000000, 48000, 50000, 6144)
	
hdmi_18bits
	(
	.I_CLK_VGA(clk25m),
	.I_CLK_TMDS(clk125m),	
	.I_HSYNC(hsync),		
	.I_VSYNC(vsync),		
	.I_BLANK(hblank),		
	.I_RED({r,2'b0}),		
	.I_GREEN({g,2'b0}),		
	.I_BLUE({b,2'b0}),		
	.I_AUDIO_PCM_L(), 	
	.I_AUDIO_PCM_R(),	
	.O_TMDS(Out_TMDS)
	);	
	*/
	
	hdmi
   //paso de ctes
//  #(25200000, 48000, 25200, 6144)
	
   hdmi_18bits
	
 (
	//clocks
	.CLK_DVI_I(clk125m),	 
	.CLK_PIXEL_I(clk25m),		
	
	// components
	.R_I({r,2'b0}),				
	.G_I({g,2'b0}),				
	.B_I({b,2'b0}),				
	.BLANK_I(~hblank),			
	.HSYNC_I(hsync),			
	.VSYNC_I(vsync),			
	
	// PCM audio 
	//.I_AUDIO_PCM_L(), 	
	//.I_AUDIO_PCM_R(),	
	
	// TMDS output
	.TMDS_D0_O(Out_TMDS_D0),		
	.TMDS_D1_O(Out_TMDS_D1),		
	.TMDS_D2_O(Out_TMDS_D2),		
	.TMDS_CLK_O(Out_TMDS_CLK));		
	
	
 // assign hblank = hsync && vsync;
  assign Out_TMDS_D1_N = 1'b0;
  wire [5:0] r;
  wire [5:0] g;
  wire [5:0] b;
  wire hsync;
  wire vsync;
  wire hblank;
  wire display_enable;
  
  wire clk125m;
  wire clk25m;
  
 relojes reloj25mhz (
    .inclk0(clk12mhz),
    .c0(clk25m),
	 .c1(clk125m)
    );

  // `include "../ejemplos/ejemplo1.v"
  // `include "../ejemplos/ejemplo2.v"
  // `include "../ejemplos/ejemplo3.v"
  // `include "../ejemplos/ejemplo4.v"
  // `include "../ejemplos/ejemplo5.v"
  // `include "../ejemplos/ejemplo6.v"
  // `include "../ejemplos/ejemplo7.v"
  // `include "../ejemplos/ejemplo8.v"
  // `include "../ejemplos/ejemplo9.v"
  // `include "../ejemplos/ejemplo10.v"
  // `include "../ejemplos/ejemplo11.v"
  // `include "../ejemplos/ejemplo12.v"
  // `include "../ejemplos/ejemplo13.v"
  // `include "../ejemplos/ejemplo14.v"
  // `include "../ejemplos/ejemplo15.v"
  // `include "../ejemplos/ejemplo16.v"
  // `include "../ejemplos/ejemplo17.v"
  // `include "../ejemplos/ejemplo18.v"
  // `include "../ejemplos/ejemplo19.v"
  // `include "../ejemplos/ejemplo20.v"
  `include "../ejemplo99/ejemplo99.v"
    
endmodule
  
`default_nettype wire
