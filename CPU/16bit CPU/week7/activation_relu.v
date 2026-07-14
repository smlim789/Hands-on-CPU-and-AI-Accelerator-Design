module activation_Relu (
		clk,
		reset,
		r_max_pooling,
		r_relu
		);

parameter BIT_TOTAL = 23;
parameter BIT_BUFFER = 22;
parameter BIT_BIAS = 8;

input clk;
input reset;
input [BIT_TOTAL-1 : 0]	r_max_pooling;
output reg [BIT_TOTAL-1 : 0] r_relu;

always @(*) begin
	if (r_max_pooling > 0)
		r_relu <= r_max_pooling;
	else
		r_relu <= 0;
	end

endmodule