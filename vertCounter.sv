module vertCounter(input logic  clk,
input logic [9:0] x_count, output logic vsync,
output logic [9:0] y_count);

logic [9:0] nextState;

assign vsync = y_count < (480 + 10) || y_count>= (480 + 10 + 2);

always_ff @(posedge clk) begin

		if(x_count >= 10'd799)
		begin
			if(y_count < 10'd524) y_count <= y_count + 1;
			else y_count <=0;
		end
end
endmodule // counter800
