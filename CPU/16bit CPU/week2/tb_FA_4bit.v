module tb_FA_4bit;
  reg [3:0] x_in;
  reg [3:0] y_in;
  reg c_in;
  wire [3:0] sum;
  wire c_out;
  
  FA_4bit module_FA_4bit(x_in,y_in,c_in,c_out,sum);
  
  initial begin
    $monitor("At time %0t: x_in=%b y_in=%b, c_in=%b, sum=%b, carry=%b",$time, x_in,y_in,c_in,sum,c_out);
    x_in = 4'b0000; y_in = 4'b0000; c_in = 0; #1;
    x_in = 4'b1110; y_in = 4'b0001; c_in = 0; #1;
    x_in = 4'b1110; y_in = 4'b0001; c_in = 1; #1;
  end
endmodule