module ALU(
	input 	   [31:0] src1,src2,
	input 		[3:0] ALUCtrl,
	output reg [31:0] result,
	output 			  zero
);

	always @* begin
	case (ALUCtrl)
		4'b0000 : result = src1 + src2; // ADD
		4'b0001 : result = src1 - src2; // SUB
		4'b0010 : result = src1 & src2; // AND
		default : result = src1 + src2; // ADD
	endcase
	end

	assign	zero = result == 0;

endmodule