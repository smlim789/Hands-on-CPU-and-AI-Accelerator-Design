module pc_reg (clk, pcce, alu, pc);

	input clk, pcce;
	input [15:0] alu;
	output [15:0] pc;
	reg [15:0] pc;
	
	always @(negedge clk)
		if (pcce) pc <= alu[15:0];
		
endmodule