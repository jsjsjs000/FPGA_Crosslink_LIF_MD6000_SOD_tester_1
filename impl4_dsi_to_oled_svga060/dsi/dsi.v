/* synthesis translate_off*/
`define SBP_SIMULATION
/* synthesis translate_on*/
`ifndef SBP_SIMULATION
`define SBP_SYNTHESIS
`endif

//
// Verific Verilog Description of module dsi
//
module dsi (dsi_to_cmos_pd_blue_o, dsi_to_cmos_pd_green_o, dsi_to_cmos_pd_red_o, 
            dsi_to_cmos_clk_n_i, dsi_to_cmos_clk_p_i, dsi_to_cmos_clk_pixel_o, 
            dsi_to_cmos_d0_n_io, dsi_to_cmos_d0_p_io, dsi_to_cmos_d1_n_i, 
            dsi_to_cmos_d1_p_i, dsi_to_cmos_d2_n_i, dsi_to_cmos_d2_p_i, 
            dsi_to_cmos_d3_n_i, dsi_to_cmos_d3_p_i, dsi_to_cmos_de_o, 
            dsi_to_cmos_hsync_o, dsi_to_cmos_reset_n_i, dsi_to_cmos_vsync_o) /* synthesis sbp_module=true */ ;
    output [7:0]dsi_to_cmos_pd_blue_o;
    output [7:0]dsi_to_cmos_pd_green_o;
    output [7:0]dsi_to_cmos_pd_red_o;
    inout dsi_to_cmos_clk_n_i;
    inout dsi_to_cmos_clk_p_i;
    output dsi_to_cmos_clk_pixel_o;
    inout dsi_to_cmos_d0_n_io;
    inout dsi_to_cmos_d0_p_io;
    inout dsi_to_cmos_d1_n_i;
    inout dsi_to_cmos_d1_p_i;
    inout dsi_to_cmos_d2_n_i;
    inout dsi_to_cmos_d2_p_i;
    inout dsi_to_cmos_d3_n_i;
    inout dsi_to_cmos_d3_p_i;
    output dsi_to_cmos_de_o;
    output dsi_to_cmos_hsync_o;
    input dsi_to_cmos_reset_n_i;
    output dsi_to_cmos_vsync_o;
    
    
    dsi_to_cmos dsi_to_cmos_inst (.pd_blue_o({dsi_to_cmos_pd_blue_o}), .pd_green_o({dsi_to_cmos_pd_green_o}), 
            .pd_red_o({dsi_to_cmos_pd_red_o}), .clk_n_i(dsi_to_cmos_clk_n_i), 
            .clk_p_i(dsi_to_cmos_clk_p_i), .clk_pixel_o(dsi_to_cmos_clk_pixel_o), 
            .d0_n_io(dsi_to_cmos_d0_n_io), .d0_p_io(dsi_to_cmos_d0_p_io), 
            .d1_n_i(dsi_to_cmos_d1_n_i), .d1_p_i(dsi_to_cmos_d1_p_i), .d2_n_i(dsi_to_cmos_d2_n_i), 
            .d2_p_i(dsi_to_cmos_d2_p_i), .d3_n_i(dsi_to_cmos_d3_n_i), .d3_p_i(dsi_to_cmos_d3_p_i), 
            .de_o(dsi_to_cmos_de_o), .hsync_o(dsi_to_cmos_hsync_o), .reset_n_i(dsi_to_cmos_reset_n_i), 
            .vsync_o(dsi_to_cmos_vsync_o));
    
endmodule

