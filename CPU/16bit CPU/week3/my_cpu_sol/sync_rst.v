module sync_rst(reset, clk, sreset);
	input reset, clk;
	output sreset;
	reg sreset, sreset1;
	
	always @(negedge clk)
		{sreset, sreset1} <= {sreset1, reset}; 
endmodule