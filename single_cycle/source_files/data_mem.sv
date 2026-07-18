module data_memory (
    input  [31:0] alu_out,   // address
    input  [31:0] data2,     // write data (for SW)
    input         mem_write,
    input         mem_read,
    input         clk,
    input         reset,
    output [31:0] dmem_out
);

    // 32-bit word-addressed memory, 64 words deep (adjust size as needed)
    reg [31:0] mem [0:63];

    integer i;

    // Synchronous write, synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 64; i = i + 1)
                mem[i] <= 32'b0;
        end
        else if (mem_write) begin
            mem[alu_out[7:2]] <= data2;  // word-aligned, ignore lower 2 bits
        end
    end

    // Combinational read
    assign dmem_out = mem_read ? mem[alu_out[7:2]] : 32'b0;

endmodule