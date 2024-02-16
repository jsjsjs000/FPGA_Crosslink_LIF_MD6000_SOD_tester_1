module top(
	input CLKI,
	output CLKOS,
	output CLKOS3,
	input Reset,
	output reg LED
);

	reg [23:0] counter = 24'd0;
	
	always @(posedge CLKOS3, negedge Reset) begin
		if (!Reset) begin
			counter <= 24'd0;
			LED <= 1'b0;
		end
		else begin
			if (counter == 6_000_000 / 2 - 1) begin
				LED <= !LED;
				counter <= 24'd0;
			end
			else begin
				counter <= counter + 1'b1;
			end
		end
	end

	pll pll1(.pll1_CLKI(CLKI), .pll1_CLKOS(CLKOS), .pll1_CLKOS3(CLKOS3));
endmodule

// Generate 1Hz on LED
