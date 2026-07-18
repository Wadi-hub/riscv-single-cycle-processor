module control_path (
    input  [31:0] inst,
    output reg branch, mem_rd, mem2reg, mem_write, alu_scr, reg_write,
    output reg [1:0] alu_op
);

    wire [6:0] opcode = inst[6:0];

    always @(*) begin
        case (opcode)
            7'b0110011: begin // R-type (add, sub, and, or, slt...)
                branch    = 1'b0;
                mem_rd    = 1'b0;
                mem2reg   = 1'b0;
                mem_write = 1'b0;
                alu_scr   = 1'b0;
                reg_write = 1'b1;
                alu_op    = 2'b10;
            end
            7'b0010011: begin // I-type ALU (addi, slli, andi, ori, slti...)
                branch    = 1'b0;
                mem_rd    = 1'b0;
                mem2reg   = 1'b0;
                mem_write = 1'b0;
                alu_scr   = 1'b1;   // second operand = immediate
                reg_write = 1'b1;
                alu_op    = 2'b11;  // new alu_op code: "decode from funct3 (I-type)"
            end
            7'b0000011: begin // lw
                branch    = 1'b0;
                mem_rd    = 1'b1;
                mem2reg   = 1'b1;
                mem_write = 1'b0;
                alu_scr   = 1'b1;
                reg_write = 1'b1;
                alu_op    = 2'b00;
            end
            7'b0100011: begin // sw
                branch    = 1'b0;
                mem_rd    = 1'b0;
                mem2reg   = 1'bx;   // don't care, no writeback
                mem_write = 1'b1;
                alu_scr   = 1'b1;
                reg_write = 1'b0;
                alu_op    = 2'b00;
            end
            7'b1100011: begin // beq
                branch    = 1'b1;
                mem_rd    = 1'b0;
                mem2reg   = 1'bx;   // don't care, no writeback
                mem_write = 1'b0;
                alu_scr   = 1'b0;
                reg_write = 1'b0;
                alu_op    = 2'b01;
            end
            default: begin
                branch    = 1'bx;
                mem_rd    = 1'bx;
                mem2reg   = 1'bx;
                mem_write = 1'bx;
                alu_scr   = 1'bx;
                reg_write = 1'bx;
                alu_op    = 2'bxx;
            end
        endcase
    end

endmodule