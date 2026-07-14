module mux16bit (a, b, s, out);
	input s;
	input [15:0] a, b;
	output [15:0] out;
	
	assign out = s?a: b;
endmodule
