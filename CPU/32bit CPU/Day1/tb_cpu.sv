module tb_cpu;
	reg clk, rstn;

	initial begin
		clk	= 0;
		forever #5 clk = ~clk;
	end

	initial begin
		rstn = 1;
		#20 rstn = 0;
		#30 rstn = 1;
	end

	cpu u_cpu(clk, rstn);

	initial begin
		#1000
		$finish;
	end
endmodule