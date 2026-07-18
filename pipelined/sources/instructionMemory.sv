module instructionMemory 
  ( 
  input wire [31:0] pc_out,
  output wire [31:0] inst
  );
    reg [31:0] data[0:160];
    reg [31:0] mid;
    
    always_comb begin
        
        data[0] = 32'b00000000101000000000000010010011;  //addi x1, x0, 10
        data[4] = 32'b00000001010000000000000100010011;  //addi x2, x0, 20
        data[8] = 32'b00000001111000000000000110010011;  //addi x3, x0, 30
        data[12] = 32'b00000010100000000000001000010011; //addi x4, x0, 40
        data[16] = 32'b00001010101100000000001010010011; //addi x5, x0, 0xab
        data[20] = 32'b00000000000000000000000000010011; //nop

    end
    
        always @(pc_out) begin 
            mid = data[pc_out];
        end
        
        assign inst = mid;  
    
endmodule 
