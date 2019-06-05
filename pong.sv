
module pong (input logic masterCLK, output logic hsync, 
			output logic vsync, output logic [3:0] blue,
			output logic [3:0] red, output logic [3:0] green,
			input logic reset_button_n,
			input logic right_down_switch, input logic left_down_switch,
			input logic right_up_switch, input logic left_up_switch,
			input logic reset_score_n);
			
		logic clk;
		logic toOutputMux;
		logic [9:0] x_count;
		logic [9:0] y_count;
		logic [9:0] ball_y_pos;
		logic [9:0] ball_x_pos;
		logic [9:0] right_pad_y_pos;
		logic [9:0] left_pad_y_pos;
		logic end_of_round;

		assign reset_n = end_of_round && reset_button_n;
		//VGA Protocol
		clkDivider clkDiv(
			.clk(masterCLK),
//			.reset_n(reset_n),
			.newClk(clk)
			);
			
		horizCounter horizCounter1(
			.clk(clk),
//			.reset_n(reset_n),
			.hsync(hsync),
			.x_count(x_count)
			);
		
		vertCounter vertCounter1(
			.clk(clk),
//			.reset_n(reset_n),
			.vsync(vsync),
			.x_count(x_count),
			.y_count(y_count)
			);


		scoreKeeper referee(
			.clk(clk),
			.reset_n(end_of_round),
			.reset_score_n(reset_score_n),
			.ball_x_pos(ball_x_pos)
			);
		
		assign toOutputMux = (x_count < 640) && (y_count < 480);
		assign blue = 0;
		
		assign right_paddle_green = (x_count < 550 && x_count > 540 && y_count <= right_pad_y_pos+20  &&  y_count >= right_pad_y_pos-20) ? 4'b111: 0;

		assign left_paddle_green = (x_count < 100 && x_count > 90 && y_count <= left_pad_y_pos+20  &&  y_count >= left_pad_y_pos-20) ? 4'b111: 0;

				
		assign ball_red = (x_count < ball_x_pos + 5 && x_count > ball_x_pos-5 && y_count <= ball_y_pos+5 && y_count >= ball_y_pos-5) ? 4'b111: 0;
		
		assign  paddle_green = right_paddle_green || left_paddle_green;
		
		enableMux greenMux(
			.a(paddle_green),
			.controlSig(toOutputMux),
			.d(green)
			);

		enableMux redMux(
			.a(ball_red),
			.controlSig(toOutputMux),
			.d(red)
			);
		
		
		paddle rightPadd(
			.clk(clk),
			.rst_n(reset_n),
			.mv_down(right_down_switch),
			.mv_up(right_up_switch),
			.y_pos(right_pad_y_pos)
			);
			
		paddle leftPadd(
			.clk(clk),
			.rst_n(reset_n),
			.mv_down(left_down_switch),
			.mv_up(left_up_switch),
			.y_pos(left_pad_y_pos)
			);
			

		ball ball1(
			.clk(clk),
			.reset_n(reset_n),
			.right_paddle_pos(right_pad_y_pos),
			.left_paddle_pos(left_pad_y_pos),
			.ball_y_pos(ball_y_pos),
			.ball_x_pos(ball_x_pos)
			);
		
		
endmodule