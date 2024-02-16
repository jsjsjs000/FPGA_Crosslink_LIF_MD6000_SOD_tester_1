module test_screens_generator(
	input Clock,
	input [3:0] ImageState,
	input [11:0] x,
	input [11:0] y,
	input wire [11:0] width,
	input wire [11:0] height,
	input wire DE,
	output reg [7:0] R,
	output reg [7:0] G,
	output reg [7:0] B
);

	parameter IMAGE_STATE_RECTANGLE  = 4'b0001;		// ImageState - state machine
	parameter IMAGE_STATE_V_BARS     = 4'b0010;
	parameter IMAGE_STATE_H_BARS     = 4'b0100;
	parameter IMAGE_STATE_GRAY_SCALE = 4'b1000;

	reg [12:0] ColorTmp;		// for 600 * 10, next / 23

	always @(negedge Clock) begin
		if (x == 12'hfff) begin
			R <= 8'h00;
			G <= 8'h00;
			B <= 8'h00;
		end
		else begin
			if (ImageState == IMAGE_STATE_RECTANGLE) begin
				if ((y == 0 + 2) || (y == height - 1) || (x == 0) || (x == width - 1)) begin  // ($$ nie wiem dlaczego +2)
					R <= 8'hff;
					G <= 8'hff;
					B <= 8'hff;
				end
				else begin
					R <= 8'h00;
					G <= 8'h00;
					B <= 8'h00;
				end
			end
			else if (ImageState == IMAGE_STATE_V_BARS) begin
				if (y < height * 1 / 8) begin
					R <= 8'h00;
					G <= 8'h00;
					B <= 8'h00;
				end
				else if (y < height * 2 / 8) begin
					R <= 8'h00;
					G <= 8'h00;
					B <= 8'hff;
				end
				else if (y < height * 3 / 8) begin
					R <= 8'h00;
					G <= 8'hff;
					B <= 8'h00;
				end
				else if (y < height * 4 / 8) begin
					R <= 8'hff;
					G <= 8'h00;
					B <= 8'h00;
				end
				else if (y < height * 5 / 8) begin
					R <= 8'hff;
					G <= 8'h00;
					B <= 8'hff;
				end
				else if (y < height * 6 / 8) begin
					R <= 8'h00;
					G <= 8'hff;
					B <= 8'hff;
				end
				else if (y < height * 7 / 8) begin
					R <= 8'hff;
					G <= 8'hff;
					B <= 8'h00;
				end
				else if (y < height * 8 / 8) begin
					R <= 8'hff;
					G <= 8'hff;
					B <= 8'hff;
				end
			end
			else if (ImageState == IMAGE_STATE_H_BARS) begin
				if (x < width * 1 / 8) begin
					R <= 8'h00;
					G <= 8'h00;
					B <= 8'h00;
				end
				else if (x < width * 2 / 8) begin
					R <= 8'h00;
					G <= 8'h00;
					B <= 8'hff;
				end
				else if (x < width * 3 / 8) begin
					R <= 8'h00;
					G <= 8'hff;
					B <= 8'h00;
				end
				else if (x < width * 4 / 8) begin
					R <= 8'hff;
					G <= 8'h00;
					B <= 8'h00;
				end
				else if (x < width * 5 / 8) begin
					R <= 8'hff;
					G <= 8'h00;
					B <= 8'hff;
				end
				else if (x < width * 6 / 8) begin
					R <= 8'h00;
					G <= 8'hff;
					B <= 8'hff;
				end
				else if (x < width * 7 / 8) begin
					R <= 8'hff;
					G <= 8'hff;
					B <= 8'h00;
				end
				else if (x < width * 8 / 8) begin
					R <= 8'hff;
					G <= 8'hff;
					B <= 8'hff;
				end
			end
			else if (ImageState == IMAGE_STATE_GRAY_SCALE) begin
				R <= ColorTmp[7:0];
				G <= ColorTmp[7:0];
				B <= ColorTmp[7:0];
			end
		end
	end

	always @(posedge Clock) begin
		if (x == 12'hfff)				// on start every line, counting for grayscale
			ColorTmp <= y * 10;
		else if (x == 0)
			ColorTmp <= ColorTmp / 23;
	end
endmodule
