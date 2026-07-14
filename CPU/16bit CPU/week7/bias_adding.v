module bias_adding (
		clk,
		reset,
		w_out_channel,
		bias,
		r_add_bias
		);

parameter BIT_TOTAL = 23;
parameter BIT_BUFFER = 22;
parameter BIT_BIAS = 8;

input clk;
input reset;
input [BIT_BUFFER-1 : 0] w_out_channel;
input [BIT_BIAS-1    : 0] bias;
output reg [BIT_TOTAL-1 : 0] r_add_bias;

wire [BIT_TOTAL-1 : 0] add_bias;

assign add_bias[BIT_TOTAL-1 : 0] = w_out_channel[BIT_BUFFER-1 : 0] + bias[BIT_BIAS-1 : 0];

always @(posedge clk or posedge reset) begin
	if(reset) 
		r_add_bias[BIT_TOTAL-1 : 0]   <= {BIT_TOTAL{1'b0}};
	else
		r_add_bias[BIT_TOTAL-1 : 0]   <= add_bias[BIT_TOTAL-1 : 0];
end

endmodule