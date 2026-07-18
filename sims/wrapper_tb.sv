module wrapper_testbench;
    
    reg clk, rst;
    
    wrapper DUT(clk, rst);
        
    initial begin
        
       
        clk=1;
        rst=1;
        
        #10;
        
        rst=0;
        
        #120
        $stop;
  end
    
 always
  begin
    #5;
    clk=~clk;
    end
endmodule