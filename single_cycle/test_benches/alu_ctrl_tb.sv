`timescale 1ns/1ps

module alu_control_tb;

    reg  [1:0]  alu_op;
    reg  [31:0] inst;
    wire [3:0]  alu_ctrl;

    alu_control dut (
        .alu_op(alu_op),
        .inst(inst),
        .alu_ctrl(alu_ctrl)
    );

    initial begin
        // lw/sw -> add
        alu_op = 2'b00; inst = 32'b0;
        #10 $display("alu_op=00 -> alu_ctrl=%b", alu_ctrl);

        // branch -> subtract
        alu_op = 2'b01; inst = 32'b0;
        #10 $display("alu_op=01 -> alu_ctrl=%b", alu_ctrl);

        // R-type ADD (func7_30=0, func3=000)
        alu_op = 2'b10; inst = 32'b0;
        #10 $display("R-type ADD -> alu_ctrl=%b", alu_ctrl);

        // R-type SUB (func7_30=1, func3=000)
        alu_op = 2'b10; inst = 32'b0; inst[30] = 1'b1;
        #10 $display("R-type SUB -> alu_ctrl=%b", alu_ctrl);

        // R-type AND (func3=111)
        alu_op = 2'b10; inst = 32'b0; inst[14:12] = 3'b111;
        #10 $display("R-type AND -> alu_ctrl=%b", alu_ctrl);

        // R-type OR (func3=110)
        alu_op = 2'b10; inst = 32'b0; inst[14:12] = 3'b110;
        #10 $display("R-type OR -> alu_ctrl=%b", alu_ctrl);

        $finish;
    end

endmodule