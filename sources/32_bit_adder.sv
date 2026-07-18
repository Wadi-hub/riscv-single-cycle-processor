module param_adder #(parameter width = 32) (
    
    input [width-1:0] in0, in1,
    output [width-1:0] out
);
    
    assign {cout, out} = in0 + in1;

endmodule