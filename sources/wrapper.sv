module wrapper(
    
    input clk, rst
);
    
    wire [31:0] pc_out_w, inst_w, data1_w, data2_w, data_writeBack_w, alu_out_w, mem_out, branch_pc_4_mux; 
    //wire [31:0] mux_out_pc_in_w;
    wire [4:0] writeReg_w;
    wire [31:0] imm_out_w, pc_4_adder_w, pc_shift_adder_w, alu_data2_mux;
    wire [3:0] alu_ctrl_w;
    wire [1:0] alu_op_w;
    wire reg_write_w, mem_read_w, mem_write_w, branch_w, mem2reg_w, alu_scr_w, zero_w, pc_src, jump_w, regDst_w;
    
   
   //PC Source Mux
    mux2 #(.width(32)) PC_src_mux (.in0(pc_4_adder_w), .in1(pc_shift_adder_w_M), .sel(pc_src), .out(branch_pc_4_mux));
   
    //Program Counter
    pc program_counter(.mux_out(branch_pc_4_mux), .clk(clk), .reset(rst), .pc_out(pc_out_w));
    
        
    //################################## Reg IF/ID ##################################   
    
    //PC + 4 Adder
     param_adder PC_adder_4(.in0(32'd4), .in1(pc_out_w), .out(pc_4_adder_w));
      
    // Instruction Memory
    instructionMemory ins_mem(.pc_out(pc_out_w), .inst(inst_w));
   
   
   //-------------------------------------
    wire [31:0] inst_D, pc_D;
    wire [4:0] rd_D; 
    
    if_id reg1(.inst_w(inst_w), .pc_out_w(pc_out_w), .clk(clk), .rst(rst), .inst_D(inst_D), .pc_D(pc_D), .rd_D(rd_D));
   //-------------------------------------
    
    
    //################################## Reg ID/EX ##################################
    //Control Unit
    control_path controlSignals(.inst(inst_D), .branch(branch_w), .mem_rd(mem_read_w), .mem2reg(mem2reg_w), 
    .mem_write(mem_write_w), .alu_scr(alu_scr_w), .reg_write(reg_write_w), .jump(jump_w), .regDst(regDst_w), .alu_op(alu_op_w));
    
    //Register File
    reg_file regFile(.inst(inst_D), .rd(rd_wb), .data_write(data_writeBack_w), .clk(clk), .write_en(reg_write_w_wb), .rst(rst), 
    .data1(data1_w), .data2(data2_w));
    
    //Immediate Generator
    immediate_gen immGen(.inst(inst_D), .imm_out(imm_out_w));
    
    //ALU Control
    alu ALU_Control(.inst(inst_D), .alu_op(alu_op_w), .operations(alu_ctrl_w)); 
   
   
   //------------------------------------- 
    wire [31:0] srcA_E, srcB_E, imm_E, pc_E;
    wire [3:0] alu_ctrl_w_E;
    wire [4:0] rd_E, rs2_E;
    wire alu_scr_w_E, reg_write_w_E, jump_w_E, branch_w_E, mem_read_w_E, mem2reg_w_E, mem_write_w_E, regDst_w_E;
    
    id_ex reg2(.clk(clk), .rst(rst), .data1_w(data1_w), .data2_w(data2_w), .inst_D(inst_D), .imm_out_w(imm_out_w), .pc_D(pc_D), .alu_ctrl_w(alu_ctrl_w), 
                .alu_scr_w(alu_scr_w), .reg_write_w(reg_write_w), .jump_w(jump_w), .branch_w(branch_w), .mem_read_w(mem_read_w), 
                .mem2reg_w(mem2reg_w), .mem_write_w(mem_write_w), .regDst_w(regDst_w), .rd_D(rd_D),
                
                .srcA_E(srcA_E), .srcB_E(srcB_E), .rs2_E(rs2_E), .imm_E(imm_E), .pc_E(pc_E), 
                .alu_ctrl_w_E(alu_ctrl_w_E), .rd_E(rd_E), .alu_scr_w_E(alu_scr_w_E), .reg_write_w_E(reg_write_w_E), 
                .jump_w_E(jump_w_E), .branch_w_E(branch_w_E), .mem_read_w_E(mem_read_w_E), 
                .mem2reg_w_E(mem2reg_w_E), .mem_write_w_E(mem_write_w_E), .regDst_w_E(regDst_w_E)
    );
    //-------------------------------------
        
    //################################## Reg EX/MEM ##################################
    
    //Data2 or Immediate Value as ALU Source input
    mux2 #(.width(32))reg_or_imm(.in0(srcB_E), .in1(imm_E), .sel(alu_scr_w_E), .out(alu_data2_mux));
    
    //ALU_Unit
    alu_unit aluUnit(.alu_ctrl(alu_ctrl_w_E), .data1(srcA_E), .data2(alu_data2_mux), .alu_out(alu_out_w), .zero(zero_w));
    
    //RegDestination 
    mux2 #(.width(5))regDest(.in0(rs2_E), .in1(rd_E), .sel(regDst_w_E), .out(writeReg_w));
    
    //PC shift adder
     addershifted adderShift(.pc_out(pc_E), .imm_out(imm_E), .addsh_out(pc_shift_adder_w));
    
    //-------------------------------------
    wire reg_write_w_M, mem2reg_w_M, mem_write_w_M, branch_w_M, zero_M, mem_read_w_M;
    wire [31:0] alu_out_w_M, srcB_M, pc_shift_adder_w_M;
    wire [4:0] writeRegBack_M;
    
    ex_mem reg3(
    .clk(clk), .rst(rst),
    .reg_write_w_E(reg_write_w_E), .mem2reg_w_E(mem2reg_w_E), .mem_write_w_E(mem_write_w_E), .branch_w_E(branch_w_E), .zero_w(zero_w), .mem_read_w_E(mem_read_w_E),
    .alu_out_w(alu_out_w), .srcB_E(srcB_E), .pc_shift_adder_w(pc_shift_adder_w),
     .writeReg_w(writeReg_w),
    
    .reg_write_w_M(reg_write_w_M), .mem2reg_w_M(mem2reg_w_M), .mem_write_w_M(mem_write_w_M), .branch_w_M(branch_w_M), .zero_M(zero_M), .mem_read_w_M(mem_read_w_M),
    .alu_out_w_M(alu_out_w_M), .srcB_M(srcB_M), .pc_shift_adder_w_M(pc_shift_adder_w_M),
    .writeRegBack_M(writeRegBack_M)
    );
   //-------------------------------------
   
    
    //################################## Reg MEM/WB ##################################
    //Data Memory
    data_mem dataMemory(.alu_out(alu_out_w_M), .data2(srcB_M), .mem_read(mem_read_w_E), .mem_write(mem_write_w_M), .clk(clk), .rst(rst), .dmem_out(mem_out));
       
    // Branch Control 
    andGate branchControl (.a(branch_w_M), .b(zero_M), .c(pc_src));
    
    //-------------------------------------
    wire [31:0] mem_out_wb, alu_out_w_wb;
    wire [4:0] rd_wb;
    wire reg_write_w_wb, mem2reg_w_wb;
    
    mem_wb reg4(
        .clk(clk), .rst(rst),
        .mem_out(mem_out), .alu_out_w_M(alu_out_w_M),
        .writeRegBack_M(writeRegBack_M),
        .reg_write_w_M(reg_write_w_M), .mem2reg_w_M(mem2reg_w_M),
        
        .mem_out_wb(mem_out_wb), .alu_out_w_wb(alu_out_w_wb),
        .rd_wb(rd_wb),
        .reg_write_w_wb(reg_write_w_wb), .mem2reg_w_wb(mem2reg_w_wb)
    );
    //-------------------------------------
    
    
    //################################## Now loop backing from Reg 5 ##################################
     
     //Memory or ALU result
     mux2 #(.width(32))mem_or_alu_read(.in0(alu_out_w_wb), .in1(mem_out_wb), .sel(mem2reg_w_wb), .out(data_writeBack_w));
     

    
    
    
    
    
    
endmodule 
