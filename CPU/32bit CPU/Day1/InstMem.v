module InstMem(
	input  [31:0] addr, 
	output [31:0] inst
);
 
	reg [31:0] mem [23:0];
	
	initial begin
		mem[ 0]={6'h08,5'd0,5'd1,16'd1};		 //addi r1,r0,1
		mem[ 1]={6'h08,5'd0,5'd2,16'd2};		 //addi r2,r0,2
		mem[ 2]={6'h08,5'd0,5'd3,16'd3};		 //addi r3,r0,3
		mem[ 3]={6'h08,5'd0,5'd4,16'd4};		 //addi r4,r0,4
		
		mem[ 4]={6'h00,5'd0,5'd1,5'd5,5'h0,6'h0};//add r5,r0,r1
		mem[ 5]={6'h00,5'd1,5'd2,5'd6,5'h0,6'h0};//add r6,r1,r2
		mem[ 6]={6'h00,5'd2,5'd3,5'd7,5'h0,6'h0};//add r7,r2,r3
		mem[ 7]={6'h00,5'd3,5'd4,5'd8,5'h0,6'h0};//add r8,r3,r4

		mem[ 8]={6'h2B,5'd0,5'd5,16'd1};		 //sw r5,1(r0)
		mem[ 9]={6'h2B,5'd1,5'd6,16'd2};		 //sw r6,2(r1)
		mem[10]={6'h2B,5'd2,5'd7,16'd3};		 //sw r7,3(r2)
		mem[11]={6'h2B,5'd3,5'd8,16'd4};		 //sw r8,4(r3)
	 
		mem[12]={6'h23,5'd0,5'd9 ,16'd1};		 //lw r9 ,1(r0)
		mem[13]={6'h23,5'd1,5'd10,16'd2};		 //lw r10,2(r1)
		mem[14]={6'h23,5'd2,5'd11,16'd3};		 //lw r11,3(r2)
		mem[15]={6'h23,5'd3,5'd12,16'd4};		 //lw r12,4(r3)

		mem[16]={6'h08,5'd0,5'd0,16'd4};		 //addi r0,r0,4
		mem[17]={6'h04,5'd5,5'd9,-16'd18};		 //beq r5,r9,-72 //goto 0
		mem[18]='b0;
		mem[19]='b0;

		mem[20]='b0;
		mem[21]='b0;
		mem[22]='b0;
		mem[23]='b0;
  	end
  	
	assign	inst = mem[addr>>2];

endmodule