module DFF #(
	parameter	WIDTH=32
)(
	input	clk, rstn,
	input	en,
	input [WIDTH-1:0] D,
	output reg [WIDTH-1:0] Q
);
	always @(posedge clk, negedge rstn)
	if(!rstn)		Q <= 0;
	else if (en) 	Q <= D;
	

endmodule
