module FA(
	a,
	b,
	cin,
	cout,
	sum
);

	input a ;
	input b ;
	input cin ;
	output cout ;
	output sum ;

  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (a & cin);
	
endmodule


module FA_4bit(x_in,y_in,c_in,c_out,sum);
	input [3:0] x_in;
	input [3:0] y_in;
	input c_in;
	output [3:0] sum;
	output c_out;
	wire c1,c2,c3;
	FA fa0(x_in[0],y_in[0],c_in,c1,sum[0]);
	FA fa1(x_in[1],y_in[1],c1,c2,sum[1]);
	FA fa2(x_in[2],y_in[2],c2,c3,sum[2]);
	FA fa3(x_in[3],y_in[3],c3,c_out,sum[3]);
endmodule