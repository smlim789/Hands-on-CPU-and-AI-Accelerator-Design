module alu1bit (reset, a, b, aen, binv, cin, cout, sum);

	input reset, a, b, aen, binv, cin;
	output cout, sum;
	wire x1, x2, x3, x4, x5, x6, x7, x8, x9, x10;
	
	assign x1 = (b & !binv) | (!b & binv);
	assign x2 = (a & aen);
	assign x3 = !(x1 & x2);	
	assign x4 = !(x1 & x3);
	assign x5 = !(x2 & x3);
	assign x6 = !(x4 & x5);
	assign x7 = !(cin & x6);
	assign x8 = !(cin & x7);
	assign x9= !(x7 & x6);
	assign x10 = !(x8 & x9);
	assign cout = !(x7 & x3); 
	assign sum = (x10 & !reset); 
	
endmodule