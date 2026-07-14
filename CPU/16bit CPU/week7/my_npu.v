module my_npu (
    clk,
    reset,
    weight,
    bias,
    in_image,
    out_image,
	 out_image_max_pooling,
	 out_image_relu
    );

parameter CONV_COLUMN = 3;
parameter CONV_ROW = 3;
parameter BIT_INPUT = 8;
parameter BIT_WEIGHT = 8;
parameter BIT_BIAS = 8;
parameter BIT_BUFFER = 22;
parameter BIT_TOTAL = 23; 

input clk;
input reset;
input [CONV_COLUMN*CONV_ROW*BIT_WEIGHT-1 : 0] weight;
input [BIT_BIAS-1 : 0] bias;
input [CONV_COLUMN*CONV_ROW*BIT_INPUT-1 : 0] in_image;
output [BIT_TOTAL-1 : 0] out_image;
output [BIT_TOTAL-1 : 0] out_image_max_pooling;
output [BIT_TOTAL-1 : 0] out_image_relu;

wire [BIT_BUFFER-1 : 0] w_out_channel;
wire [BIT_TOTAL-1 : 0] r_add_bias;
wire [BIT_TOTAL-1 : 0] r_max_pooling;
wire [BIT_TOTAL-1 : 0] r_relu;


out_channel module_out_channel(
	    .clk(clk),
	    .reset(reset),
	    .weight(weight),
	    .in_image(in_image),
	    .out_ch(w_out_channel[BIT_BUFFER-1 : 0])		 
			);

bias_adding	module_bias_adding(
	    .clk(clk),
	    .reset(reset),
		 .w_out_channel(w_out_channel[BIT_BUFFER-1 : 0]),
		 .bias(bias),
		 .r_add_bias(r_add_bias[BIT_TOTAL-1 : 0])
		 );

max_pooling module_max_pooling(
	    .clk(clk),
	    .reset(reset),
		 .r_add_bias(r_add_bias[BIT_TOTAL-1 : 0]),
		 .r_max_pooling(r_max_pooling[BIT_TOTAL-1 : 0])
		 );
		 
activation_Relu module_activation_Relu(
	    .clk(clk),
	    .reset(reset),
		 .r_max_pooling(r_max_pooling[BIT_TOTAL-1 : 0]),
		 .r_relu(r_relu[BIT_TOTAL-1 : 0])
		 );

assign out_image = r_add_bias;
assign out_image_max_pooling = r_max_pooling;
assign out_image_relu = r_relu;

endmodule