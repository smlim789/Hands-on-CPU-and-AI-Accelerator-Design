module tri16bit (in, oe, out);
	input oe;
	input [15:0] in;
	output [15:0] out;
	
	assign out = oe ? in: 16'hz; 
endmodule