module colorChanger #(parameter N =25) (input logic clk,
		input logic reset_n, output logic [3:0] red,
		output logic [3:0] blue, output logic [3:0] green);
	
	logic [N-1:0] q;
	always_ff @(posedge clk, negedge reset_n)
		if(!reset_n) begin q<=0;end
		else
			begin 
			q = q+1;
			end
			
	always_ff @(posedge q[N-1], negedge reset_n)
	begin
	if(!reset_n) begin red <= 0; blue <= 0; green <= 0; end
		else begin red <= ~ red; blue <= ~ blue; end
	end
endmodule