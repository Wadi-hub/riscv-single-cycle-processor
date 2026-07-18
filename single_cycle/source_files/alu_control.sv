module alu_control(
    input [1:0] alu_op,
    input [31:0] inst,
    output reg [3:0] alu_ctrl
);
    
    wire func7_bit_30;
    wire [2:0] func3;
    
    assign func7_bit_30 = inst[30];
    assign func3 = inst[14:12];
    
    always_comb begin
        case(alu_op)
            2'b00 : alu_ctrl = 4'b0010;               // lw/sw -> add
            2'b01 : alu_ctrl = 4'b0110;               // beq -> subtract
            2'b10, 2'b11 :                            // R-type or I-type -> decode via funct3/funct7
                case({func7_bit_30, func3})
                    4'b0000 : alu_ctrl = 4'b0010; // ADD
                    4'b1000 : alu_ctrl = 4'b0110; // SUB
                    4'b0111 : alu_ctrl = 4'b0000; // AND
                    4'b0110 : alu_ctrl = 4'b0001; // OR
                    4'b0010 : alu_ctrl = 4'b0111; // SLT
                    4'b0001 : alu_ctrl = 4'b0100; // SLL / SLLI
                    default : alu_ctrl = 4'd0;
                endcase
            default : alu_ctrl = 4'd0;
        endcase
    end
endmodule