module ball #(parameter right_pad_x = 540)(input logic clk,
	input logic reset_n,
	input logic [9:0] right_paddle_pos,
	output logic [9:0] ball_y_pos ,
	output logic [9:0] ball_x_pos );

logic [9:0] next_pos_x;
logic [9:0] next_pos_y;
logic move_pos;

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
		move_pos <= 1;
	end 
	else
	begin
		ball_y_pos <= next_pos_y;
		ball_x_pos <= next_pos_x;
		if(ball_x_pos+6 >= right_pad_x && ball_y_pos+5 <= right_paddle_pos + 20 && ball_y_pos-5 >= right_paddle_pos - 20 && move_pos ==  1) move_pos = ~move_pos;
	end
end


always_comb
begin

	if(move_pos) next_pos_x = ball_x_pos +1;
	else next_pos_x = ball_x_pos - 1;
	next_pos_y = ball_y_pos;
end


endmodule // ball