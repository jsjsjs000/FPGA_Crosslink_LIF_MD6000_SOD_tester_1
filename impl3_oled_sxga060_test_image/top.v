module top(
	input CLKI,
	input Reset,
	output wire VCLK,
	output wire [7:0] R,
	output wire [7:0] G,
	output wire [7:0] B,
	output wire HS,
	output wire VS,
	output wire DE
);

	image_generator image_generator_impl(.Clock(VCLK), .Reset(Reset), .HS(HS), .VS(VS), .DE(DE), .R(R), .G(G), .B(B));

	pll pll_impl(.pll1_CLKI(CLKI), .pll1_CLKOS2(VCLK), .pll1_RST(!Reset));
endmodule
