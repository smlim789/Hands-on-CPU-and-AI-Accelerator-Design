module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output reg [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    //인스턴스화된 카운터로 초를 표현한다
    wire ssl_2_ssh,ssh_2_mml;   //하위 비트에서 상위 비트로의 캐리
    cnt cnt_ssl(.clk(clk),.reset(reset),.count_start(ena),.count_end(4'd9),.end_cnt(ssl_2_ssh),.count(ss[3:0]));
    cnt cnt_ssh(.clk(clk),.reset(reset),.count_start(ssl_2_ssh),.count_end(4'd5),.end_cnt(ssh_2_mml),.count(ss[7:4]));
   
    //분을 나타내는 카운터를 인스턴스화하다
    wire mml_2_mmh, mmh_2_hh;
    cnt cnt_mml(.clk(clk),.reset(reset),.count_start(ssh_2_mml),.count_end(4'd9),.end_cnt(mml_2_mmh),.count(mm[3:0]));
    cnt cnt_mmh(.clk(clk),.reset(reset),.count_start(mml_2_mmh),.count_end(4'd5),.end_cnt(mmh_2_hh),.count(mm[7:4]));
    
    //시간을 세다
    reg a_2_p;
    always @(posedge clk)begin
        if(reset)begin
            a_2_p <= 0;
            hh <= 8'h12;        // 초기 조건은 오전 12:00:00  <-- h24->h12
        end
        else if(mmh_2_hh)begin
            if(hh == 8'h12)
                hh <= 8'h01;
            else begin
                hh <= hh + 1'b1;
                if(hh == 8'h12)  // <-- h09->h12
                    hh <= 8'h10; // <-- h0A->h10
                if(hh == 8'h11)
                    a_2_p <= ~ a_2_p;
            end
        end
    end
    assign pm = a_2_p;
endmodule

//카운터 하위 모듈은 시작과 종료 조건을 설정할 수 있다
module cnt(
    input clk,
    input reset,
    input count_start,     //카운팅 시작 입력
    input [3:0] count_end, //어느 정도까지 세며, 그 때 카운팅을 정지
    output end_cnt,        //한 번의 카운팅 완료 표시
    output reg [3:0] count);
 
    wire add_cnt;
	 
    always @(posedge clk)begin
        if(reset)begin
           count <= 4'd0; 
        end
        else if(add_cnt)begin
            if(end_cnt)
                count <= 4'd0;
            else
                count <= count + 1'b1;
        end
    end
    assign add_cnt = count_start;   //카운팅 시작 조건, 조건이 충족되면 카운팅 시작
    assign end_cnt = add_cnt && count == count_end;    //카운팅 종료 시 표시 생성
endmodule