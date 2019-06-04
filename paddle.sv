module paddle (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input mv_down,
	input mv_up, 
	output logic [9:0] y_pos
);

logic [9:0] next_pos;

//Make into a block
logic [17:0] q;

always_ff @(posedge clk, negedge rst_n)
	if(~rst_n) begin q<=0;end
	else
		begin 
		q = q+1;
		end

always_ff @(posedge q[15],  negedge rst_n) begin 
	if(~rst_n) begin
		y_pos <= 100;
	end else begin
		y_pos <= next_pos;
	end
end

 always_comb
begin
	if(!mv_down && y_pos <480) next_pos = y_pos + 1;
	else if (!mv_up && y_pos > 0) next_pos = y_pos -1;
	else next_pos = y_pos;
end

endmodule