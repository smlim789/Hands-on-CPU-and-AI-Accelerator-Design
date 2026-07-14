module tb_FA;
  reg a, b, cin;
  wire sum, cout;
  
  FA module_FA(a, b, cin, cout, sum);
  
  initial begin
    $monitor("At time %0t: a=%b b=%b, cin=%b, sum=%b, carry=%b",$time, a,b,cin,cout,sum);
    a = 0; b = 0; cin = 0; #1;
    a = 0; b = 0; cin = 1; #1;
    a = 0; b = 1; cin = 0; #1;
    a = 0; b = 1; cin = 1; #1;
    a = 1; b = 0; cin = 0; #1;
    a = 1; b = 0; cin = 1; #1;
    a = 1; b = 1; cin = 0; #1;
    a = 1; b = 1; cin = 1;
  end
endmodule