module id_ex(
    
    input clk, rst,
    input [31:0] data1_w, data2_w, inst_D, imm_out_w, pc_D,
    input [3:0] alu_ctrl_w,
    input alu_scr_w, reg_write_w, jump_w, branch_w, mem_read_w, mem2reg_w, mem_write_w, regDst_w,
    input reg [4:0] rd_D,
    
    output reg [31:0] srcA_E, srcB_E, imm_E, pc_E,
    output reg [3:0] alu_ctrl_w_E,
    output reg [4:0] rd_E, rs2_E,
    output reg alu_scr_w_E, reg_write_w_E, jump_w_E, branch_w_E, mem_read_w_E, mem2reg_w_E, mem_write_w_E, regDst_w_E
    
);
    
    always @(posedge clk) begin
        if(rst) begin
            reg_write_w_E <= 0;
            alu_scr_w_E <= 0;
            jump_w_E <= 0;
            alu_ctrl_w_E <= 0;
            branch_w_E <= 0;
            mem_read_w_E <= 0;
            mem2reg_w_E <= 0;
            mem_write_w_E <= 0;
            regDst_w_E <= 0;
        
            srcA_E <= 0;
            srcB_E <= 0;
            rs2_E <= 0;
            rd_E <=  0;
            imm_E <= 0;
            pc_E <= 0;
        end
        else begin
            reg_write_w_E <= reg_write_w;
            alu_scr_w_E <= alu_scr_w;
            jump_w_E <= jump_w;
            alu_ctrl_w_E <= alu_ctrl_w;
            branch_w_E <= branch_w;
            mem_read_w_E <= mem_read_w;
            mem2reg_w_E <= mem2reg_w;
            mem_write_w_E <= mem_write_w;
            regDst_w_E <= regDst_w;
        
            srcA_E <= data1_w;
            srcB_E <= data2_w;
            rs2_E <= inst_D[24:20];
            rd_E <=  rd_D;
            imm_E <= imm_out_w;
            pc_E <= pc_D;
         end
    end
endmodule