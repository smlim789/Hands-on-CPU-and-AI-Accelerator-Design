module ALUControl(
	input		[5:0] opcode,
	input 		[5:0] funct,
	input		[1:0] ALUOp,
	output reg 	[3:0] ALUCtrl
);
	parameter [5:0] //funct
		add_r = 6'h20,
		sub_r = 6'h22,
		and_r = 6'h24;
	
	parameter [5:0] //opcode
		add_i = 6'h08,
		and_i = 6'h0C;

	always @* begin 
		ALUCtrl=0;
		case(ALUOp)
		2'b10:case(funct)
			add_r:	ALUCtrl=4'b00;//add
			sub_r:	ALUCtrl=4'b01;//sub
			and_r:	ALUCtrl=4'b10;//and
		endcase 
		2'b11:case(opcode)
			add_i:	ALUCtrl=4'b00;//add
			and_i:	ALUCtrl=4'b10;//and
		endcase
		2'b00:		ALUCtrl=4'b00;//lw, sw needs add operation
		2'b01:		ALUCtrl=4'b01;//branch needs sub operation
		endcase
	end

endmodule