`timescale 1ns/1ps

module branch_adder_tb;

    reg  [31:0] pc_out, imm_out;
    wire [31:0] addsh_out;

    branch_adder DUT (
        .pc_out(pc_out),
        .imm_out(imm_out),
        .addsh_out(addsh_out)
    );

    initial begin
        pc_out = 32'd0;    imm_out = 32'd4;    #10; // small forward branch
        pc_out = 32'd100;  imm_out = 32'd8;    #10; // forward branch mid-program
        pc_out = 32'd100;  imm_out = -32'd8;   #10; // backward branch (negative imm)
        pc_out = 32'd0;    imm_out = 32'd0;    #10; // zero offset edge case
        pc_out = 32'hFFFFFFF0; imm_out = 32'd4; #10; // near-overflow edge case

        $finish;
    end

    initial
        $monitor("t=%0t pc_out=%h imm_out=%0d addsh_out=%h", 
                  $time, pc_out, $signed(imm_out), addsh_out);

endmodule