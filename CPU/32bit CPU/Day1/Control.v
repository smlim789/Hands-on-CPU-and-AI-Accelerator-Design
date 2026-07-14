module Control(
	input	   [31:0] inst,	
	output reg 	[1:0] ALUOp,
	output reg		  RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,Branch
);
 	parameter Rtype = 6'h00;
	parameter beq 	= 6'h04;
	parameter sw 	= 6'h2B;
	parameter lw 	= 6'h23;
	parameter addi	= 6'h08;
	parameter andi 	= 6'h0C;

	wire [5:0]	opcode =inst[31:26];

	always @* begin
		ALUOp=2'b0;
		RegDst=1'b0;
		RegWrite=1'b0;
		ALUSrc=1'b0;
		MemRead=1'b0;
		MemWrite=1'b0;
		MemToReg=1'b0;
		Branch=1'b0;

		if (inst != 0) begin
			case(opcode)
			Rtype:begin  //rtype
				ALUOp=2'b10;
				RegDst=1'b1;
				RegWrite=1'b1;
			end
			lw:begin  //lw
				ALUOp=2'b00;
				RegWrite=1'b1;
				ALUSrc=1'b1;  //
				MemRead=1'b1;
				MemToReg=1'b1;
			end
			sw:begin  //sw
				ALUOp=2'b00;
				ALUSrc=1'b1;  //
				MemWrite=1'b1;
			end
			beq:begin  //beq
				ALUOp=2'b01;
				Branch=1'b1;
			end
			//end
			addi,andi: begin  //addi
				ALUOp=2'b11;
				RegWrite=1'b1;
				ALUSrc=1'b1;
			end
			endcase
		end
	end
endmodule