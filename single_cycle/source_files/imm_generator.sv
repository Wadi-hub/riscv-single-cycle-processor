module immediateGenerator 
( 
input  [31:0] inst, 
output reg [31:0] immout 
); 
    
    wire [6:0] opcode;
    assign opcode = inst[6:0];
    
    always_comb begin
        
        case (opcode)
            7'b0010011 , 7'b0000011 : immout = {{20{$signed(inst[31])}}, inst[31:20]}; //I-type (arithmetic + load)
            7'b0100011 : immout = {{20{$signed(inst[31])}}, inst[31:25], inst[11:7]}; //S-type
            7'b1100011 : immout = {{19{$signed(inst[31])}}, inst[31],inst[7], inst[30:25], inst[11:8], 1'b0}; //B-type
            default : immout = 32'b0;
        endcase
    end
endmodule 