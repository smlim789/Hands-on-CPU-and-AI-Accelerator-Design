`timescale 1ns/1ps

module tb_my_cpu;

	reg	reset, clk;
	wire	[11:0] addr;
	wire	[15:0] data;
	wire	memrq;
	wire	rnw;

	
	initial clk = 0;
	
	initial reset = 1;

	
	initial begin
		repeat(100) begin
			#50 clk = !clk;
		end
	end


	initial begin
		#600
		reset = 0;
	end


	my_cpu   module_CPU(.reset(reset), .clk(clk), .addr(addr), .data(data), .memrq(memrq), .rnw(rnw));
	mem		module_memory(.clk(clk), .addr(addr), .data(data), .memrq(memrq), .rnw(rnw));


endmodule
