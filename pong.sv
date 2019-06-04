module pong (input logic masterCLK, output logic hsync, 
			output logic vsync, output logic [3:0] blue,
			output logic [3:0] red, output logic [3:0] green,
			input logic reset_n, output logic [9:0] count,
			input logic down_switch, output logic [9:0] y_pos);
			
		logic clk;
		logic toOutputMux;
		logic [9:0] x_count;
		logic [9:0] y_count;
		logic [9:0] ball_y_pos;
		logic [9:0] ball_x_pos;

		//VGA Protocol
		clkDivider clkDiv(
			.clk(masterCLK),
			.reset_n(reset_n),
			.newClk(clk)
			);
			
		horizCounter horizCounter1(
			.clk(clk),
			.reset_n(reset_n),
			.hsync(hsync),
			.x_count(x_count)
			);
		
		vertCounter vertCounter1(
			.clk(clk),
			.reset_n(reset_n),
			.vsync(vsync),
			.x_count(x_count),
			.y_count(y_count)
			);
		
		assign toOutputMux = (x_count < 640) && (y_count < 480);
		assign blue = 0;
		
		assign right_paddle_green = (x_count < 550 && x_count > 540) ?
							((y_count <= y_pos+20  &&  y_count >= y_pos-20) ? 4'b111: 0): 0 ;

		assign ball_red =  (x_count < ball_x_pos + 5 && x_count > ball_x_pos-5 && y_count <= ball_y_pos+5 && y_count >= ball_y_pos-5) ? 4'b111: 0;
		
		enableMux greenMux(
			.a(right_paddle_green),
			.controlSig(toOutputMux),
			.d(green)
			);

		enableMux redMux(
			.a(ball_red),
			.controlSig(toOutputMux),
			.d(red)
			);
		
		
		rightPadd paddle(
			.clk(clk),
			.rst_n(reset_n),
			.mv_down(down_switch),
			.y_pos(y_pos)
			);

		ball ball1(
			.clk(clk),
			.reset_n(reset_n),
			.right_paddle_pos(y_pos),
			.ball_y_pos(ball_y_pos),
			.ball_x_pos(ball_x_pos)
			);
		
		
endmodule