module mux12bit (a, b, s, out);
	input s;
	input [11:0] a, b;
	output [11:0] out;
	
	assign out = s?a: b;
endmodule