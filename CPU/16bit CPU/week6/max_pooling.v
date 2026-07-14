module max_pooling (
		clk,
		reset,
		r_add_bias,
		r_max_pooling
		);

parameter BIT_TOTAL = 23;
parameter BIT_BUFFER = 22;
parameter BIT_BIAS = 8;
parameter max_pool_num = 200000;

input clk;
input reset;
input [BIT_TOTAL-1 : 0]	r_add_bias;
output reg [BIT_TOTAL-1 : 0] r_max_pooling;

wire [BIT_TOTAL-1 : 0] pooling_constant;

assign pooling_constant = max_pool_num;

always @(*) begin
	if (r_add_bias > pooling_constant)
		r_max_pooling <= r_add_bias;
	else
		r_max_pooling <= pooling_constant;
	end

endmodule