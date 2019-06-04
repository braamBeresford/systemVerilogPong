module ball #(parameter right_pad_x = 540, left_pad_x = 100)(input logic clk,
	input logic reset_n,
	input logic [9:0] right_paddle_pos,
	input logic [9:0] left_paddle_pos,
	output logic [9:0] ball_y_pos,
	output logic [9:0] ball_x_pos );

logic [9:0] next_pos_x;
logic [9:0] next_pos_y;
logic move_pos_x;
logic move_pos_y;

//Make a block
logic [25:0] q;
always_ff @(posedge clk, negedge reset_n)
	if(~reset_n) begin q<=0;end
	else
		begin 
		q = q+1;
		end

always_ff @(posedge q[16], negedge reset_n) begin 
	if(~reset_n) begin
		ball_x_pos <= 100;
		ball_y_pos <= 200;
		move_pos_x <= 1;
		move_pos_y <= 1;
	end 
	else
	begin
		ball_y_pos <= next_pos_y;
		ball_x_pos <= next_pos_x;
		//Right paddle
		if(ball_x_pos+6 >= right_pad_x && ball_y_pos+5 <= right_paddle_pos + 20 && ball_y_pos-5 >= right_paddle_pos - 20 && move_pos_x ==  1) move_pos_x = ~move_pos_x;
		
		//Left paddle
		if(ball_x_pos-6 <= left_pad_x && ball_y_pos+5 <= left_paddle_pos + 20 && ball_y_pos-5 >= left_paddle_pos - 20 && move_pos_x ==  0) move_pos_x = ~move_pos_x;

		//Wall detection
		if((ball_y_pos+6 >= 480 && move_pos_y == 1) || (ball_y_pos- 6 <= 0 && move_pos_y == 0)) move_pos_y = ~move_pos_y;
	end
end

// X-axis movement
always_comb
begin
	if(move_pos_x) next_pos_x = ball_x_pos +1;
	else next_pos_x = ball_x_pos - 1;
end


// Y-axis movement
always_comb
begin
	if(move_pos_y) next_pos_y = ball_y_pos +1;
	else next_pos_y = ball_y_pos - 1;
end


endmodule // ball