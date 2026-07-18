module alu_unit(
    
    input [3:0] alu_ctrl,
    input [31:0] data1, data2,
    output reg [31:0] alu_out,
    output zero    
);
    
    // alu_ctrl: 0=AND 1=OR 2=ADD 6=SUB 7=SLT 8=SGT 12=NOR 
        
    always @(*) begin
        case (alu_ctrl)
            4'd0 : alu_out = data1 & data2; //AND
            4'd1 : alu_out = data1 | data2; //OR
            4'd2 : alu_out = data1 + data2; //ADD
            4'd4 : alu_out = data1 << data2[4:0]; //SLL
            4'd6 : alu_out = data1 - data2; //SUB
            4'd7 : alu_out = $unsigned(data1) < $unsigned(data2) ? 32'hffffffff : 32'h00000000; //SLT
            4'd8 : alu_out = $unsigned(data1) > $unsigned(data2) ? '1 : 32'b00000000; //SGT 
            4'd12 : alu_out =  ~(data1 + data2); //NOR
            default : alu_out = 32'b0;
        endcase
    end
    
    assign zero = (alu_out == 32'd0) ? 1'b1 : 1'b0;
endmodule 