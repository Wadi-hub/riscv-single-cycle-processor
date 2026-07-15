module wrapper(
    
    input clk, rst
);
    
    wire [31:0] mux_out_pc_in_w, pc_out_w, adder_pc_4_w, adder_pc_branch_w, dmem_out_w, alu_src2;
    wire [31:0]  imm_out_w, inst_w, data_write_back, data1_w, data2_w, alu_out_w;
    wire [3:0] alu_ctrl_w;
    wire [1:0] alu_op_w;
    wire pc_src_w, branch_w, mem_rd_w, mem2reg_w, mem_write_w, alu_scr_w, reg_write_w, zero_w;
    
    
    //************************Program Counter Implementation*****************************************//
    
    //Program Counter
    pc program_counter(.mux_out(mux_out_pc_in_w), .clk(clk), .reset(rst), .pc_out(pc_out_w));
    
    //Pc + 4 Adder
    adder32 pc_adder(.a(pc_out_w), .b(32'd4), .sum(adder_pc_4_w));
    
    //Branch Adder
    branch_adder branchAdder(.pc_out(pc_out_w), .imm_out(imm_out_w), .addsh_out(adder_pc_branch_w));
    
    //PC source Mux 
    mux2to1 #(.WIDTH(32))pc_or_branch(.in0(adder_pc_4_w), .in1(adder_pc_branch_w), .sel(pc_src_w), .out(mux_out_pc_in_w));
    
    //Branch taken Control Signal
    andGate branch(.a(zero_w), .b(branch_w), .c(pc_src_w));
            
    //*******************************Instruction Memory*************************************
    
    instructionMemory instMem(.pc_out(pc_out_w), .inst(inst_w));
    
    //*************************8*****Register File******************************************
    
    registerData regFile(.inst(inst_w), .write_en(reg_write_w), .reset(rst), .clk(clk), .data_w(data_write_back), .data1(data1_w), .data2(data2_w));
    
    //*********************************Control Signals**************************************
    
    control_path controlSignal(.inst(inst_w), .branch(branch_w), .mem_rd(mem_rd_w), .mem2reg(mem2reg_w), .mem_write(mem_write_w), .alu_scr(alu_scr_w), .reg_write(reg_write_w), .alu_op(alu_op_w));
    
    //**********************************ALU Unit*********************************************
    
    //ALU Control
    alu_control aluControl(.alu_op(alu_op_w), .inst(inst_w), .alu_ctrl(alu_ctrl_w));
    
    // ALU Unit
    alu aluUnit(.alu_ctrl(alu_ctrl_w), .data1(data1_w), .data2(alu_src2), .alu_out(alu_out_w), .Zero(zero_w));
    
    //Immediate Generator
    immediateGenerator immGen(.inst(inst_w), .immout(imm_out_w));
    
    //Data Memory
    data_memory datamem(.alu_out(alu_out_w), .data2(data2_w), .mem_write(mem_write_w), .mem_read(mem_rd_w), .clk(clk), .reset(rst), .dmem_out(dmem_out_w));
    
    //Mux Memory or alu result to rd
     mux2to1 #(.WIDTH(32))mem_or_alu(.in0(alu_out_w), .in1(dmem_out_w), .sel(mem2reg_w), .out(data_write_back));
     
     //Mux rs2 or immediate to input 2 of ALU
     mux2to1 #(.WIDTH(32))rs2_or_imm(.in0(data2_w), .in1(imm_out_w), .sel(alu_scr_w), .out(alu_src2));
endmodule