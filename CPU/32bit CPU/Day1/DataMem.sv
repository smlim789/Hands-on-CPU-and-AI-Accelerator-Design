module DataMem(
	input		 clk, rstn,
	input 		 MemRead, MemWrite, 
	input [31:0] Address, 
	input [31:0] WriteData, 
	output[31:0] ReadData
);
  	reg [31:0] mem [127:0];

	always @(posedge clk, negedge rstn)
	if	(!rstn)	for (int i=0;i<64;i++) mem[i] <= 0;
	else if (MemWrite)	mem[Address[5:0]] <= WriteData;

	assign	ReadData = MemRead? mem[Address[5:0]]: 'bX;

endmodule