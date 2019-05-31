module clkDivider (input logic clk,
		input logic reset_n,
		output logic newClk);
	
	always_ff @(posedge clk, negedge reset_n)
		if(!reset_n) newClk<=0;
		else newClk <= ~newClk;
endmodule
