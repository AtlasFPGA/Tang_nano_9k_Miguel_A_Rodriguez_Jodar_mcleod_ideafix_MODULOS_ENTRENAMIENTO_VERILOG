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

module tld_modulos_entrenamiento_tang_nano_9k (
    input wire clk27M,
    output wire reset, 
	input wire [1:0] 	BTN,	// BTN[1]=reset

// HDMI
	output wire      tmds_clk_n,
	output wire      tmds_clk_p,
	output wire [2:0] tmds_d_n,
	output wire [2:0] tmds_d_p,

// SD
	input	wire	spi_miso,		// SD Card Data 		(MISO)
	output	wire	spi_mosi,		// SD Card Command Signal 	(MOSI)
	output	wire	spi_clk,		// SD Card Clock 		(SCK)
	output	wire	mmc_ncs,		// SD Card Data 3 		(CSn)

// PS2
	inout	wire			ps2_kb_clk,
	inout	wire			ps2_kb_dat
  
  );
  wire pll_lock2;
  wire clk125m;
  wire clk25m;
  wire breset = ~BTN[1];
	//wire clk_p, clk_p5;	// p5:125.875  p:25.175
  Gowin_rPLL2 u_pll (.clkin(clk27M), .clkout(clk125m), .lock(pll_lock2));
  Gowin_CLKDIV u_div_5 ( .clkout(clk25m), .hclkin(clk125m), .resetn(pll_lock2));
	
 // assign hblank = hsync && vsync;
 // assign Out_TMDS_D1_N = 1'b0;
  wire [5:0] r;
  wire [5:0] g;
  wire [5:0] b;
  wire hsync;
  wire vsync;
  wire hblank;
  wire display_enable;
  wire clkps2;
  wire dataps2;
  assign clkps2 = ps2_kb_clk;
  assign dataps2 = ps2_kb_dat;

 svo_hdmi_out u_hdmi (
	//.clk(clk_p),
	.resetn(~breset),//(sys_resetn),
	// video clocks
	.clk_pixel(clk25m),
	.clk_5x_pixel(clk125m),
	.locked(pll_lock2),
	// input VGA
	.rout(r[7:2]),
	.gout(g[7:2]),
	.bout(b[7:2]),
	.hsync_n(hsync),
	.vsync_n(vsync),
	.hblnk_n(~hblank),
	// output signals
	.tmds_clk_n(tmds_clk_n),
	.tmds_clk_p(tmds_clk_p),
	.tmds_d_n(tmds_d_n),
	.tmds_d_p(tmds_d_p),
	.tmds_ts()
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
   `include "../ejemplo99/ejemplo99.v" //La inicialización de $readmemh hay que copiar los hex en el raiz del proyecto
    
endmodule
  
`default_nettype wire
