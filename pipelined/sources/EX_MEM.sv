module ex_mem(
    
    input clk, rst,
    input reg_write_w_E, mem2reg_w_E, mem_write_w_E, branch_w_E, zero_w, mem_read_w_E,
    input [31:0] alu_out_w, srcB_E, pc_shift_adder_w,
    input [4:0] writeReg_w,
    
    output reg reg_write_w_M, mem2reg_w_M, mem_write_w_M, branch_w_M, zero_M, mem_read_w_M,
    output reg [31:0] alu_out_w_M, srcB_M, pc_shift_adder_w_M,
    output reg [4:0] writeRegBack_M
);
    
    always @(posedge clk) begin
        
        if(rst) begin 
            reg_write_w_M <= 0;
            mem2reg_w_M <= 0;
            mem_write_w_M <= 0; 
            branch_w_M <= 0;
            mem_read_w_M <= 0;
 
            alu_out_w_M <= 0;
            zero_M <= 0;
            srcB_M <= 0;
            writeRegBack_M <= 0;
            pc_shift_adder_w_M <= 0; 
        
        end 
        else begin
            reg_write_w_M <= reg_write_w_E;
            mem2reg_w_M <= mem2reg_w_E;
            mem_write_w_M <= mem_write_w_E; 
            branch_w_M <= branch_w_E;
            mem_read_w_M <= mem_read_w_E;
        
            alu_out_w_M <= alu_out_w;
            zero_M <= zero_w;
            srcB_M <= srcB_E;
            writeRegBack_M <= writeReg_w;
            pc_shift_adder_w_M <= pc_shift_adder_w; 
       end       
    end
endmodule