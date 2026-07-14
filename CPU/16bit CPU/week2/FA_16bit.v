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


module FA_16bit(x_in,y_in,c_in,c_out,sum);
	input [15:0] x_in;
	input [15:0] y_in;
	input c_in;
	output [15:0] sum;
	output c_out;
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
	FA fa0(x_in[0],y_in[0],c_in,c1,sum[0]);
	FA fa1(x_in[1],y_in[1],c1,c2,sum[1]);
	FA fa2(x_in[2],y_in[2],c2,c3,sum[2]);
	FA fa3(x_in[3],y_in[3],c3,c4,sum[3]);
	FA fa4(x_in[4],y_in[4],c4,c5,sum[4]);
	FA fa5(x_in[5],y_in[5],c5,c6,sum[5]);
	FA fa6(x_in[6],y_in[6],c6,c7,sum[6]);
	FA fa7(x_in[7],y_in[7],c7,c8,sum[7]);
	FA fa8(x_in[8],y_in[8],c8,c9,sum[8]);
	FA fa9(x_in[9],y_in[9],c9,c10,sum[9]);
	FA fa10(x_in[10],y_in[10],c10,c11,sum[10]);
	FA fa11(x_in[11],y_in[11],c11,c12,sum[11]);
	FA fa12(x_in[12],y_in[12],c12,c13,sum[12]);
	FA fa13(x_in[13],y_in[13],c13,c14,sum[13]);
	FA fa14(x_in[14],y_in[14],c14,c15,sum[14]);
	FA fa15(x_in[15],y_in[15],c15,c_out,sum[15]);
endmodule