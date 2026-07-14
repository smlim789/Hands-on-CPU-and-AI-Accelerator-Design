module cpu (
	input clk, rstn 
);
	wire [31:0] InstID,nextPCID;
	wire [31:0] InstEX,nextPCEX,ReadData1EX,ReadData2EX,NPC1EX,outSignEXTEX;
	wire [4:0]  WriteRegEX;
	wire [31:0] InstMEM,ReadData2MEM,ALUResultMEM,nextPCBranchMEM,NPC1MEM,nextPCMEM;
	wire [4:0]  WriteRegMEM;
	wire 	      ZeroOutMEM;
	wire [31:0]	InstWB,ALUResultWB,outputDataWB;
	wire [4:0]	WriteRegWB;
	
	wire 	      RegDstEX,RegWriteEX,ALUSrcEX,MemReadEX,MemWriteEX,MemToRegEX,BranchEX;
	wire [1:0]	ALUOpEX;
	wire [3:0]	ALUCtrlEX;
	wire 		   RegDstMEM,RegWriteMEM,ALUSrcMEM,MemReadMEM,MemWriteMEM,MemToRegMEM,BranchMEM;
	wire [3:0]	ALUCtrlMEM;
	wire 		   RegDstWB,RegWriteWB,ALUSrcWB,MemReadWB,MemWriteWB,MemToRegWB,BranchWBWB;
	wire [3:0]	ALUCtrlWB;
	
	wire [31:0]	PC;
	wire [31:0]	nextPCIF;
	wire [31:0]	InstIF;
	wire [1:0]	ALUOp;
	wire 		   RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch;

	wire [5:0] 	opcode, funct;
	wire [4:0] 	rs, rt, rd;
	wire [15:0]	imm;
	
	//IF
	InstMem u_InstMem (
		.addr (PC),
		.inst (InstIF)
	);
	assign	nextPCIF = PC+4;

	//ID
	assign opcode 	= InstID[31:26];
	assign funct	= InstID[5:0];
	assign rs 		= InstID[25:21];
	assign rt 		= InstID[20:16];
	assign rd 		= InstID[15:11];
	assign imm 		= InstID[15:0];

	Control u1_Control (
		.inst(InstID),
		.ALUOp(ALUOp), .RegDst(RegDst), .RegWrite(RegWrite), .ALUSrc(ALUSrc),
		.MemRead(MemRead), .MemWrite(MemWrite), .MemToReg(MemToReg), .Branch(Branch)
	);
	wire [4:0]WriteRegID = RegDst==1? rd: rt;

	wire [31:0]ReadData1,ReadData2;
	wire [31:0]WBData;
	
	RegFile u1_RegFile(
		.clk (clk), .rstn (rstn),
		.rs(rs), .rt(rt), 
		.WriteReg(WriteRegWB), .WriteData(WBData), .RegWrite(RegWriteWB), 
		.ReadData1(ReadData1), .ReadData2(ReadData2));	//+WB

	//EX
	wire [31:0]outSignEXT = {{16{imm[15]}},imm};
	wire [31:0]ALUSrc1	= ALUSrcEX? outSignEXTEX: ReadData2EX;

	wire [3:0]ALUCtrl;
	wire [5:0] opcodeEX = InstEX[31:26];
	wire [5:0] functEX = InstEX[5:0];
	ALUControl u2_ALUControl (
		.opcode(opcodeEX), .funct(functEX), .ALUOp(ALUOpEX),
		.ALUCtrl(ALUCtrl)
	);

	wire [31:0]ALUResult;
	wire ZeroOut;
	ALU u2_ALU (
		.src1(ReadData1EX), .src2(ALUSrc1), .ALUCtrl(ALUCtrl), 
		.result(ALUResult), .zero(ZeroOut)
	);

	//MEM
	wire [31:0]outputData;
	DataMem u3_DataMem(
		.clk(clk), .rstn(rstn),
		.MemRead(MemReadMEM), .MemWrite(MemWriteMEM), .Address(ALUResultMEM), 
		.WriteData(ReadData2MEM), .ReadData(outputData)
	);/*MEM*/
	
	//WB
	assign	WBData = MemToRegWB==1? outputDataWB: ALUResultWB;

	//PC : IF~MEM
	wire [31:0]outputSLLEX = outSignEXTEX << 2;
	wire [31:0]nextPCBranch = nextPCEX + outputSLLEX;
	wire branchEnableMEM = ZeroOutMEM & BranchMEM;

	wire [31:0] new_pc = branchEnableMEM==1? nextPCBranchMEM: nextPCIF;

	D_FF #(.WIDTH(32)) u0_PC(
		.clk	(clk	),
		.rstn	(rstn	),
		.en		(1),
		.D		(new_pc),
		.Q		(PC		)
	);

	////////////////////////////////////////////////////////////
	D_FF	#(.WIDTH(256)) u_IFID(
		.clk	(clk	),
		.rstn	(rstn	),
		.en		(1	),
		.D		({InstIF,nextPCIF}),
		.Q		({InstID,nextPCID})
	);

	D_FF	#(.WIDTH(256)) u2_IDEX(
		.clk	(clk	),
		.rstn	(rstn	),
		.en		(1		),
		.D		({RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch,ALUOp,
				  InstID,nextPCID,ReadData1,ReadData2,WriteRegID,outSignEXT}),
		.Q		({RegDstEX,RegWriteEX,ALUSrcEX,MemReadEX,MemWriteEX,MemToRegEX,BranchEX,ALUOpEX,
				  InstEX,nextPCEX,ReadData1EX,ReadData2EX,WriteRegEX,outSignEXTEX})
	);

	D_FF #(.WIDTH(256)) u_EXMEM(
		.clk	(clk	),
		.rstn	(rstn	),
		.en		(1		),
		.D		({RegDstEX,RegWriteEX,ALUSrcEX,MemReadEX,MemWriteEX,MemToRegEX,BranchEX,ALUCtrlEX,
				  InstEX,nextPCEX,ReadData2EX,ALUResult,WriteRegEX,nextPCBranch,ZeroOut}),

		.Q		({RegDstMEM,RegWriteMEM,ALUSrcMEM,MemReadMEM,MemWriteMEM,MemToRegMEM,BranchMEM,ALUCtrlMEM,
				  InstMEM,nextPCMEM,ReadData2MEM,ALUResultMEM,WriteRegMEM,nextPCBranchMEM,ZeroOutMEM})
	);

	D_FF #(.WIDTH(256)) u_MEMWB (
		.clk	(clk	),
		.rstn	(rstn	),
		.en		(1		),
		.D		({RegDstMEM,RegWriteMEM,ALUSrcMEM,MemReadMEM,MemWriteMEM,MemToRegMEM,BranchMEM,ALUCtrlMEM,
				  InstMEM,outputData,ALUResultMEM,WriteRegMEM}),
		.Q		({RegDstWB,RegWriteWB,ALUSrcWB,MemReadWB,MemWriteWB,MemToRegWB,BranchWBWB,ALUCtrlWB,
				  InstWB,outputDataWB,ALUResultWB,WriteRegWB})
	);

endmodule