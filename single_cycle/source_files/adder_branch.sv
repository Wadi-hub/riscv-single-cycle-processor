module branch_adder(
    
    input  [31:0] pc_out, imm_out, 
    output reg [31:0] addsh_out   // = pc_out + imm_out 
);

    
    always @(*)
    begin
        addsh_out = pc_out + imm_out;
    end
endmodule