//===========================================================================
// Filename: dphy_2_cmos_tb.v
// Copyright(c) 2016 Lattice Semiconductor Corporation. All rights reserved. 
//===========================================================================

`timescale 1 ps / 1 ps

`ifdef NUM_RX_LANE_1
   `define DPHY_LANE 1
`elsif NUM_RX_LANE_2
   `define DPHY_LANE 2
`else
   `define DPHY_LANE 4 
`endif

`ifndef NUM_FRAMES 
   `define NUM_FRAMES 1
`endif

`ifndef NUM_LINES 
   `define NUM_LINES 1080
`endif

`ifndef DSI_VACT_PAYLOAD
   `define DSI_VACT_PAYLOAD 16'h1680
`endif

`ifndef DSI_HSA_PAYLOAD
   `define DSI_HSA_PAYLOAD 16'h007A
`endif

`ifndef DSI_BLLP_PAYLOAD
   `define DSI_BLLP_PAYLOAD 16'h193A
`endif

`ifndef DSI_HBP_PAYLOAD
   `define DSI_HBP_PAYLOAD 16'h01AE
`endif

`ifndef DSI_HFP_PAYLOAD
   `define DSI_HFP_PAYLOAD 16'h0100
`endif

`ifndef DSI_VSA_LINES 
   `define DSI_VSA_LINES 5
`endif

`ifndef DSI_VBP_LINES 
   `define DSI_VBP_LINES 36
`endif

`ifndef DSI_VFP_LINES 
   `define DSI_VFP_LINES 4
`endif

`ifndef DSI_EOTP_ENABLE 
   `define DSI_EOTP_ENABLE 1
`endif

`ifndef DSI_LPS_BLLP_DURATION 
   `define DSI_LPS_BLLP_DURATION 2470000
`endif

`ifndef DSI_LPS_HBP_DURATION 
   `define DSI_LPS_HBP_DURATION 800000
`endif

`ifndef DSI_LPS_HFP_DURATION 
   `define DSI_LPS_HFP_DURATION 500000
`endif

`ifndef VIRTUAL_CHANNEL 
   `define VIRTUAL_CHANNEL 2'h0
`endif

`ifndef DPHY_DEBUG_ON 
   `define DPHY_DEBUG_ON 0
`endif

`ifndef DPHY_CLK
   `define DPHY_CLK 2244
`endif

`ifdef RX_TYPE_DSI
   `ifdef RGB666_LOOSE
      `define VIDEO_DATA_TYPE 6'h2E
      `define CMOS_DWIDTH 6
      `define TX_TYPE_RGB
   `elsif RGB666
      `define VIDEO_DATA_TYPE 6'h1E
      `define CMOS_DWIDTH 6
      `define TX_TYPE_RGB
   `else //RGB888
      `define VIDEO_DATA_TYPE 6'h3E
      `define CMOS_DWIDTH 8
      `define TX_TYPE_RGB
   `endif
`else //CSI2
   `ifdef RAW8
      `define VIDEO_DATA_TYPE 6'h2A
      `define CMOS_8_BITS
      `define CMOS_DWIDTH 8
      `define TX_TYPE_RAW
   `elsif RAW10
      `define VIDEO_DATA_TYPE 6'h2B
      `define CMOS_10_BITS
      `define CMOS_DWIDTH 10
      `define TX_TYPE_RAW
   `elsif RAW12
      `define VIDEO_DATA_TYPE 6'h2C
      `define CMOS_12_BITS
      `define CMOS_DWIDTH 12
      `define TX_TYPE_RAW
   `elsif YUV420_10
      `define VIDEO_DATA_TYPE 6'h19
      `define CMOS_10_BITS
      `define CMOS_DWIDTH 10
      `define TX_TYPE_YUV
   `elsif YUV420_8 
      `define VIDEO_DATA_TYPE 6'h18
      `define CMOS_8_BITS
      `define CMOS_DWIDTH 8
      `define TX_TYPE_YUV
   `elsif YUV422_10
      `define VIDEO_DATA_TYPE 6'h1F
      `define CMOS_10_BITS
      `define CMOS_DWIDTH 10
      `define TX_TYPE_YUV
   `elsif YUV422_8
      `define VIDEO_DATA_TYPE 6'h1E
      `define CMOS_8_BITS
      `define CMOS_DWIDTH 8
      `define TX_TYPE_YUV
   `elsif LEGACY_YUV420_8
      `define VIDEO_DATA_TYPE 6'h1A
      `define CMOS_8_BITS
      `define CMOS_DWIDTH 8
      `define TX_TYPE_YUV
   `elsif YUV420_10_CSPS
      `define VIDEO_DATA_TYPE 6'h1D
      `define CMOS_10_BITS
      `define CMOS_DWIDTH 10
      `define TX_TYPE_YUV
   `elsif YUV420_8_CSPS
      `define VIDEO_DATA_TYPE 6'h1C
      `define CMOS_8_BITS
      `define CMOS_DWIDTH 8
      `define TX_TYPE_YUV
   `else //RGB888
      `define VIDEO_DATA_TYPE 6'h24
      `define CMOS_DWIDTH 24
      `define TX_TYPE_RGB
   `endif
`endif

`ifndef CSI2_LPS_GAP 
   `define CSI2_LPS_GAP 5000000
`endif

`ifndef CSI2_LS_LE_EN
   `define CSI2_LS_LE_EN 0
`endif

`ifndef CSI2_NUM_PIXELS
   `define CSI2_NUM_PIXELS 1000
`endif

`ifndef FRAME_LPM_DELAY
   `define FRAME_LPM_DELAY 5000000 
`endif

module tb(); 
   // Design parameters
   parameter dphy_num_lane = `DPHY_LANE; //number of dphy data lanes. currently, design only supports 4 lanes
   parameter integer dphy_clk_period = `DPHY_CLK; //in ps, clock period of DPHY. 

   // Testbench parameters for video data
   parameter num_frames = `NUM_FRAMES; // number of frames
   parameter num_lines = `NUM_LINES; //number of video lines
   `ifndef DPHY_LPX
      `ifdef RX_CLK_MODE_HS_LP
         parameter t_lpx = `DPHY_CLK*12*2; //should be atleast 50ns, and atleast 2x byte clock period if HS_ONLY or atleast 2x ref clock period if HS_LP mode
      `else //HS_ONLY
         parameter t_lpx = 60000; 
      `endif
   `else
      parameter t_lpx = `DPHY_LPX; //in ps, min of 50ns
   `endif

   `ifndef DPHY_CLK_PREPARE
      parameter t_clk_prepare = 38000; //in ps, set between 38 to 95 ns
   `else
      parameter t_clk_prepare = `DPHY_CLK_PREPARE; //in ps, set between 38 to 95 ns
   `endif
   `ifndef DPHY_CLK_ZERO
      parameter t_clk_zero = 262000; //in ps, (clk_prepare + clk_zero minimum should be 300ns)
   `else
      parameter t_clk_zero = `DPHY_CLK_ZERO; //in ps, (clk_prepare + clk_zero minimum should be 300ns)
   `endif
   `ifndef DPHY_CLK_PRE
      parameter t_clk_pre = 8*(dphy_clk_period/2); // in ps, minimum of 8*UI
   `else
      parameter t_clk_pre = `DPHY_CLK_PRE;
   `endif
   `ifndef DPHY_CLK_POST
      parameter t_clk_post = (60000 + (52*dphy_clk_period/2)); // in ps, minimum of 60ns+52*UI
   `else
      parameter t_clk_post = `DPHY_CLK_POST; // in ps, minimum of 60ns+52*UI
   `endif
   `ifndef DPHY_CLK_TRAIL
      parameter t_clk_trail = 60000; //in ps, minimum of 60ns
   `else
      parameter t_clk_trail = `DPHY_CLK_TRAIL; //in ps, minimum of 60ns
   `endif
   `ifndef DPHY_HS_PREPARE
      parameter t_hs_prepare = (40000 + (4*dphy_clk_period/2)); //in ps, set between 40ns+4*UI to max of 85ns+6*UI
   `else
      parameter t_hs_prepare = `DPHY_HS_PREPARE; //in ps, set between 40ns+4*UI to max of 85ns+6*UI
   `endif
   `ifndef DPHY_HS_ZERO
      parameter t_hs_zero = ((145000 + (10*dphy_clk_period/2)) - t_hs_prepare); //in ps, hs_prepare + hs_zero minimum should be 145ns+10*UI
   `else
      parameter t_hs_zero = `DPHY_HS_ZERO; //in ps, hs_prepare + hs_zero minimum should be 145ns+10*UI
   `endif
   `ifndef DPHY_HS_TRAIL
      parameter t_hs_trail = ((60000 + (4*dphy_clk_period/2)) + (105000 + (12*dphy_clk_period/2)))/2; //in ps, minimum should be 60ns+4*UI, max should be 105ns+12*UI
   `else
      parameter t_hs_trail = `DPHY_HS_TRAIL; //in ps, minimum should be 60ns+4*UI, max should be 105ns+12*UI
   `endif
  
   `ifndef DPHY_INIT
      parameter t_init = 100000000; //in ps
   `else
      parameter t_init = `DPHY_INIT;
   `endif
 
   parameter vact_payload = `DSI_VACT_PAYLOAD; //VACT 2-byte word count (total number of bytes of active pixels in 1 line)
   parameter hsa_payload = `DSI_HSA_PAYLOAD; //HSA 2-byte word count (number of bytes of payload, see MIPI DSI spec v1.1 figure 30), used for Non-burst sync pulse
   parameter bllp_payload = `DSI_BLLP_PAYLOAD; //BLLP 2-byte word count (number of bytes of payload, see MIPI DSI spec v1.1 figure 30), used for HS_ONLY mode
   parameter hbp_payload = `DSI_HBP_PAYLOAD; //HBP 2-byte word count (number of bytes of payload, see MIPI DSI spec v1.1 figure 30), used for HS_ONLY mode and HS_LP Non-burst sync pulse
   parameter hfp_payload = `DSI_HFP_PAYLOAD; //HFP 2-byte word count (number of bytes of payload, see MIPI DSI spec v1.1 figure 30), used for HS_ONLY mode and HS_LP Non-burst sync pulse
   parameter lps_bllp_duration = `DSI_LPS_BLLP_DURATION; // in ps, used for HS_LP mode, this pertains to the LP-11 state duration for blanking
   parameter lps_hbp_duration = `DSI_LPS_HBP_DURATION; // in ps, used for HS_LP Non-burst sync events and burst mode, this pertains to the LP-11 state duration for horizontal back porch
   parameter lps_hfp_duration = `DSI_LPS_HFP_DURATION; // in ps, used for HS_LP Non-burst sync events and burst mode, this pertains to the LP-11 state duration for horizontal front porch
   parameter virtual_channel = `VIRTUAL_CHANNEL; // virtual channel ID. example: 2'h0 
   parameter video_data_type = `VIDEO_DATA_TYPE; // video data type DI. example: 6'h3E = RGB888 
   parameter vsa_lines = `DSI_VSA_LINES; // number of VSA lines, see MIPI DSI spec v1.1 figure 30
   parameter vbp_lines = `DSI_VBP_LINES; // number of VBP lines, see MIPI DSI spec v1.1 figure 30
   parameter vfp_lines = `DSI_VFP_LINES; // number of VFP lines, see MIPI DSI spec v1.1 figure 30
   parameter eotp_enable = `DSI_EOTP_ENABLE; // to enable/disable EOTP packet
   parameter debug_on = `DPHY_DEBUG_ON; // for enabling/disabling DPHY data debug messages
   parameter frame_gap = `FRAME_LPM_DELAY; //delay between frames (in ps)


   //CSI2 parameters
   parameter lps_gap = `CSI2_LPS_GAP; 
   parameter ls_le_en = `CSI2_LS_LE_EN; 

   `ifdef RAW8
      parameter num_pixels = `CSI2_NUM_PIXELS; 
      parameter long_even_line_en    = 0;
   `elsif RAW10
      parameter num_pixels = `CSI2_NUM_PIXELS * 5/4;
      parameter long_even_line_en    = 0;
   `elsif RAW12
      parameter num_pixels = `CSI2_NUM_PIXELS * 3/2;
      parameter long_even_line_en    = 0;
   `elsif YUV420_10
      parameter num_pixels = `CSI2_NUM_PIXELS * 5/4; // odd line
      parameter long_even_line_en    = 1;
   `elsif YUV420_8
      parameter num_pixels = `CSI2_NUM_PIXELS ; // odd line
      parameter long_even_line_en    = 1;
   `elsif YUV422_10
      parameter num_pixels = `CSI2_NUM_PIXELS * 5/2;
      parameter long_even_line_en    = 0;
   `elsif YUV422_8
      parameter num_pixels = `CSI2_NUM_PIXELS*2;
      parameter long_even_line_en    = 0;
   `elsif LEGACY_YUV420_8
      parameter num_pixels = `CSI2_NUM_PIXELS * 3/2;
      parameter long_even_line_en    = 0;
   `elsif YUV420_10_CSPS
      parameter num_pixels = `CSI2_NUM_PIXELS * 5/4; // odd line
      parameter long_even_line_en    = 1;
   `elsif YUV420_8_CSPS
      parameter num_pixels = `CSI2_NUM_PIXELS ; // odd line
      parameter long_even_line_en    = 1;
   `else //RGB888
      parameter num_pixels = `CSI2_NUM_PIXELS * 3;
      parameter long_even_line_en    = 0;
   `endif

   `ifdef REF_CLK
      parameter refclk_period = `REF_CLK;
   `endif

   real dphy_clk;
   reg cont_clk; //for csi2 model, HS_ONLY mode
 
   //DUT input ports
   reg resetn;
   wire clk_p_i;
   wire clk_n_i;
   wire d0_p_io;
   wire d0_n_io;
   wire d1_p_i;
   wire d1_n_i;
   wire d2_p_i;
   wire d2_n_i;
   wire d3_p_i;
   wire d3_n_i;
   reg refclk_i;


   wire clk_p_i_w;
   wire clk_n_i_w;
   wire d0_p_io_w;
   wire d0_n_io_w;
   wire d1_p_i_w;
   wire d1_n_i_w;
   wire d2_p_i_w;
   wire d2_n_i_w;
   wire d3_p_i_w;
   wire d3_n_i_w;
 
   assign clk_p_i_w = clk_p_i;
   assign clk_n_i_w = clk_n_i;

   //DUT port output
   wire clk_pixel_w;
   wire vsync_w;
   wire hsync_w;
   wire de_w;
   wire fv_w;
   wire lv_w;
   wire [`CMOS_DWIDTH-1:0] rgb_red_w;
   wire [`CMOS_DWIDTH-1:0] rgb_green_w;
   wire [`CMOS_DWIDTH-1:0] rgb_blue_w;
   wire [`CMOS_DWIDTH-1:0] raw_w;
   wire [`CMOS_DWIDTH-1:0] yuv_w;

   initial begin
      $timeformat(-12,0,"",10);
      resetn = 0; //reset at start of sim
      refclk_i = 0;
      cont_clk = 0;
      if(`DPHY_CLK%2 > 0) begin
         dphy_clk = `DPHY_CLK - 1;
      end
      else begin
         dphy_clk = `DPHY_CLK;
      end

      $display("%0t TEST START\n",$realtime);
      #(dphy_clk_period*12*3);
      resetn = 1;

      $display("%t Waiting for PLL lock...\n", $time);
      `ifdef RX_TYPE_DSI
         if(I_dphy_2_cmos.pll_lock == 0) begin
            @(posedge I_dphy_2_cmos.pll_lock);
         end
         $display("%t PLL lock DONE\n", $time);
      `else
         `ifdef NUM_RX_LANE_1
            `ifdef CMOS_8_BITS
               $display("%t PLL lock fixed to 1\n", $time);
            `else
               if(I_dphy_2_cmos.pll_lock == 0) begin
                  @(posedge I_dphy_2_cmos.pll_lock);
               end
               $display("%t PLL lock DONE\n", $time);
            `endif
         `else
            if(I_dphy_2_cmos.pll_lock == 0) begin
               @(posedge I_dphy_2_cmos.pll_lock);
            end
            $display("%t PLL lock DONE\n", $time);
         `endif
      `endif

      `ifdef RX_TYPE_DSI
         dsi_ch0.dphy_active = 1;
         $display("%t Activating DSI model\n", $time);
         @(negedge dsi_ch0.dphy_active);
      `else //RX_TYPE_CSI2
         csi2_ch0.dphy_active = 1;
         $display("%t Activating CSI2 model\n", $time);
         @(negedge csi2_ch0.dphy_active);
      `endif
      #100000;
      $display("%0t TEST END\n",$realtime);
      $finish;
   end

   initial begin
      $shm_open("./dump.shm");
      $shm_probe(tb, ("AC"));
   end

   `ifdef RX_CLK_MODE_HS_LP
      `ifdef REF_CLK
         always #(refclk_period/2) refclk_i =~ refclk_i; 
      `else
         `ifdef RGB666
            `ifdef NUM_RX_LANE_4
               always #(dphy_clk*8/2) refclk_i =~ refclk_i; 
            `else //lane=2 or lane=1
               `ifdef RX_GEAR_16
                  `ifdef NUM_RX_LANE_2
                    always #(dphy_clk*16/2) refclk_i =~ refclk_i;
                  `else //lane=1
                    always #(dphy_clk*24/2) refclk_i =~ refclk_i;
                  `endif 
               `else //gear=8
                 always #(dphy_clk*12/2) refclk_i =~ refclk_i;
               `endif
            `endif
         `elsif CMOS_8_BITS
            `ifdef NUM_RX_LANE_4
               always #(dphy_clk*4/2) refclk_i =~ refclk_i; 
            `elsif NUM_RX_LANE_2
               `ifdef RX_GEAR_16
                  always #(dphy_clk*16/2) refclk_i =~ refclk_i;
               `else
                  always #(dphy_clk*8/2) refclk_i =~ refclk_i;
               `endif
            `else //lane=1
               `ifdef RX_GEAR_16
                  always #(dphy_clk*16/2) refclk_i =~ refclk_i;
               `else
                  always #(dphy_clk*12/2) refclk_i =~ refclk_i;
               `endif
            `endif
         `elsif CMOS_10_BITS 
            `ifdef NUM_RX_LANE_4
               always #(dphy_clk*5/2) refclk_i =~ refclk_i; 
            `else //lane=2 or lane=1
               `ifdef RX_GEAR_16
                 `ifdef NUM_RX_LANE_2
                    always #(dphy_clk*10/2) refclk_i =~ refclk_i;
                 `else
                    always #(dphy_clk*20/2) refclk_i =~ refclk_i;
                 `endif
               `else
                  always #(dphy_clk*10/2) refclk_i =~ refclk_i;
               `endif
            `endif
         `elsif CMOS_12_BITS 
            `ifdef NUM_RX_LANE_4
               `ifdef NUM_TX_CH_2 
                 always #(dphy_clk*12/2) refclk_i =~ refclk_i; 
               `else
                 always #(dphy_clk*6/2) refclk_i =~ refclk_i; 
               `endif
            `else //lane=2 or lane=1
               `ifdef RX_GEAR_16
                  always #(dphy_clk*24/2) refclk_i =~ refclk_i;
               `else
                  always #(dphy_clk*12/2) refclk_i =~ refclk_i;
               `endif
            `endif
         `else //RGB666-loose or RGB888
            `ifdef RX_GEAR_16
              always #(dphy_clk*24/2) refclk_i =~ refclk_i;
            `else
              always #(dphy_clk*12/2) refclk_i =~ refclk_i;
            `endif
         `endif
      `endif
   `endif

   `ifdef RX_TYPE_CSI2
      always #(dphy_clk_period/2) cont_clk =~ cont_clk;
   `endif

    //DUT instance
   PUR PUR_INST(resetn);

`ifdef RX_TYPE_DSI
   assign d0_p_io_w = d0_p_io;
   assign d0_n_io_w = d0_n_io;
   assign d1_p_i_w = d1_p_i;
   assign d1_n_i_w = d1_n_i;
   assign d2_p_i_w = d2_p_i;
   assign d2_n_i_w = d2_n_i;
   assign d3_p_i_w = d3_p_i;
   assign d3_n_i_w = d3_n_i;

   dsi_model #(
   .dphy_num_lane     (dphy_num_lane    ), 
   .dphy_clk_period   (dphy_clk_period  ),
   .num_frames        (num_frames       ),
   .num_lines         (num_lines        ),   
   .t_lpx             (t_lpx            ),  
   .t_clk_prepare     (t_clk_prepare    ),  
   .t_clk_zero        (t_clk_zero       ),  
   .t_clk_pre         (t_clk_pre        ),  
   .t_clk_post        (t_clk_post       ),  
   .t_clk_trail       (t_clk_trail      ),  
   .t_hs_prepare      (t_hs_prepare     ),  
   .t_hs_zero         (t_hs_zero        ),  
   .t_hs_trail        (t_hs_trail       ), 
   .t_init            (t_init           ), 
   .hsa_payload       (hsa_payload      ),
   .bllp_payload      (bllp_payload     ),
   .hbp_payload       (hbp_payload      ),
   .hfp_payload       (hfp_payload      ),
   .lps_bllp_duration (lps_bllp_duration),
   .lps_hfp_duration  (lps_hfp_duration ),
   .lps_hbp_duration  (lps_hbp_duration ),
   .vact_payload      (vact_payload     ),
   .virtual_channel   (virtual_channel  ),
   .video_data_type   (video_data_type  ),
   .vsa_lines         (vsa_lines        ),
   .vbp_lines         (vbp_lines        ),
   .vfp_lines         (vfp_lines        ),
   .eotp_enable       (eotp_enable      ),
   .frame_gap         (frame_gap        ),
   .debug_on          (debug_on         )  
      )
   dsi_ch0 (
   .resetn(resetn),
   .clk_p_i(clk_p_i),
   .clk_n_i(clk_n_i),
   .d0_p_io(d0_p_io),
   .d0_n_io(d0_n_io),
   .d1_p_i(d1_p_i),
   .d1_n_i(d1_n_i),
   .d2_p_i(d2_p_i),
   .d2_n_i(d2_n_i),
   .d3_p_i(d3_p_i),
   .d3_n_i(d3_n_i)
  ); 
`else //RX_TYPE_CSI2
   wire [3:0] dphy_data_p_i;
   wire [3:0] dphy_data_n_i;

   assign d0_p_io_w = dphy_data_p_i[0];
   assign d0_n_io_w = dphy_data_n_i[0];
   assign d1_p_i_w = dphy_data_p_i[1];
   assign d1_n_i_w = dphy_data_n_i[1];
   assign d2_p_i_w = dphy_data_p_i[2];
   assign d2_n_i_w = dphy_data_n_i[2];
   assign d3_p_i_w = dphy_data_p_i[3];
   assign d3_n_i_w = dphy_data_n_i[3];

   csi2_model #(
   .active_dphy_lanes (dphy_num_lane    ),
   .num_frames        (num_frames       ),
   .num_lines         (num_lines        ),
   .num_pixels        (num_pixels       ),
   .data_type         (video_data_type  ),
   .dphy_clk_period   (dphy_clk_period  ),
   .t_lpx             (t_lpx            ),
   .t_clk_prepare     (t_clk_prepare    ),
   .t_clk_zero        (t_clk_zero       ),
   .t_clk_pre         (t_clk_pre        ),
   .t_clk_post        (t_clk_post       ),
   .t_clk_trail       (t_clk_trail      ),
   .t_hs_prepare      (t_hs_prepare     ),
   .t_hs_zero         (t_hs_zero        ),
   .t_hs_trail        (t_hs_trail       ),
   .lps_gap           (lps_gap          ),
   .frame_gap         (frame_gap        ),
   .t_init            (t_init ),
   .dphy_ch           (0                ),
   .dphy_vc           (virtual_channel  ),
   .long_even_line_en (long_even_line_en),
   .ls_le_en          (ls_le_en),
   .debug             (debug_on)
      )
   csi2_ch0 (
      .resetn   (resetn    ),
      .refclk_i (cont_clk  ),
      `ifdef RX_CLK_MODE_HS_LP
         .clk_p_i (clk_p_i_w),
         .clk_n_i (clk_n_i_w),
         .cont_clk_p_i ( ),
         .cont_clk_n_i ( ),
      `else
         .clk_p_i ( ),
         .clk_n_i ( ),
         .cont_clk_p_i (clk_p_i_w),
         .cont_clk_n_i (clk_n_i_w),
      `endif
      .do_p_i (dphy_data_p_i),
      .do_n_i (dphy_data_n_i) 
   );
`endif

dphy_2_cmos_ip_wrapper I_dphy_2_cmos(
    // reference clock and reset
    `ifdef RX_CLK_MODE_HS_LP
       .refclk_i(refclk_i),
    `endif
    .reset_n_i(resetn), 

    // DPHY interface 
    .clk_p_i(clk_p_i_w), 
    .clk_n_i(clk_n_i_w),
    `ifdef RX_TYPE_DSI
       .d0_p_io(d0_p_io_w),
       .d0_n_io(d0_n_io_w),
    `elsif RX_TYPE_CSI2
       .d0_p_i(d0_p_io_w),
       .d0_n_i(d0_n_io_w),
    `endif
   
    `ifdef NUM_RX_LANE_2
       .d1_p_i(d1_p_i_w),
       .d1_n_i(d1_n_i_w),
    `elsif NUM_RX_LANE_4
       .d1_p_i(d1_p_i_w),
       .d1_n_i(d1_n_i_w),
       .d2_p_i(d2_p_i_w),
       .d2_n_i(d2_n_i_w),
       .d3_p_i(d3_p_i_w),
       .d3_n_i(d3_n_i_w),
     `endif     
        
    // Pixel clock, control, and data

    `ifdef RX_TYPE_DSI
       .clk_pixel_o(clk_pixel_w),   
       .vsync_o(vsync_w),
       .hsync_o(hsync_w),
       .de_o(de_w),
    `elsif RX_TYPE_CSI2
       .clk_pixel_o(clk_pixel_w), 
       .fv_o(fv_w),
       .lv_o(lv_w),
    `endif
    `ifdef TX_TYPE_RGB
      `ifdef RX_TYPE_CSI2
         .pd_red_o(rgb_red_w),
         .pd_green_o(rgb_green_w),
         .pd_blue_o(rgb_blue_w)
      `elsif RX_TYPE_DSI
         .pd_red_o(rgb_red_w),
         .pd_green_o(rgb_green_w),
         .pd_blue_o(rgb_blue_w)
      `endif
    `elsif TX_TYPE_RAW
       .pd_raw_o(raw_w)
    `elsif TX_TYPE_YUV
       .pd_yuv_o(yuv_w)
    `endif
);


endmodule

