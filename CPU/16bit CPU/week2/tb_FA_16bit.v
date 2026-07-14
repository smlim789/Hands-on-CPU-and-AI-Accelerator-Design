module tb_FA_16bit;
  reg [15:0] x_in;
  reg [15:0] y_in;
  reg c_in;
  wire [15:0] sum;
  wire c_out;
  
  FA_16bit module_FA_16bit(x_in,y_in,c_in,c_out,sum);
  
  initial begin
    $monitor("At time %0t: x_in=%h y_in=%h, c_in=%b, sum=%h, carry=%b",$time, x_in,y_in,c_in,sum,c_out);
    x_in = 16'h0000; y_in = 16'h0001; c_in = 0; #1;
    x_in = 16'h000F; y_in = 16'h0001; c_in = 0; #1;
    x_in = 16'hFFFF; y_in = 16'h0000; c_in = 1; #1;
  end
endmodule