module horizCounter(input logic  clk,
	output logic hsync, output logic [9:0] x_count);

assign hsync = x_count < (640 + 16) || x_count >= (640 + 16 + 96);


always_ff @(posedge clk) begin
		if(x_count < 799) x_count <= x_count +1;
		else begin x_count <= 0;  end
end

endmodule // counter800
