module immediate_gen(

    input [31:0] inst,
    output [31:0] imm_out
);
    
    reg [6:0] opcode;
    assign opcode = inst[6:0];
    reg [31:0] imme_out;
    
    always_comb begin
        case (opcode)    
        7'b0010011 , 7'b0000011 : 
        begin
        imme_out[11:0] = {inst[31:20]}; //I-type Instructions (SLLI, ADDI, Lw)
        imme_out[31:12] = $signed(inst[31]);
        end
        7'b0100011  : imme_out = {{20{$signed(inst[31])}}, inst[31:25], inst[11:7]}; // S-type instructions (Sw)
        7'b1100011  : imme_out = {{19{$signed(inst[31])}}, inst[31], inst[7], inst[30:25],inst[11:8], 1'b0}; //B-type intructions (beq)
        7'b1101111  : imme_out = {{12{$signed(inst[31])}} ,inst[31], inst[19:12], inst[20], inst[30:21], 1'b0}; //J-type 
        default : imme_out = 32'b0;
        
        endcase
    end
    
    assign imm_out = imme_out;
endmodule 

//1101100 0000000000 000 0100 1 110011