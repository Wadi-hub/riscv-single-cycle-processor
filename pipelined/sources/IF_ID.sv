module if_id(
    input [31:0] inst_w, pc_out_w,
    input clk, rst,
    output reg [31:0] inst_D, pc_D,
    output reg [4:0] rd_D    
);
    
    always @(posedge clk) begin
        
        if(rst) begin
            inst_D <= 0;
            pc_D <= 0;
            rd_D <= 0;
        end
        else begin
            inst_D <= inst_w;
            rd_D <= inst_w[11:7];
            pc_D <= pc_out_w;
        end
    end
endmodule