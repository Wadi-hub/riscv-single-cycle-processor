module registerData 
( 
input  [31:0] inst, 
input  write_en, reset, clk, 
input  [31:0] data_w, 
output [31:0] data1, data2 
); 
    
    wire [4:0] rs1, rs2, rd;
    reg [31:0] reg_file [0:31];
    
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd = inst[11:7];

    always @(posedge clk) begin
        if(reset) begin
            for(int i=0;i < 32;i++)
                reg_file[i] <= 32'b0;
         end
    end
    
    always @(negedge clk) begin
        if(write_en && rd != 0) begin
            reg_file[rd] <= data_w;        
        end
    end
    
    assign data1 = reg_file[rs1];
    assign data2 = reg_file[rs2];
    
        
endmodule