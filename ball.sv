module ball #(parameter right_pad_x = 540)(input logic clk,
	input logic reset_n,
	input logic [9:0] right_paddle_pos,
	output logic [9:0] ball_y_pos ,
	output logic [9:0] ball_x_pos );

logic [9:0] next_pos_x;
logic [9:0] next_pos_y;
logic [2:0] next_x_velocity;
logic [2:0] next_y_velocity;
logic neg_x_vel;
logic next_neg_x_vel;

logic signed [2:0] x_velocity;
logic [2:0] y_velocity;

//Make a block
logic [25:0] q;
always_ff @(posedge clk, negedge reset_n)
	if(~reset_n) begin q<=0;end
	else
		begin 
		q = q+1;
		end

always_ff @(posedge q[20], negedge reset_n) begin 
	if(~reset_n) begin
		ball_x_pos <= 10;
		ball_y_pos <= 200;
		x_velocity <= 3'b111;
		y_velocity <= 0;
		neg_x_vel <= 0;
	end 
	else
	begin
		ball_y_pos <= next_pos_y;
		ball_x_pos <= next_pos_x;
//		x_velocity <= next_x_velocity;
		neg_x_vel <= next_neg_x_vel;
	end
end


always_comb
	if(ball_x_pos+x_velocity >= right_pad_x && ball_y_pos <= right_paddle_pos + 20 && ball_y_pos >= right_paddle_pos - 20) begin
					next_pos_x = right_pad_x - 1;
					next_pos_y = ball_y_pos + y_velocity;
//					next_x_velocity = x_velocity * -1; //Make it bounce back
					next_neg_x_vel = (neg_x_vel == 0) ? 1: 0;
				end
	else begin
		if(neg_x_vel) next_pos_x = ball_x_pos - x_velocity;
		else next_pos_x = ball_x_pos + x_velocity;
		next_neg_x_vel = neg_x_vel;
		next_pos_y = ball_y_pos + y_velocity;
		next_x_velocity = 3;
		next_y_velocity = 3;
		end


endmodule // ball