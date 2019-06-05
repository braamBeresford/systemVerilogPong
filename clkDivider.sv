module clkDivider (input logic clk,
		output logic newClk);
	
	always_ff @(posedge clk)
		newClk <= ~newClk;
endmodule
