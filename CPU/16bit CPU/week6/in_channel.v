module in_channel (
    clk,
    reset,
    weight,
    in_image,
    out_in_ch
	 );

parameter CONV_COLUMN = 3;
parameter CONV_ROW = 3;
parameter BIT_INPUT = 8;
parameter BIT_WEIGHT = 8;
parameter BIT_MULTI = 16;
parameter BIT_MULTI_TOTAL = 20;

input clk;
input reset;
input [CONV_COLUMN*CONV_ROW*BIT_WEIGHT-1 : 0] weight;
input [CONV_COLUMN*CONV_ROW*BIT_INPUT-1 : 0] in_image;
output [BIT_MULTI_TOTAL-1 : 0] out_in_ch;

wire [CONV_ROW*CONV_COLUMN*BIT_MULTI-1 : 0] multi ;
reg [CONV_ROW*CONV_COLUMN*BIT_MULTI-1 : 0] r_multi;

genvar x;
generate
	for(x = 0; x < CONV_ROW*CONV_COLUMN; x = x + 1) begin : xx
		assign  multi[x * BIT_MULTI +: BIT_MULTI]	= in_image[x * BIT_INPUT +: BIT_INPUT] * weight[x * BIT_WEIGHT +: BIT_WEIGHT];
	
		always @(posedge clk or posedge reset) begin
		    if(reset) begin
		        r_multi[x * BIT_MULTI +: BIT_MULTI] <= {BIT_MULTI{1'b0}};
		    end 
			 else begin
		        r_multi[x * BIT_MULTI +: BIT_MULTI] <= multi[x * BIT_MULTI +: BIT_MULTI];
		    end
		end
	end
endgenerate

reg [BIT_MULTI_TOTAL-1 : 0] kernel;
reg [BIT_MULTI_TOTAL-1 : 0] r_kernel;

integer y;
generate
	always @ (*) begin
		kernel[0 +: BIT_MULTI_TOTAL]= {BIT_MULTI_TOTAL{1'b0}};
		for(y =0; y < CONV_ROW*CONV_COLUMN; y = y +1) begin
			kernel[0 +: BIT_MULTI_TOTAL] = kernel[0 +: BIT_MULTI_TOTAL] + r_multi[y*BIT_MULTI +: BIT_MULTI]; 
		end
	end
	always @(posedge clk or posedge reset) begin
	    if(reset) begin
	        r_kernel[0 +: BIT_MULTI_TOTAL] <= {BIT_MULTI_TOTAL{1'b0}};
	    end 
		 else begin
	        r_kernel[0 +: BIT_MULTI_TOTAL] <= kernel[0 +: BIT_MULTI_TOTAL];
	    end
	end
endgenerate

assign out_in_ch = r_kernel;

endmodule
