module pc ( 
input  [31:0] mux_out, 
input  clk, reset, 
output reg [31:0] pc_out 

); 
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)  
            pc_out <= 32'b0;
        else 
            pc_out <= mux_out;         
    end
    
endmodule