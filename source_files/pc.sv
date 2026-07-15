module pc ( 
input  wire [31:0] mux_out, 
input  wire     clk, reset, 
output wire [31:0] pc_out 
); 
    
    reg [31:0] pc_outt;
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            pc_outt <= 32'b0;
        else 
            pc_outt <= mux_out;    
    end
    
    assign pc_out = pc_outt;
endmodule