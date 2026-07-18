module mem_wb(
    
    input clk, rst,
    input [31:0] mem_out, alu_out_w_M,
    input [4:0] writeRegBack_M,
    input reg_write_w_M, mem2reg_w_M,
    
    output reg [31:0] mem_out_wb, alu_out_w_wb,
    output reg [4:0] rd_wb,
    output reg reg_write_w_wb, mem2reg_w_wb
);
    
    always @(posedge clk) begin
        if(rst) begin
            reg_write_w_wb <= 0;
            mem2reg_w_wb <= 0;
        
            rd_wb <= 0;
        
            mem_out_wb <= 0;
            alu_out_w_wb <= 0;
        end
        else begin
            reg_write_w_wb <= reg_write_w_M;
            mem2reg_w_wb <= mem2reg_w_M;
        
            rd_wb <= writeRegBack_M;
        
            mem_out_wb <= mem_out;
            alu_out_w_wb <= alu_out_w_M;
        end
    end
    
endmodule