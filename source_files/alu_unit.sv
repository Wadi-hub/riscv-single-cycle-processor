module alu (
    input  [3:0]  alu_ctrl,
    input  [31:0] data1,
    input  [31:0] data2,
    output reg [31:0] alu_out,
    output        Zero
);

    always @(*) begin
        case (alu_ctrl)
            4'd0:  alu_out = data1 & data2;              // AND
            4'd1:  alu_out = data1 | data2;              // OR
            4'd2:  alu_out = data1 + data2;              // ADD
            4'd4:  alu_out = data1 << data2[4:0];        // SLL / SLLI
            4'd6:  alu_out = data1 - data2;              // SUB
            4'd7:  alu_out = ($signed(data1) < $signed(data2)) ? 32'd1 : 32'd0; // SLT
            4'd8:  alu_out = ($signed(data1) > $signed(data2)) ? 32'd1 : 32'd0; // SGT
            4'd12: alu_out = ~(data1 | data2);           // NOR
            default: alu_out = 32'bx;
        endcase
    end

    assign Zero = (alu_out == 32'd0);

endmodule