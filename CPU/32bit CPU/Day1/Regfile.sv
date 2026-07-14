module RegFile (
	input		clk, rstn,
	input [4:0] rs, rt, WriteReg,
	input [31:0] WriteData,
	input 		RegWrite,
	output [31:0] ReadData1, ReadData2
);

  	reg [31:0] array [31:0];
 	always @(posedge clk, negedge rstn)
	if	(!rstn)	for(int i=0;i<32;i++) array[i] <= 0;
	else if (RegWrite)	array[WriteReg] <= WriteData;

  	assign ReadData1 = array[rs];
  	assign ReadData2 = array[rt];
endmodule