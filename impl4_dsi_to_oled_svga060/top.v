module top(
	input CLKI,
	input Reset,
	input DsiClk_p,
	input DsiClk_n,
	input DsiD0_p,
	input DsiD0_n,
	input DsiD1_p,
	input DsiD1_n,
	input DsiD2_p,
	input DsiD2_n,
	input DsiD3_p,
	input DsiD3_n,
	output wire VCLK,
	output wire [7:0] R,
	output wire [7:0] G,
	output wire [7:0] B,
	output wire HS,
	output wire VS,
	output wire DE
);

	//image_generator image_generator_impl(.Clock(VCLK), .Reset(Reset), .HS(HS), .VS(VS), .DE(DE), .R(R), .G(G), .B(B));
	
	dsi_to_cmos dsi_to_cmos_impl(.dsi_to_cmos_clk_pixel_o(VCLK), .dsi_to_cmos_reset_n_i(!Reset),
		.dsi_to_cmos_clk_p_i(DsiClk_p), .dsi_to_cmos_clk_n_i(DsiClk_n),
		.dsi_to_cmos_d0_p_io(DsiD0_p), .dsi_to_cmos_d0_n_io(DsiD0_n), .dsi_to_cmos_d1_p_i(DsiD1_p), .dsi_to_cmos_d1_n_i(DsiD1_n),
		.dsi_to_cmos_d2_p_i(DsiD2_p), .dsi_to_cmos_d2_n_i(DsiD2_n), .dsi_to_cmos_d3_p_i(DsiD3_p), .dsi_to_cmos_d3_n_i(DsiD3_n),
		.dsi_to_cmos_hsync_o(HS), .dsi_to_cmos_vsync_o(VS), .dsi_to_cmos_de_o(DE),
		.dsi_to_cmos_pd_red_o(R), .dsi_to_cmos_pd_green_o(G), .dsi_to_cmos_pd_blue_o(B));

	pll pll_impl(.pll1_CLKI(CLKI), .pll1_CLKOS2(VCLK), .pll1_RST(!Reset));
endmodule
