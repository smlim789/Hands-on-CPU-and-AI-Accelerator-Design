module out_channel (
    clk,
    reset,
    weight,
    in_image,
    out_ch
    );
	 
parameter CONV_COLUMN = 3;
parameter CONV_ROW = 3;
parameter BIT_INPUT = 8;
parameter BIT_WEIGHT = 8;
parameter BIT_MULTI_TOTAL = 20;
parameter BIT_BUFFER = 22;

input clk;
input reset;
input [CONV_COLUMN*CONV_ROW*BIT_WEIGHT-1 : 0] weight;
input [CONV_COLUMN*CONV_ROW*BIT_INPUT-1 : 0] in_image;
output [BIT_BUFFER-1 : 0] out_ch;

wire [BIT_MULTI_TOTAL-1 : 0] w_multi_total;
wire [BIT_BUFFER-1 : 0] w_out_ch;
reg [BIT_BUFFER-1 : 0] r_out_ch;

		in_channel module_in_channel(
    	.clk(clk),
    	.reset(reset),
    	.weight(weight),
    	.in_image(in_image),
    	.out_in_ch(w_multi_total[BIT_MULTI_TOTAL-1 : 0])             
    	);


always @(posedge clk or posedge reset) begin
    if(reset) begin
        r_out_ch[BIT_BUFFER-1 : 0] <= {BIT_BUFFER{1'b0}};
    end else begin
        r_out_ch[BIT_BUFFER-1 : 0] <= w_multi_total[BIT_MULTI_TOTAL-1 : 0];
    end
end

assign out_ch = r_out_ch;

endmodule