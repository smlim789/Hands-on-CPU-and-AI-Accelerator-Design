`define LDA 4'b0000 
`define STO 4'b0001 
`define ADD 4'b0010 
`define STP 4'b0111
`define SUB 4'b0011

module my_cpu (reset, clk, addr, data, memrq, rnw);
	input reset, clk;
	inout [15:0] data;
	output [11:0] addr;
	output memrq, rnw;
	wire [15:0] alu, ir, pc, b, acc;
	wire [1:0] alufs;
	
	pc_reg pc_reg(.clk(clk), .pcce(pcce), .alu(alu), .pc(pc)); 
	ir_reg ir_reg(.clk(clk), .irce(irce), .data(data), .ir(ir));
	mux12bit mux12(.a(ir[11:0]), .b(pc[11:0]), .s(asel), .out(addr));
	mux16bit mux16(.a(data), .b({4'b0000, addr}), .s(bsel), .out(b));
	acc_reg acc_reg(.clk(clk), .accce(accce), .alu(alu), .acc(acc), .acc15(acc15), .accz(accz)); 
	tri16bit tri16(.in(acc), .oe(accoe), .out(data));
	sync_rst sync_rst(.reset(reset), .clk(clk), .sreset(sreset));
	alu16 alu16(.reset(sreset), .a(acc), .b(b), .alufs(alufs), .alu(alu));
	fsm	fsm(.reset(sreset), .clk(clk), .opcode(ir[15:12]), .accz(accz), .acc15(acc15),
				.asel(asel), .bsel(bsel), .accce(accce), .pcce(pcce), .irce(irce), .accoe(accoe), 
				.alufs(alufs), .memrq(memrq), .rnw(rnw));
endmodule


module mem (clk, addr, data, memrq, rnw); 
	input clk, memrq, rnw;
	input [11:0] addr;
	inout [15:0] data;
	reg [15:0] mem [127:0];
	
	assign data = memrq & rnw ? mem[addr]: 16'hz; // read
	
	always @(negedge clk) // write
		if (memrq & !rnw) mem[addr] <= data;
	
	initial begin
		mem[0] = {`LDA, 12'h66}; // program codes start
		mem[1] = {`SUB, 12'h65};
		mem[2] = {`STO, 12'h66};
		mem[3] = {`LDA, 12'h66};
		mem[4] = {`SUB, 12'h64};	
		mem[5] = {`STO, 12'h66};
		mem[6] = {`STP, 12'h0};
		mem['h64] = 16'h0011; // program data start
		mem['h65] = 16'h0222;
		mem['h66] = 16'h3333;
	end
endmodule
