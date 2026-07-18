module reg_file(
    
    input [31:0] inst,
    input [31:0] data_write,
    input [4:0] rd,
    input clk, write_en, rst, 
    output [31:0] data1, data2
);
    reg [31:0] reg_files [0:31];
    
    wire [4:0] rs1, rs2;
    
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    
    integer i;
    always @(posedge clk) begin
        if(rst) begin
            for(i = 0; i < 32; i++) begin
                reg_files[i] <= 32'b0;
            end
        end
//        else begin
//            reg_files[00000] <= 32'd05;
//            reg_files[00001] <= 32'd10;
//            //reg_files[00002] <= 32'd20;
//            reg_files[00003] <= 32'd30; 
//        end
         
   end
  
   always @(negedge clk) begin
       if(write_en)
            reg_files[rd] = data_write;
   end
   
   assign data1 = reg_files[rs1];
   assign data2 = reg_files[rs2];
   
    
endmodule