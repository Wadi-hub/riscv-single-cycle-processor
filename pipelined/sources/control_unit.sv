module control_path 
( 
input  [31:0] inst, 
output reg branch, mem_rd, mem2reg, mem_write, alu_scr, reg_write, jump, regDst,
output reg [1:0] alu_op 
);

    wire [6:0]opcode;
    assign opcode = inst[6:0];
    
    always @(inst)
    begin
        case (opcode)
            7'b0110011:    //opcode for R-type instructions
                    begin
                          alu_scr=0;
                          mem2reg=0;
                          reg_write=1;
                          mem_rd=0;
                          mem_write=0;
                          branch=0;
                          jump=0;
                          regDst=1;
                          alu_op=2'b10;
                    end
            7'b0010011:     //opcode for addi/slli  instructions
                    begin
                          alu_scr=1;
                          mem2reg=0;
                          reg_write=1;
                          mem_rd=0;
                          mem_write=0;
                          branch=0;
                          jump=0;
                          regDst=1;
                          alu_op=2'b10; 
                    end
            7'b0000011:    //opcode for  lw instructions
                    begin
                          alu_scr=1;
                          mem2reg=1;
                          reg_write=1;
                          mem_rd=1;
                          mem_write=0;
                          branch=0;
                          jump=0;
                          regDst=1;
                          alu_op=2'b00; 
                    end     
            7'b0100011:    //opcode for sw instructions
                    begin
                         alu_scr=1;
                          mem2reg=1'b0;
                          reg_write=0;
                          mem_rd=0;
                          mem_write=1;
                          branch=0;
                          jump=0;
                          regDst=0;
                          alu_op=2'b00;
                    end
            7'b1100011:  begin     // for branch
                          alu_scr=1'b0;
                          mem2reg=1'b0;
                          reg_write=1'b0;
                          mem_rd=1'b0;
                          mem_write=1'b0;
                          branch=1'b1;
                          jump=0;
                          regDst=0;
                          alu_op=2'b01;
                    end
            7'b1101111:  begin     // for jump
                          alu_scr=1'b0;
                          mem2reg=1'b?;
                          reg_write=1'b0;
                          mem_rd=1'b0;
                          mem_write=1'b0;
                          branch=1'b0;
                          jump=1'b1;
                          regDst=1;
                          alu_op<=2'b00;
                    end
            default : begin
                alu_scr=0;
                mem2reg=0;
                reg_write=0;
                mem_rd=0;
                mem_write=0;
                branch=0;
                jump=0;
                regDst=0;
                alu_op=2'b00;
            end
         endcase
     end
endmodule