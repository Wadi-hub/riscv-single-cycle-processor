module data_mem(

    input [31:0] alu_out,
    input [31:0] data2,
    input mem_read, mem_write, clk, rst,
    output reg [31:0] dmem_out
);
    
    //reg [31:0] dmemout;
    reg [31:0] mem [0:63];
    
    integer i;
    always @(negedge clk) begin
        
        if(rst) begin
            for(i = 0; i < 64; i = i+1) begin
                mem[i] <= 32'b0;
            end
        end
        else if (mem_write && !mem_read) begin
            mem[alu_out] <= data2;
        end        
    end
    
    always_comb begin
        if(mem_read && !mem_write) begin
            dmem_out = mem[alu_out];
        end    
    end
    
   // assign dmem_out = dmemout;
endmodule