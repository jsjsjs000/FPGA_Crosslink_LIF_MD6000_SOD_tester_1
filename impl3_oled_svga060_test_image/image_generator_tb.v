`timescale 1ns/100ps	// time-unit, precision
//`timescale 1ns/1ps	// time-unit, precision

module ImageGenerator_tb();
	parameter CLOCK_HZ	= 40_000_000;
	parameter HALF_PERIOD_NS = 1_000_000_000 / (2 * CLOCK_HZ);

	reg Clock = 1'b1;
	always begin
		#HALF_PERIOD_NS;
		Clock = !Clock;
	end

	reg	Reset = 1'b1;

	wire HS;
	wire VS;
	wire DE;
	wire [7:0] R;
	wire [7:0] G;
	wire [7:0] B;
	image_generator #(
		// .CLOCK_HZ(CLOCK_HZ)
	) DUT(
		.Clock(Clock), .Reset(Reset), .HS(HS), .VS(VS), .DE(DE), .R(R), .G(G), .B(B)
	);

	initial begin
		$dumpfile("image_generator.vcd");
		$dumpvars(0, ImageGenerator_tb);
	end

	initial begin
		$timeformat(-6, 3, "us", 10);
		$display("===== START =====");
		//$display("CLOCK_HZ  = %9d", DUT.CLOCK_HZ);
		//$display("PERIOD_US = %9d", DUT.PERIOD_US);
		//$display("DELAY     = %9d", DUT.DELAY);
		//$display("WIDTH     = %9d", DUT.WIDTH);

		#1 Reset = 1'b0;
		#1 Reset = 1'b1;
		#35000000;

//		repeat(2) begin
//			@(posedge Strobe);
//			$display("Strobe detected at %t", $realtime);
//		end
//
//		@(negedge Strobe);
//		#1000;

		$display("===== END =====");
		#1 $finish;		// koñczy program lub $stop - tryb poleceñ symulatora
	end
endmodule
