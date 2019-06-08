module scoreKeeper(input logic clk, input logic reset_score_n,
	input logic [9:0] ball_x_pos, output logic reset_n, 
	output logic [3:0] left_score, output logic [3:0] right_score);
	
	always_ff@(posedge clk, negedge reset_score_n)
	begin
		if(~reset_score_n) begin left_score <= 0; right_score <= 0; end
		else begin
			if(ball_x_pos-5 == 0)begin reset_n = 0; left_score <= left_score +1; end
			else if(ball_x_pos + 5 == 639) begin reset_n = 0; right_score <= right_score +1; end
			else reset_n = 1;
		end
	end 
	

endmodule