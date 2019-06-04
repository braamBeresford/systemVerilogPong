module rightPadd (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input mv_down,
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

always_ff @(posedge q[17],  negedge rst_n) begin 
	if(~rst_n) begin
		y_pos <= 100;
	end else begin
		y_pos <= next_pos;
	end
end

 always_comb
begin
	if(!mv_down && y_pos <380) next_pos = y_pos + 1;
	else next_pos = y_pos;
end

endmodule