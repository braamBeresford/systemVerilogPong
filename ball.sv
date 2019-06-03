module ball #(parameter right_pad_x = 540)(input logic clk,
	input logic reset_n,
	input logic [9:0] right_paddle_pos,
	output logic, 
	output logic ball_y_pos [9:0],
	output logic ball_x_pos [9:0]);

logic [9:0] next_pos;
logic [2:0] x_velocity;
logic [2:0] y_velocity;

//Make a block
logic [17:0] q;
always_ff @(posedge clk, negedge rst_n)
	if(~rst_n) begin q<=0;end
	else
		begin 
		q = q+1;
		end

always_ff @(posedge clk, negedge reset_n) begin 
	if(~reset_n) begin
		ball_x_pos <= 300;
		ball_y_pos <= 200;
		x_velocity <= 5;
		y_velocity <= 0;
	end 
	else
	begin
		if(ball_x_pos+ x_velocity => right_pad_x && ball_y_pos =< right_paddle_pos + 20 && ball_y_pos => right_paddle_pos + 20) begin
				ball_x_pos <= right_pad_x - 1;
				ball_y_pos <= ball_y_pos + y_velocity;
				x_velocity <= x_velocity * -1; //Make it bounce back
			end
		else begin
			ball_x_pos <= ball_x_pos + x_velocity;
			ball_y_pos <= ball_y_pos + y_velocity;
		end

	end
end


endmodule // ball