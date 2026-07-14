`timescale 1ns/10ps

module tb_my_npu ();

parameter CONV_COLUMN = 3;
parameter CONV_ROW = 3;
parameter BIT_INPUT = 8;
parameter BIT_WEIGHT = 8;
parameter BIT_BIAS = 8;
parameter BIT_TOTAL = 23; 

reg clk , reset;

reg [CONV_COLUMN*CONV_ROW*BIT_WEIGHT-1 : 0] weight;
reg [BIT_BIAS-1 : 0] bias;
reg [CONV_COLUMN*CONV_ROW*BIT_INPUT-1 : 0] in_image;
wire [BIT_TOTAL-1 : 0] w_out_image;
wire [BIT_TOTAL-1 : 0] w_max_pooling;
wire [BIT_TOTAL-1 : 0] w_relu;


initial begin
	repeat(20)
    #5 clk = ~clk;
end
	 
initial begin
 reset = 0;
 clk = 0;
 weight = 0;
 bias = 0;
 in_image = 0;
 reset = 1;
 # 30
 reset = 0;

in_image = {8'd25, 8'd209, 8'd225, 8'd117, 8'd74, 8'd0, 8'd55, 8'd232, 8'd161};
weight = {8'd31, 8'd11, 8'd243, 8'd198, 8'd81, 8'd49, 8'd237, 8'd51, 8'd122};
bias = 8'd100;

end

my_npu module_my_npu(
    .clk(clk),
    .reset(reset),
    .weight(weight),
    .bias(bias),
    .in_image(in_image),
    .out_image(w_out_image),
	 .out_image_max_pooling(w_max_pooling),
	 .out_image_relu(w_relu)
    );
	 
endmodule
