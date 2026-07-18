module mux2 #(parameter width = 8)(
    
    input [width-1:0] in0, in1,
    input sel,
    output reg [width-1:0] out
    );
    
    always @(*) begin
        case (sel)
            1'b0 : out = in0;
            1'b1 : out = in1;
            
            default out = {width{1'bx}};
        endcase
    end
    
endmodule